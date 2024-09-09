import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'ApiHandler/saleOrderApi.dart';
import 'base.dart';
import 'components/datePicker.dart' as datePicker;
import 'appbar.dart';
import 'components/popUpMessage.dart';
import 'homePage.dart';

class SaleOrderPage extends StatefulWidget {
  DateTime date = DateTime.now();
  DateTime recDate = DateTime.now();
  //DateTime creationDate = DateTime.now();
  TextEditingController quantity = TextEditingController();
  TextEditingController disc = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController netAmount = TextEditingController();
  TextEditingController bankrefno = TextEditingController();
  //TextEditingController paymentStatus = TextEditingController();
  TextEditingController recAmount = TextEditingController();
 // TextEditingController prodLabel = TextEditingController();
  late Future getCustomerDetails_obj =
  getCustomerDetails(date);


  String? name = null;
  String? prodLabel = null;
  String? custCode = null;
  String? prodCode = null;
  String? unitRate = null;
  String? paymentStatus = null;
  String? Bank = null;
  bool checkBox = true;
  String? orderNo = null;

  late Future getOrderDetails_obj = getOrderDetails(date);

  String? product;

  get getCustomerDetails => null;

  @override
  State<SaleOrderPage> createState() => _SaleOrderPageState();
}

class _SaleOrderPageState extends State<SaleOrderPage> {
  final _formkey = GlobalKey<FormState>();

  // void OnDateChange(val) {
  //   setState(() {
  //     widget.date = val;
  //     String? name = null;
  //     String? custCode = null;
  //     String? prodCode = null;
  //     String? unitRate = null;
  //
  //     widget.getOrderDetails_obj = getOrderDetails(widget.date);
  //   });
  // }

  void OnDateChange(val) {
    setState(() {
      widget.date = val;
      widget.custCode = null;
      widget.Bank = null;
      widget.prodCode = null;
      widget.paymentStatus = null;
      widget.unitRate = null;
      widget.orderNo = null;
      widget.prodLabel = null;
      widget.getCustomerDetails_obj =
          getCustomerDetails(widget.date);

    });
  }
  void OnDateChange2(val) {
    setState(() {
      widget.date = val;
    });
  }
  void OnDateChange3(val) {
    setState(() {
      widget.recDate = val;
    });
  }



  void updateAmt(val) {
    // print((widget.unitRate = val.toString()).isNotEmpty);
    // print(widget.quantity.text.isNotEmpty);
    // print(widget.amount.text.isNotEmpty);

    // if ((widget.unitRate = val.toString()).isNotEmpty &&
    //     widget.quantity.text.isNotEmpty &&
    //     widget.checkBox == true) {
    //   print("x");

    // }
    double unitRate = double.parse(widget.unitRate.toString());
    double quantity = double.parse(widget.quantity.text);

    double amount = (quantity * unitRate);

    setState(() {
      widget.amount.text = amount.toString();
      widget.netAmount.text =
          ((unitRate - double.parse(widget.disc.text)) * quantity).toString();
    });
  }

