import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_ver/appbar.dart';
import 'package:mobile_ver/components/popUpMessage.dart';
import 'ApiHandler/purchaseOrderApi.dart';
import 'components/datePicker.dart' as datePicker;
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart' as per;
import 'package:open_file/open_file.dart';

import 'package:file_picker/file_picker.dart';

import 'main.dart';

class PODownloadPage extends StatefulWidget {
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  String? Supplier;
  late Future getSuplrs_obj = getSuplrs();

  String? InvType;

  @override
  State<PODownloadPage> createState() => _PODownloadPageState();
}

class _PODownloadPageState extends State<PODownloadPage> {
  bool isLoading = false;

  void OnDateChange(val) {
    setState(() {
      widget.fromDate = val;
    });
  }

  void OnDateChange2(val) {
    setState(() {
      widget.toDate = val;
    });
  }

  Future<File> _storeFileCSV(String filename, List<int> bytes) async {
    Directory dr = Directory('/storage/');

    await per.Permission.storage.request();
    String? dir = await FilePicker.platform.getDirectoryPath();

    final File file = File('${dir}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  Future<File?> fetchCSV(context) async {
    var datefrom = DateFormat("dd-MM-y").format(widget.fromDate);
    var dateto = DateFormat("dd-MM-y").format(widget.toDate);
    Map<String, String> body = {
      'todate': dateto,
      'fromdate': datefrom,
      'suplCode': widget.Supplier.toString(),
      'invType': widget.InvType.toString(),
    };
    print(body);
    final http.Response response = await http.post(
        Uri.parse("${main_url}getPOExcel/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body));
    if (response.body.isNotEmpty) {
      return _storeFileCSV(
          datefrom.toString() +
              "-" +
              dateto.toString() +
              "-" +
              widget.Supplier.toString() +
              '.xlsx',
          response.bodyBytes);
    } else {
      return null;
    }
  }

  Future<File> _storeFilePDF(String filename, List<int> bytes) async {
    Directory dr = Directory('/storage/');

    await per.Permission.storage.request();
    String? dir = await FilePicker.platform.getDirectoryPath();

    final File file = File('${dir}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  Future<File?> fetchPDF(context) async {
    var datefrom = DateFormat("dd-MM-y").format(widget.fromDate);
    var dateto = DateFormat("dd-MM-y").format(widget.toDate);
    Map<String, String> body = {
      'todate': dateto,
      'fromdate': datefrom,
      'suplCode': widget.Supplier.toString(),
    };
    print(body);
    final http.Response response = await http.post(
        Uri.parse("${main_url}getPOPDF/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body));
    if (response.body.isNotEmpty) {
      return _storeFileCSV(
          datefrom.toString() +
              "-" +
              dateto.toString() +
              "-" +
              widget.Supplier.toString() +
              '.pdf',
          response.bodyBytes);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Column(
          children: [
            AppBarCustom("PO Downloads", Size(double.infinity, 50), () {}),
            Container(
                width: 80 / 100 * MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                              child: Text(
                            "PO Excel Download",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          )),
                          Container(
                            height: 2,
                            color: Colors.white,
                          ),
                          FutureBuilder(
                              future: widget.getSuplrs_obj,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  Map map = snapshot.data as Map;
                                  print(map);
                                  List suppliers = map['suplrs'] as List;
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.none:
                                      // TODO: Handle this case.
                                      break;
                                    case ConnectionState.waiting:
                                      return CircularProgressIndicator();
                                      break;
                                    case ConnectionState.active:
                                      // TODO: Handle this case.
                                      break;
                                    case ConnectionState.done:
                                      return DropdownButtonFormField(
                                          value: widget.Supplier,
                                          decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.numbers),
                                              fillColor: Colors.white,
                                              filled: true,
                                              labelText: "Supplier",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30)),
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          23030, 23, 32, 49),
                                                      style:
                                                          BorderStyle.solid))),
                                          items: [
                                                DropdownMenuItem(
                                                    child: Text("All"),
                                                    value: "all")
                                              ] +
                                              suppliers.map<
                                                      DropdownMenuItem<String>>(
                                                  (e) {
                                                return DropdownMenuItem(
                                                    child:
                                                        Text(e[0].toString()),
                                                    value: e[1].toString());
                                              }).toList(),
                                          onChanged: (val) {
                                            setState(() {
                                              widget.Supplier = val.toString();
                                            });
                                          });
                                  }
                                } else {
                                  return CircularProgressIndicator();
                                }
                                return CircularProgressIndicator();
                              }),
                          SizedBox(
                            height: 5,
                          ),

                          DropdownButtonFormField(
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.numbers),
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelText: "Invoice Type",
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(23030, 23, 32, 49),
                                          style: BorderStyle.solid))),
                              value: widget.InvType,
                              items: [
                                DropdownMenuItem(
                                    value: "Tax(Sale)Invoice",
                                    child: Text("Tax(Sale) Invoice")),
                                DropdownMenuItem(
                                    value: "POInvoice",
                                    child: Text("Purchase Invoice")),
                              ],
                              onChanged: (val) {
                                setState(() {
                                  widget.InvType = val.toString();
                                });
                              }),
                          SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            onTap: () => datePicker.showDatePicker(
                                context, OnDateChange, widget.fromDate),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  color: Colors.white),
                              child: Center(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.calendar_month),
                                      Text(
                                        "From Date: ",
                                        style: TextStyle(fontSize: 25),
                                      ),
                                      Text(
                                        DateFormat('dd-MM-yyyy')
                                            .format(widget.fromDate)
                                            .toString(),
                                        style: TextStyle(fontSize: 15),
                                      )
                                    ]),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            onTap: () => datePicker.showDatePicker(
                                context, OnDateChange2, widget.toDate),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  color: Colors.white),
                              child: Center(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.calendar_month),
                                      Text(
                                        "To Date: ",
                                        style: TextStyle(fontSize: 25),
                                      ),
                                      Text(
                                        DateFormat('dd-MM-yyyy')
                                            .format(widget.toDate)
                                            .toString(),
                                        style: TextStyle(fontSize: 15),
                                      )
                                    ]),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final File csv = await fetchCSV(context) as File;
                              print("@csv");
                              OpenFile.open(csv.path);
                              popUpMsg(
                                  "Successfully Downloaded at : " + csv.path,
                                  Colors.green,
                                  context,
                                  "Success");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                color: Color.fromARGB(255, 54, 103, 166),
                              ),
                              height: 60,
                              width: 1 / 2 * MediaQuery.of(context).size.width,
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Download",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  ),
                                  Icon(
                                    Icons.arrow_right,
                                    size: 30,
                                    color: Colors.white,
                                  )
                                ],
                              )),
                            ),
                          ),
                        ])))
          ],
        ),
      ),
    );
  }
}
