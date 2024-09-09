import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile_ver/main.dart' as main;

import 'ApiHandler/purchaseOrderApi.dart';
import 'components/datePicker.dart' as datePicker;

import 'appbar.dart';

class SOAPage extends StatefulWidget {
  String? Supplier;
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  late Future getSuplrs_obj = getSuplrs();
  late Future getPOSs = getPOSOA(Supplier.toString(), fromDate,toDate,paymentStatus.toString());
  String? paymentStatus;




  @override
  State<SOAPage> createState() => _SOAPageState();
}

class _SOAPageState extends State<SOAPage> {



  OnDateChange(val) {
    setState(() {
      widget.fromDate = val;

      widget.getPOSs = getPOSOA(widget.Supplier.toString(), widget.fromDate,widget.toDate,widget.paymentStatus.toString());
    });
  }


  void OnDateChange2(val) {
    setState(() {
      widget.toDate = val;
    });
  }

  Future<void> submitForm(BuildContext context) async {
    var fromDate = DateFormat("dd-MM-y").format(widget.fromDate);
    var toDate = DateFormat("dd-MM-y").format(widget.toDate);
    Map<String, String> body = {
      'fromDate': fromDate,
      'toDate': toDate,
      'suplCode': widget.Supplier.toString(),
      'paymentStatus': widget.paymentStatus.toString(),
    };
    print(body);

  }

  void _payNow(){

  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Column(
            children: [
              AppBarCustom("PO SOA", Size(double.infinity, 300), () {}),
              SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FutureBuilder(
                        future: widget.getSuplrs_obj,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            Map map = snapshot.data as Map;
                            print(map);
                            List suppliers = map['suplrs'] as List;
                            return DropdownButtonFormField(
                              value: widget.Supplier,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.numbers),
                                fillColor: Colors.white,
                                filled: true,
                                labelText: "Supplier",
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(23030, 23, 32, 49),
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                              items: [
                                DropdownMenuItem(child: Text("All"), value: "all")
                              ] +
                                  suppliers.map<DropdownMenuItem<String>>((e) {
                                    return DropdownMenuItem(
                                      child: Text(e[0].toString()),
                                      value: e[1].toString(),
                                    );
                                  }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  print('drop down changed');
                                  print(val);
                                  widget.Supplier = val.toString();
                                });
                              },
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                      SizedBox(height: 20),
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

                      DropdownButtonFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.numbers),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "Payment Status",
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(23030, 23, 32, 49),
                                      style: BorderStyle.solid))),
                          value: widget.paymentStatus,
                          items: [
                            DropdownMenuItem(
                                value: "Choose",
                                child: Text("Choose")),
                            DropdownMenuItem(
                                value: "Pending",
                                child: Text("Pending")),
                            DropdownMenuItem(
                                value: "Inv Not Sent",
                                child: Text("Inv Not Sent")),
                            DropdownMenuItem(
                                value: "Received",
                                child: Text("Received")),
                            DropdownMenuItem(
                                value: "Partial",
                                child: Text("Partial")),
                            DropdownMenuItem(
                                value: "Waiver",
                                child: Text("Waiver")),
                          ],
                          onChanged: (val) {
                            setState(() {
                              widget.paymentStatus = val.toString();
                              widget.getPOSs = getPOSOA(widget.Supplier.toString(),
                                  widget.fromDate,widget.toDate,widget.paymentStatus.toString());
                            });
                          }),
                      SizedBox(
                        height: 5,
                      ),
                      FutureBuilder(
                        future: widget.getPOSs,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List map = snapshot.data as List;
                            return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Container(
                                color: Colors.white,
                                constraints: BoxConstraints(
                                  maxHeight:
                                  MediaQuery.of(context).size.height * 0.5,
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    columns: const [
                                      DataColumn(label: Text('PO Number')),
                                      DataColumn(label: Text('Amount')),
                                      DataColumn(label: Text('Payment Status')),
                                      DataColumn(label: Text('Paid Amount')),
                                      DataColumn(label: Text('')),
                                    ],
                                    rows: map.map<DataRow>((e) {
                                      return DataRow(cells: [
                                        DataCell(Text(e['InvNum'].toString())),
                                        DataCell(Text(e['amt'].toString())),
                                        DataCell(Text(e['payStat'].toString())),
                                        DataCell(Text(e['recAmt'].toString())),
                                        DataCell(Center(child: InkWell(
                                          onTap: _payNow,
                                          child: Text("Pay Now", style: TextStyle(color: Colors.red),),
                                        ),))
                                      ]);
                                    }).toList(),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Text("");
                          }
                        },
                      ),
                      SizedBox(height: 20),

                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
