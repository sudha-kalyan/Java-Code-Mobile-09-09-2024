import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile_ver/main.dart' as main;


import 'ApiHandler/saleOrderApi.dart';
import 'components/datePicker.dart' as datePicker;

import 'appbar.dart';

class SOSOAPage extends StatefulWidget {
  String? Customer;
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  late Future getCustomers_obj = getCustomrs();
  late Future getSOSs = getSOA(Customer.toString(), fromDate,toDate,paymentStatus.toString());
  String? paymentStatus;




  @override
  State<SOSOAPage> createState() => _SOAPageState();
}

class _SOAPageState extends State<SOSOAPage> {



  OnDateChange(val) {
    setState(() {
      widget.fromDate = val;

//      widget.getSOSs = getSOA(widget.Customer.toString(), widget.fromDate,widget.toDate,widget.paymentStatus.toString());
    });
  }


  void OnDateChange2(val) {
    setState(() {
      widget.toDate = val;
    });
  }
  // Future<void> submitForm(BuildContext context) async {
  //   var fromDate = DateFormat("dd-MM-y").format(widget.fromDate);
  //   var toDate = DateFormat("dd-MM-y").format(widget.toDate);
  //   Map<String, String> body = {
  //     'fromDate': fromDate,
  //     'toDate': toDate,
  //     'custCode': widget.Customer.toString(),
  //     'paymentStatus': widget.paymentStatus.toString(),
  //   };
  //   print("@56");
  //   print(body);
  //
  // }

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
              AppBarCustom("SO SOA", Size(double.infinity, 300), () {}),
              SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FutureBuilder(
                        future: widget.getCustomers_obj,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            Map map = snapshot.data as Map;
                            print(map);
                            List suppliers = map['customrs'] as List;
                            return DropdownButtonFormField(
                              value: widget.Customer,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.numbers),
                                fillColor: Colors.white,
                                filled: true,
                                labelText: "Customer",
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
                                  widget.Customer = val.toString();
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
                                value: "InvoiceNotSent",
                                child: Text("InvoiceNotSent")),
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
                              widget.getSOSs = getSOA(widget.Customer.toString(),
                                  widget.fromDate,widget.toDate,widget.paymentStatus.toString());
                            });
                          }),
                      SizedBox(
                        height: 5,
                      ),
                      // FutureBuilder(
                      //   future: widget.getSOSs,
                      //   builder: (context, snapshot) {
                      //     if (snapshot.hasData) {
                      //       List map = snapshot.data as List;
                      //       return SingleChildScrollView(
                      //         scrollDirection: Axis.vertical,
                      //         child: Container(
                      //           color: Colors.white,
                      //           constraints: BoxConstraints(
                      //             maxHeight:
                      //             MediaQuery.of(context).size.height * 0.5,
                      //           ),
                      //           child: SingleChildScrollView(
                      //             scrollDirection: Axis.horizontal,
                      //             child: DataTable(
                      //               columns: const [
                      //
                      //                 DataColumn(label: Text('Order NO')),
                      //                 DataColumn(label: Text('Date')),
                      //                 DataColumn(label: Text('Amount')),
                      //                 DataColumn(label: Text('Payment Status')),
                      //                 DataColumn(label: Text('Customer')),
                      //                 DataColumn(label: Text('Products')),
                      //                 DataColumn(label: Text('Product Label')),
                      //                 DataColumn(label: Text('Disc')),
                      //                 DataColumn(label: Text('')),
                      //               ],
                      //               rows: map.map<DataRow>((e) {
                      //
                      //                 return DataRow(cells: [
                      //                   DataCell(Text(e['orderNo'].toString())),
                      //                   DataCell(Text(e['date'].toString())),
                      //                   DataCell(Text(e['amt'].toString())),
                      //                   DataCell(Text(e['paymentStatus'].toString())),
                      //                   DataCell(Text(e['custCode'].toString())),
                      //                   DataCell(Text(e['prodCode'].toString())),
                      //                   DataCell(Text(e['prodLabel'].toString())),
                      //                   DataCell(Text(e['disc'].toString())),
                      //                   DataCell(Center(child: InkWell(
                      //                     onTap: _payNow,
                      //                     child: Text("Pay Now", style: TextStyle(color: Colors.red),),
                      //                   ),))
                      //                 ]);
                      //               }).toList(),
                      //             ),
                      //           ),
                      //         ),
                      //       );
                      //     } else {
                      //       return Text("");
                      //     }
                      //   },
                      // ),
                      // SizedBox(height: 20),
                      FutureBuilder(
                        future: widget.getSOSs,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List map = snapshot.data as List;
                            return Scrollbar( // Scrollbar for vertical scroll
                              thumbVisibility: true, // Always show scrollbar while scrolling
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  color: Colors.white,
                                  constraints: BoxConstraints(
                                    maxHeight: MediaQuery.of(context).size.height * 0.5,
                                  ),
                                  child: Scrollbar( // Scrollbar for horizontal scroll
                                    thumbVisibility: true,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: DataTable(
                                        border: TableBorder.all(
                                          color: Colors.grey, // Border color
                                          width: 1,           // Border width
                                          style: BorderStyle.solid, // Border style
                                        ),
                                        columns: const [
                                          DataColumn(label: Text('Order NO')),
                                          DataColumn(label: Text('Check Box')),
                                          DataColumn(label: Text('Date')),
                                          DataColumn(label: Text('CustCode')),
                                          DataColumn(label: Text('Customer')),
                                          DataColumn(label: Text('ProdCode')),
                                          DataColumn(label: Text('ProdLabel')),
                                          DataColumn(label: Text('Amount')),
                                          DataColumn(label: Text('Disc')),
                                          DataColumn(label: Text('Payment Status')),
                                          DataColumn(label: Text('')),
                                        ],
                                        rows: map.map<DataRow>((e) {

                                          bool isChecked = false; // Variable to hold checkbox state
                                          return DataRow(cells: [
                                            DataCell(Text(e['orderNo'].toString())),
                                            DataCell(
                                              ((e['paymentStatus'] != null) &&
                                                  (e['paymentStatus'].toString().contains('Pending') ||
                                                      e['paymentStatus'].toString().contains('InvoiceNotSent') ||
                                                      e['paymentStatus'].toString().contains('Partial')))
                                                  ? Checkbox(
                                                value: isChecked,
                                                onChanged: (value) {
                                                  isChecked = value!;
                                                },
                                              )
                                                  : Text(e['paymentStatus'].toString()),
                                            ),
                                            DataCell(Text(e['date'].toString())),
                                            DataCell(Text(e['custCode'].toString())),
                                            DataCell(Text(e['customer'].toString())),
                                            DataCell(Text(e['prodCode'].toString())),
                                            DataCell(Text(e['prodLabel'].toString())),
                                            DataCell(Text(e['amt'].toString())),
                                            DataCell(Text(e['disc'].toString())),
                                            DataCell(Text(e['paymentStatus'].toString())),
                                            DataCell(
                                              Center(
                                                child: InkWell(
                                                  onTap: _payNow,
                                                  child: Text(
                                                    ((e['paymentStatus'] != null) &&
                                                        (e['paymentStatus'].toString().contains('Pending') ||
                                                            e['paymentStatus']
                                                                .toString()
                                                                .contains('InvoiceNotSent') ||
                                                            e['paymentStatus']
                                                                .toString()
                                                                .contains('Partial')))
                                                        ? 'PayNow'
                                                        : e['paymentStatus'].toString(),
                                                    style: TextStyle(
                                                        color: ((e['paymentStatus'] != null) &&
                                                            (e['paymentStatus'].toString().contains('Pending') ||
                                                                e['paymentStatus']
                                                                    .toString()
                                                                    .contains('InvoiceNotSent') ||
                                                                e['paymentStatus']
                                                                    .toString()
                                                                    .contains('Partial')))
                                                            ? Colors.red
                                                            : Colors.green),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]);

                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Text("");
                          }
                        },
                      )
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