  void updateNetAmt(val) {
    widget.netAmount.text =
        ((widget.unitRate = val) - double.parse(widget.disc.text)) *
            (widget.quantity.text).toString();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            AppBarCustom("Sale Order", Size(double.infinity, 50), () {}),
            SizedBox(
              height: 30,
            ),
            Form(
              key: _formkey,
              autovalidateMode: AutovalidateMode.always,
              child: Container(
                width: 80 / 100 * MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () => datePicker.showDatePicker(
                                context, OnDateChange, widget.date),
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
                                        "Date: ",
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
                            height: 5,
                          ),
                          FutureBuilder(
                              future: widget.getOrderDetails_obj,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  Map map = snapshot.data as Map;
                                  widget.orderNo = (map['orderNo'].toString());

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
                                      return Text(
                                        "Order No: " +
                                            widget.orderNo.toString(),
                                        style: TextStyle(fontSize: 20),
                                      );
                                  }
                                } else {
                                  return CircularProgressIndicator();
                                }
                                return CircularProgressIndicator();
                              }),
                          SizedBox(
                            height: 5,
                          ),
                          FutureBuilder(
                              future: widget.getOrderDetails_obj,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  Map map = snapshot.data as Map;
                                  List Products = map['customers'] as List;
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
                                          value: widget.custCode,
                                          decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.numbers),
                                              fillColor: Colors.white,
                                              filled: true,
                                              labelText: "Cusomters",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(30)),
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          23030, 23, 32, 49),
                                                      style:
                                                      BorderStyle.solid))),
                                          items: Products.map<
                                              DropdownMenuItem<String>>((e) {
                                            return DropdownMenuItem(
                                              child: Text(e[0].toString() +
                                                  "-" +
                                                  e[1].toString()),
                                              value: e[1].toString(),
                                            );
                                          }).toList(),
                                          onChanged: (val) {
                                            print('@249 ${val}');
                                            setState(() {
                                              widget.custCode = val.toString();
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
                          FutureBuilder(
                              future: widget.getOrderDetails_obj,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  Map map = snapshot.data as Map;
                                  List Products = map['Products'] as List;
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
                                          value: widget.product,
                                          decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.numbers),
                                              fillColor: Colors.white,
                                              filled: true,
                                              labelText: "Products",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(30)),
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          23030, 23, 32, 49),
                                                      style:
                                                      BorderStyle.solid))),
                                          items: Products.map<
                                              DropdownMenuItem<String>>((e) {
                                            return DropdownMenuItem(
                                              child: Text(e[0].toString() +
                                                  "-" +
                                                  e[1].toString()),
                                              value: (e[0].toString() +
                                                  "-" +
                                                  e[1].toString()),
                                            );
                                          }).toList(),
                                          onChanged: (val) {
                                            setState(() {
                                              widget.product = val.toString();
                                              widget.prodCode =
                                              val.toString().split("-")[1];
                                              widget.unitRate =
                                              val.toString().split("-")[0];
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
                          TextFormField(
                            onChanged: (val) => updateAmt(val),
                            controller: widget.quantity,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.numbers),
                                fillColor: Colors.white,
                                filled: true,
                                labelText: "quantity",
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color:
                                        Color.fromARGB(23030, 23, 32, 49),
                                        style: BorderStyle.solid))),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            onChanged: (val) => updateAmt(val),
                            controller: widget.disc,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.numbers),
                                fillColor: Colors.white,
                                filled: true,
                                labelText: "discount",
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color:
                                        Color.fromARGB(23030, 23, 32, 49),
                                        style: BorderStyle.solid))),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            enabled: false,
                            controller: widget.amount,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.numbers),
                                fillColor: Colors.white,
                                filled: true,
                                labelText: "Amount",
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color:
                                        Color.fromARGB(23030, 23, 32, 49),
                                        style: BorderStyle.solid))),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Auto Update Amt:",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Checkbox(
                                        value: widget.checkBox,
                                        onChanged: (bool? val) {
                                          setState(() {
                                            widget.checkBox = val as bool;
                                          });
                                        })
                                  ]),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            enabled: false,
                            controller: widget.netAmount,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.numbers),
                                fillColor: Colors.white,
                                filled: true,
                                labelText: "(unitRate-disc) * Quantity",
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color:
                                        Color.fromARGB(23030, 23, 32, 49),
                                        style: BorderStyle.solid))),
                          ),
                          SizedBox(
                            height: 5,
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
                                    value: "Received", child: Text("Received")),
                                DropdownMenuItem(
                                    value: "InvoiceNotSent",
                                    child: Text("InvoiceNotSent")),
                                DropdownMenuItem(
                                    value: "Pending", child: Text(" Pending"))
                              ],
                              onChanged: (val) {
                                setState(() {
                                  widget.paymentStatus = val.toString();
                                });
                              }),
                          SizedBox(
                            height: 5,
                          ),
                          Visibility(
                            visible: widget.paymentStatus == "Received" ? true : false,
                            child: TextFormField(
                              controller: widget.bankrefno,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.numbers),
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelText: "Bank Ref No",
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(23030, 23, 32, 49),
                                          style: BorderStyle.solid))),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Visibility(
                            visible: widget.paymentStatus == "Received" ? true : false,
                            child: GestureDetector(
                              onTap: () => datePicker.showDatePicker(
                                  context, OnDateChange2, widget.recDate),
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
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.calendar_month),
                                        Text(
                                          "Received Date: ",
                                          style: TextStyle(fontSize: 25),
                                        ),
                                        Text(
                                          DateFormat('dd-MM-yyyy')
                                              .format(widget.recDate)
                                              .toString(),
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Visibility(
                            visible: widget.paymentStatus == "Received" ? true : false,
                            child: FutureBuilder(
                                future: widget.getCustomerDetails,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    Map map = snapshot.data as Map;
                                    List banks = map['banks'] as List;
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
                                            value: widget.Bank,
                                            decoration: InputDecoration(
                                                prefixIcon:
                                                Icon(Icons.comment_bank),
                                                fillColor: Colors.white,
                                                filled: true,
                                                labelText: "Bank",
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(30)),
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            23030, 23, 32, 49),
                                                        style: BorderStyle.solid))),
                                            items: banks
                                                .map<DropdownMenuItem<String>>((e) {
                                              return DropdownMenuItem(
                                                child: Text(e[1]),
                                                value: e[0],
                                              );
                                            }).toList(),
                                            onChanged: (val) {
                                              setState(() {
                                                widget.Bank = val.toString();
                                              });
                                            });
                                    }
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                  return CircularProgressIndicator();
                                }),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Visibility(
                            visible: widget.paymentStatus == "Received" ? true : false,
                            child: TextFormField(
                              controller: widget.recAmount,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.numbers),
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelText: "Rec Amount",
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(23030, 23, 32, 49),
                                          style: BorderStyle.solid))),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (_formkey.currentState!.validate()) {
                                String saleOrderVal = await SaleOrder(
                                  widget.date,
                                  widget.orderNo.toString(),
                                  widget.prodCode.toString(),
                                  widget.custCode.toString(),
                                  widget.disc.text,
                                  widget.netAmount.text,
                                  widget.amount.text,
                                  widget.quantity.text,
                                  widget.unitRate.toString(),
                                  widget.paymentStatus.toString(),
                                  widget.prodLabel
                                );

                                print(saleOrderVal);
                                if (saleOrderVal == "202") {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BasePage("Home", HomePage())));
                                  popUpMsg("Successfully Orderd !!!!",
                                      Colors.green, context, "Success");
                                } else if (saleOrderVal == "203") {
                                  popUpMsg("Please try to order", Colors.red,
                                      context, "Error");
                                }
                              }
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
                                        "Submit",
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
                          SizedBox(
                            height: 20,
                          ),
                        ])),
              ),
            ),
          ])),
    );
  }
}