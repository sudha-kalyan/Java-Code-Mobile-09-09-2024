import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_ver/appbar.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart' as per;
import 'package:mobile_ver/main.dart';
import 'ApiHandler/purchaseOrderApi.dart';
import 'components/popUpMessage.dart';
import 'components/datePicker.dart' as datePicker;

class PurchaseOrderPdfPage extends StatefulWidget {
  String? Supplier = null;
  DateTime date = DateTime.now();
  late Future getSuplrs_obj = getSuplrs();
  late Future getPOSs = getPOS(Supplier.toString(), date, InvType.toString());
  String? InvType;
  String? InvNum;

  bool ifBanner = true;
  @override
  State<PurchaseOrderPdfPage> createState() => _PurchaseOrderPdfPageState();
}

class _PurchaseOrderPdfPageState extends State<PurchaseOrderPdfPage> {
  Future<File> _storeFilePDF(String filename, List<int> bytes) async {
    Directory dr = Directory('/storage/');

    await per.Permission.storage.request();
    String? dir = await FilePicker.platform.getDirectoryPath();

    final File file = File('${dir}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  OnDateChange(val) {
    setState(() {
      widget.date = val;
      widget.getPOSs = getPOS(
          widget.Supplier.toString(), widget.date, widget.InvType.toString());
    });
  }

  Future<File?> fetchPDF(context) async {
    var date = DateFormat("dd-MM-y").format(widget.date);
    Map<String, String> body = {
      'date': date,
      'suplCode': widget.Supplier.toString(),
      'invType': widget.InvType.toString(),
      'invNum': widget.InvNum.toString(),
      'ifBanner': widget.ifBanner.toString(),
    };
    print(body);
    final http.Response response = await http.post(
        Uri.parse("${main_url}getPOPDF/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body));
    if (response.body.isNotEmpty) {
      return _storeFilePDF(
          date.toString() + widget.Supplier.toString() + '.pdf',
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
          child: Column(children: [
        AppBarCustom("PurchaseOrderPdf", Size(double.infinity, 50), () {}),
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
                    "PO PDF Invoice",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
                  Container(
                    height: 2,
                    color: Colors.white,
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
                                  color: Color.fromARGB(23030, 23, 32, 49),
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
                          widget.getPOSs = getPOS(widget.Supplier.toString(),
                              widget.date, val.toString());
                        });
                      }),
                  SizedBox(
                    height: 5,
                  ),
                  FutureBuilder(
                      future: widget.getSuplrs_obj,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data);
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  23030, 23, 32, 49),
                                              style: BorderStyle.solid))),
                                  items: suppliers
                                      .map<DropdownMenuItem<String>>((e) {
                                    return DropdownMenuItem(
                                        child: Text(e[0].toString()),
                                        value: e[1].toString());
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      widget.Supplier = val.toString();
                                      widget.getPOSs = getPOS(
                                          val.toString(),
                                          widget.date,
                                          widget.InvType.toString());
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
                  GestureDetector(
                    onTap: () => datePicker.showDatePicker(
                        context, OnDateChange, widget.date),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white),
                      child: Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_month),
                              Text(
                                "From Date: ",
                                style: TextStyle(fontSize: 25),
                              ),
                              Text(
                                DateFormat('dd-MM-yyyy')
                                    .format(widget.date)
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
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white),
                    child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Image banner: ",
                              style: TextStyle(fontSize: 20),
                            ),
                            Checkbox(
                                value: widget.ifBanner,
                                onChanged: (bool? val) {
                                  setState(() {
                                    widget.ifBanner = val as bool;
                                  });
                                })
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FutureBuilder(
                      future: widget.getPOSs,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data);
                          List map = snapshot.data as List;
                          print(map);
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
                              return SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      50 /
                                      100,
                                  child: Column(
                                    children: [
                                      DropdownButtonFormField(
                                          decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.numbers),
                                              fillColor: Colors.white,
                                              filled: true,
                                              labelText:
                                                  "Invoice Number To appear on pdf",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30)),
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          23030, 23, 32, 49),
                                                      style:
                                                          BorderStyle.solid))),
                                          value: widget.InvNum,
                                          items: map
                                              .map<DropdownMenuItem<String>>(
                                                  (e) => DropdownMenuItem(
                                                      value: e["InvNum"]
                                                          .toString()
                                                          ,
                                                      child: Text(
                                                        e["InvNum"]
                                                            .toString()
                                                           ,
                                                      )))
                                              .toList(),
                                          onChanged: (val) {
                                            setState(() {
                                              widget.InvNum = val.toString();
                                            });
                                          }),
                                      Container(
                                        color: Colors.white,
                                        child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: DataTable(
                                              columns: const [
                                                DataColumn(
                                                  label: Text('Invoice Number'),
                                                ),
                                                DataColumn(
                                                    label: Text('Tmode')),
                                                DataColumn(
                                                    label: Text('Vehicle')),
                                                DataColumn(
                                                    label: Text('Milk Type')),
                                                DataColumn(
                                                    label: Text('Quantity')),
                                                DataColumn(
                                                    label: Text('Units')),
                                                DataColumn(label: Text('Fat')),
                                                DataColumn(label: Text('SNF')),
                                                DataColumn(
                                                    label: Text('TS Rate')),
                                                DataColumn(
                                                    label: Text('LTR Rate')),
                                                DataColumn(
                                                    label: Text('Amount')),
                                                DataColumn(
                                                    label: Text('PoRefNo')),
                                                DataColumn(
                                                    label: Text('PoRefDate')),
                                                DataColumn(
                                                    label:
                                                        Text('Payment Status')),
                                                DataColumn(
                                                    label: Text('Bank Ref No')),
                                                DataColumn(label: Text('Bank')),
                                                DataColumn(
                                                    label:
                                                        Text('Received Date')),
                                                DataColumn(
                                                    label: Text(
                                                        'Received Amount')),
                                              ],
                                              rows: map
                                                  .map<DataRow>((e) =>
                                                      DataRow(cells: [
                                                        DataCell(Text(
                                                            e['InvNum']
                                                                .toString())),
                                                        DataCell(Text(e['Tmode']
                                                            .toString())),
                                                        DataCell(Text(
                                                            e['vehicle']
                                                                .toString())),
                                                        DataCell(Text(
                                                            e['milkType']
                                                                .toString())),
                                                        DataCell(Text(e['qty']
                                                            .toString())),
                                                        DataCell(Text(e['unit']
                                                            .toString())),
                                                        DataCell(Text(e['fat']
                                                            .toString())),
                                                        DataCell(Text(e['snf']
                                                            .toString())),
                                                        DataCell(Text(
                                                            e['tsRate']
                                                                .toString())),
                                                        DataCell(Text(
                                                            e['ltrRate']
                                                                .toString())),
                                                        DataCell(Text(e['amt']
                                                            .toString())),
                                                        DataCell(Text(
                                                            e['porefno']
                                                                .toString())),
                                                        DataCell(Text(
                                                            e['porefdate']
                                                                .toString())),
                                                        DataCell(Text(
                                                            e['payStat']
                                                                .toString())),
                                                        DataCell(Text(
                                                            e['bankrefno']
                                                                .toString())),
                                                        DataCell(Text(e['bank']
                                                            .toString())),
                                                        DataCell(Text(
                                                            e['recvDate']
                                                                .toString())),
                                                        DataCell(Text(
                                                            e['recAmt']
                                                                .toString())),
                                                      ]))
                                                  .toList(),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                          }
                        } else {
                          return Text("Select Supplier And Date");
                        }
                        return Text("Select Supplier And Date");
                      }),
                ],
              ),
            )),
        GestureDetector(
          onTap: () async {
            if (widget.InvNum != null) {
              final File pdf = await fetchPDF(context) as File;
              print("@pdf");
              OpenFile.open(pdf.path);
              popUpMsg("Successfully Downloaded at : " + pdf.path, Colors.green,
                  context, "Success");
            } else {
              popUpMsg("Select Invoice Number From Above ", Colors.red, context,
                  "Error");
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              color: Color.fromARGB(255, 54, 103, 166),
            ),
            height: 60,
            width: 80 / 100 * MediaQuery.of(context).size.width,
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Download PDF",
                  style: TextStyle(color: Colors.white, fontSize: 30),
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
      ])),
    );
  }
}
