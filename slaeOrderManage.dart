import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'appbar.dart';
import 'base.dart';
import 'components/datePicker.dart' as datePicker;
import 'ApiHandler/saleOrderApi.dart';
import 'components/popUpMessage.dart';

class SaleManageOrderPage extends StatefulWidget {
  DateTime date = DateTime.now();
  String? orderNo = null;
  TextEditingController quantity = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController disc = TextEditingController();
  TextEditingController netAmount = TextEditingController();
  String? name = null;
  String? custCode = null;
  String? prodCode = null;
  String? unitRate = null;
  bool checkBox = true;
  late Future getSales_obj = getSales(date);
  late Future getSo_obj = getSO("null");
  String? product;

  late Future getOrderDetails_obj = getOrderDetails(date);
  @override
  State<SaleManageOrderPage> createState() => _SaleManageOrderPageState();
}

class _SaleManageOrderPageState extends State<SaleManageOrderPage> {
  final _formkey = GlobalKey<FormState>();
  void OnDateChange(val) {
    setState(() {
      widget.date = val;
      widget.getSales_obj = getSales(widget.date);
    });
  }

  void updateAmt(val) {
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

  void run() {
    widget.getSo_obj.then((mappy) {
      if (mappy.isNotEmpty) {
        double quantity = double.parse(mappy['quantity'].toString());
        double unitRate = double.parse(mappy['unitRate'].toString());

        double amount = (quantity * unitRate);
        setState(() {
          widget.custCode = mappy['custCode'].toString();
          widget.quantity.text = mappy['quantity'].toString();
          widget.disc.text = mappy['disc'].toString();
          widget.unitRate = mappy['unitRate'].toString();
          widget.netAmount.text = mappy['netAmount'].toString();
          widget.amount.text = mappy['amount'].toString();
          if (amount.toString() == mappy['amount'].toString()) {
            widget.checkBox = true;
          } else {
            widget.checkBox = false;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            AppBarCustom("Manage Sale Order", Size(double.infinity, 50), () {}),
            SizedBox(
              height: 30,
            ),
            Container(
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
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.white),
                        child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                        future: widget.getSales_obj,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            Map map = snapshot.data as Map;
                            print(map);
                            List orderNumbers = map['orderNumbers'] as List;
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
                                    value: widget.orderNo,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.numbers),
                                        fillColor: Colors.white,
                                        filled: true,
                                        labelText: "Order No",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)),
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    23030, 23, 32, 49),
                                                style: BorderStyle.solid))),
                                    items: orderNumbers.reversed
                                        .map<DropdownMenuItem<String>>((e) {
                                      return DropdownMenuItem(
                                        child: Text(e),
                                        value: e,
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        widget.orderNo = val.toString();
                                        widget.getSo_obj =
                                            getSO(val.toString());
                                        run();
                                        // widget.batch.text = (int.parse(val.toString().split("-").last.toString()) + 1).toString();
                                      });
                                    });
                            }
                          } else {
                            return CircularProgressIndicator();
                          }
                          return CircularProgressIndicator();
                        }),
                    FutureBuilder(
                        future: widget.getSo_obj,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            Map mappy = snapshot.data as Map;
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
                                print(snapshot.data);
                                if (mappy.isNotEmpty) {
                                  return Form(
                                    key: _formkey,
                                    autovalidateMode: AutovalidateMode.always,
                                    child: Container(
                                      width: 80 /
                                          100 *
                                          MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Center(
                                                child: Text(
                                              "SO Info",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25),
                                            )),
                                            FutureBuilder(
                                                future:
                                                    widget.getOrderDetails_obj,
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    Map map =
                                                        snapshot.data as Map;
                                                    List Products =
                                                        map['customers']
                                                            as List;
                                                    switch (snapshot
                                                        .connectionState) {
                                                      case ConnectionState.none:
                                                        // TODO: Handle this case.
                                                        break;
                                                      case ConnectionState
                                                          .waiting:
                                                        return CircularProgressIndicator();
                                                        break;
                                                      case ConnectionState
                                                          .active:
                                                        // TODO: Handle this case.
                                                        break;
                                                      case ConnectionState.done:
                                                        return DropdownButtonFormField(
                                                            value:
                                                                widget.custCode,
                                                            decoration: InputDecoration(
                                                                prefixIcon:
                                                                    Icon(Icons
                                                                        .numbers),
                                                                fillColor: Colors
                                                                    .white,
                                                                filled: true,
                                                                labelText:
                                                                    "Cusomters",
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(
                                                                            30)),
                                                                    borderSide: BorderSide(
                                                                        color: Color.fromARGB(
                                                                            23030,
                                                                            23,
                                                                            32,
                                                                            49),
                                                                        style: BorderStyle
                                                                            .solid))),
                                                            items:
                                                                Products.map<DropdownMenuItem<String>>(
                                                                    (e) {
                                                              return DropdownMenuItem(
                                                                child: Text(e[0]
                                                                        .toString() +
                                                                    "-" +
                                                                    e[1].toString()),
                                                                value: e[0]
                                                                    .toString(),
                                                              );
                                                            }).toList(),
                                                            onChanged: (val) {
                                                              setState(() {
                                                                widget.custCode =
                                                                    val.toString();
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
                                                future:
                                                    widget.getOrderDetails_obj,
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    Map map =
                                                        snapshot.data as Map;
                                                    List Products =
                                                        map['Products'] as List;
                                                    switch (snapshot
                                                        .connectionState) {
                                                      case ConnectionState.none:
                                                        // TODO: Handle this case.
                                                        break;
                                                      case ConnectionState
                                                          .waiting:
                                                        return CircularProgressIndicator();
                                                        break;
                                                      case ConnectionState
                                                          .active:
                                                        // TODO: Handle this case.
                                                        break;
                                                      case ConnectionState.done:
                                                        return DropdownButtonFormField(
                                                            value:
                                                                widget.product,
                                                            decoration: InputDecoration(
                                                                prefixIcon:
                                                                    Icon(Icons
                                                                        .numbers),
                                                                fillColor: Colors
                                                                    .white,
                                                                filled: true,
                                                                labelText:
                                                                    "Products",
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(
                                                                            30)),
                                                                    borderSide: BorderSide(
                                                                        color: Color.fromARGB(
                                                                            23030,
                                                                            23,
                                                                            32,
                                                                            49),
                                                                        style: BorderStyle
                                                                            .solid))),
                                                            items:
                                                                Products.map<DropdownMenuItem<String>>(
                                                                    (e) {
                                                              return DropdownMenuItem(
                                                                child: Text(e[0]
                                                                        .toString() +
                                                                    "-" +
                                                                    e[1].toString()),
                                                                value: (e[0]
                                                                        .toString() +
                                                                    "-" +
                                                                    e[1].toString()),
                                                              );
                                                            }).toList(),
                                                            onChanged: (val) {
                                                              setState(() {
                                                                widget.product =
                                                                    val.toString();
                                                                widget.prodCode = val
                                                                    .toString()
                                                                    .split(
                                                                        "-")[1];
                                                                widget.unitRate = val
                                                                    .toString()
                                                                    .split(
                                                                        "-")[0];
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
                                              onChanged: (val) =>
                                                  updateAmt(val),
                                              controller: widget.quantity,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                  prefixIcon:
                                                      Icon(Icons.numbers),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  labelText: "quantity",
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius
                                                          .all(
                                                              Radius.circular(
                                                                  30)),
                                                      borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                              23030,
                                                              23,
                                                              32,
                                                              49),
                                                          style: BorderStyle
                                                              .solid))),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              onChanged: (val) =>
                                                  updateAmt(val),
                                              controller: widget.disc,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                  prefixIcon:
                                                      Icon(Icons.numbers),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  labelText: "discount",
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius
                                                          .all(
                                                              Radius.circular(
                                                                  30)),
                                                      borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                              23030,
                                                              23,
                                                              32,
                                                              49),
                                                          style: BorderStyle
                                                              .solid))),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              enabled: false,
                                              controller: widget.amount,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                  prefixIcon:
                                                      Icon(Icons.numbers),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  labelText: "Amount",
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius
                                                          .all(
                                                              Radius.circular(
                                                                  30)),
                                                      borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                              23030,
                                                              23,
                                                              32,
                                                              49),
                                                          style: BorderStyle
                                                              .solid))),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              height: 50,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(50)),
                                                  color: Colors.white),
                                              child: Center(
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Auto Update Amt:",
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                      Checkbox(
                                                          value:
                                                              widget.checkBox,
                                                          onChanged:
                                                              (bool? val) {
                                                            setState(() {
                                                              widget.checkBox =
                                                                  val as bool;
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
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                  prefixIcon:
                                                      Icon(Icons.numbers),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  labelText:
                                                      "(unitRate-disc) * Quantity",
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius
                                                          .all(
                                                              Radius.circular(
                                                                  30)),
                                                      borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                              23030,
                                                              23,
                                                              32,
                                                              49),
                                                          style: BorderStyle
                                                              .solid))),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                if (_formkey.currentState!
                                                    .validate()) {
                                                  Map<String, String> body = {
                                                    "date": DateFormat(
                                                            "dd-MM-yyyy")
                                                        .format(widget.date),
                                                    "custCode": widget.custCode
                                                        .toString(),
                                                    'orderNo': widget.orderNo
                                                        .toString(),
                                                    'prodCode': widget.prodCode
                                                        .toString(),
                                                    "disc": widget.disc.text
                                                        .toString(),
                                                    "netAmount": widget
                                                        .netAmount.text
                                                        .toString(),
                                                    "amount": widget.amount.text
                                                        .toString(),
                                                    "quantity": widget
                                                        .quantity.text
                                                        .toString(),
                                                    'unitRate': widget.unitRate
                                                        .toString(),
                                                  };
                                                  int val =
                                                      await updsaleOrder(body);
                                                  if (val == 202) {
                                                    Navigator.pop(context);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                BasePage(
                                                                    "Manage Sale Order",
                                                                    SaleManageOrderPage())));
                                                    popUpMsg(
                                                        "Successfully Updated Order",
                                                        Colors.green,
                                                        context,
                                                        "Success");
                                                  }
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(40)),
                                                  color: Color.fromARGB(
                                                      255, 54, 103, 166),
                                                ),
                                                height: 60,
                                                width: 1 /
                                                    2 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                child: Center(
                                                    child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Update",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30),
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
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Center(
                                      child: Text(
                                    "Select Order Number",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ));
                                }
                            }
                          } else {
                            return CircularProgressIndicator();
                          }
                          return CircularProgressIndicator();
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
