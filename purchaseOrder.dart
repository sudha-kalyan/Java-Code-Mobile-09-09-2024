import 'package:flutter/material.dart';
import 'package:mobile_ver/ApiHandler/purchaseOrderApi.dart';
import 'package:mobile_ver/appbar.dart';
import 'package:mobile_ver/main.dart';
import 'package:mobile_ver/purchaseOrderManage.dart';
import 'base.dart';
import 'components/basePage.dart';
import 'components/datePicker.dart' as datePicker;
import 'package:intl/intl.dart';

import 'components/popUpMessage.dart';
import 'homePage.dart';

class PurchaseOrderPage extends StatefulWidget {
  DateTime selectedDate = DateTime.now();
  DateTime recievedDate = DateTime.now();
  DateTime PoRefDate = DateTime.now();

  String? invcNumber = null;
  TextEditingController qty = TextEditingController()..text = "9000";
  TextEditingController amt = TextEditingController()
    ..text = (9000 * 27).toString();
  TextEditingController batch = TextEditingController()..text = "1";
  TextEditingController fat = TextEditingController()..text = "4";
  TextEditingController snf = TextEditingController()..text = "5";
  TextEditingController tsRate = TextEditingController()..text = "300";
  TextEditingController ltrRate = TextEditingController()..text = "27";
  TextEditingController bankrefno = TextEditingController();
  TextEditingController porefno = TextEditingController();
  TextEditingController recAmount = TextEditingController();

  String? SuplCode = null;
  String? Vehicle = null;
  String? Bank = null;
  String? MilkType = null;
  String? PayStat = null;
  String? InvType = null;
  String? Unit = null;
  String? TMode = null;
  bool checkBox = true;
  late Future getSupplyVehicleDetails_obj =
      getSupplyVehicleDetails(selectedDate);

  @override
  State<PurchaseOrderPage> createState() => _PurchaseOrderPageState();
}

class _PurchaseOrderPageState extends State<PurchaseOrderPage> {
  final _formkey = GlobalKey<FormState>();

  void OnDateChange(val) {
    setState(() {
      widget.selectedDate = val;
      widget.SuplCode = null;
      widget.Vehicle = null;
      widget.Bank = null;
      widget.MilkType = null;
      widget.PayStat = null;
      widget.invcNumber = null;
      widget.TMode = null;
      widget.getSupplyVehicleDetails_obj =
          getSupplyVehicleDetails(widget.selectedDate);
    });
  }

  void OnDateChange2(val) {
    setState(() {
      widget.recievedDate = val;
    });
  }

  void OnDateChange3(val) {
    setState(() {
      widget.PoRefDate = val;
    });
  }

  void updateLtrRate(val) {
    print(widget.snf.text.isNotEmpty);
    print(widget.fat.text.isNotEmpty);
    print(widget.ltrRate.text.isNotEmpty);
    if (widget.snf.text.isNotEmpty &&
        widget.fat.text.isNotEmpty &&
        widget.tsRate.text.isNotEmpty &&
        widget.checkBox == true) {
      print("x");
      double snf = double.parse(widget.snf.text);
      double fat = double.parse(widget.fat.text);
      double tsRate = double.parse(widget.tsRate.text);

      double ltrRate = (((fat + snf) * tsRate) / 100);

      setState(() {
        widget.ltrRate.text = ltrRate.toString();
        widget.amt.text = (ltrRate * double.parse(widget.qty.text)).toString();
      });
    }
  }

  void updateAmt(val) {
    widget.amt.text =
        (double.parse(widget.ltrRate.text) * double.parse(widget.qty.text))
            .toString();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            AppBarCustom("Purchase Order", Size(double.infinity, 50), () {}),
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
                            context, OnDateChange, widget.selectedDate),
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
                                    "Date: ",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  Text(
                                    DateFormat('dd-MM-yyyy')
                                        .format(widget.selectedDate)
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
                          future: widget.getSupplyVehicleDetails_obj,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              Map map = snapshot.data as Map;
                              List invcNumbers = map['invcNumbers'] as List;
                              List batchNums = map['batchNums'] as List;
                              List newinv = map['newInvs'] as List;
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
                                      value: widget.invcNumber,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.numbers),
                                          fillColor: Colors.white,
                                          filled: true,
                                          labelText: "Invoice Number",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      23030, 23, 32, 49),
                                                  style: BorderStyle.solid))),
                                      items: invcNumbers
                                          .map<DropdownMenuItem<String>>((e) {
                                        return DropdownMenuItem(
                                          child: newinv.contains(e)
                                              ? Text(e.toString() + "(new)")
                                              : Text(e),
                                          value: e,
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          widget.invcNumber = val.toString();
                                          widget.batch.text = batchNums[
                                                  invcNumbers
                                                      .indexOf(val.toString())]
                                              .toString();
                                          widget.SuplCode = val
                                              .toString()
                                              .split("-")
                                              .first
                                              .toString();
                                          // widget.batch.text = (int.parse(val.toString().split("-").last.toString()) + 1).toString();
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
                        validator: (val) {
                          if (val.toString().isEmpty == true) {
                            return "Batch No is Compulsary";
                          }
                        },
                        controller: widget.batch,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.numbers),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Batch Number",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(23030, 23, 32, 49),
                                    style: BorderStyle.solid))),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      FutureBuilder(
                          future: widget.getSupplyVehicleDetails_obj,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              Map map = snapshot.data as Map;
                              List suppliers = map['suppliers'] as List;
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
                                      enableFeedback: false,
                                      value: widget.SuplCode,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.numbers),
                                          fillColor: Colors.white,
                                          filled: true,
                                          labelText: "SuplCode",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      23030, 23, 32, 49),
                                                  style: BorderStyle.solid))),
                                      items: suppliers
                                          .map<DropdownMenuItem<String>>((e) {
                                        if (widget.SuplCode == e ||
                                            widget.SuplCode == null) {
                                          return DropdownMenuItem(
                                            child: Text(e[0].toString()),
                                            value: e[1].toString(),
                                          );
                                        } else {
                                          return DropdownMenuItem(
                                            enabled: false,
                                            child: Text(e[0].toString()),
                                            value: e[1].toString(),
                                          );
                                        }
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {});
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
                            });
                          }),
                      SizedBox(
                        height: 5,
                      ),
                      DropdownButtonFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.numbers),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "Transport Mode",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(23030, 23, 32, 49),
                                      style: BorderStyle.solid))),
                          value: widget.TMode,
                          items: [
                            DropdownMenuItem(
                                value: "Roads", child: Text("Roads")),
                            DropdownMenuItem(
                                value: "Others", child: Text("Others")),
                          ],
                          onChanged: (val) {
                            setState(() {
                              widget.TMode = val.toString();
                            });
                          }),
                      SizedBox(
                        height: 5,
                      ),
                      FutureBuilder(
                          future: widget.getSupplyVehicleDetails_obj,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              Map map = snapshot.data as Map;
                              List vehicles = map['vehicles'] as List;
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
                                      value: widget.Vehicle,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.numbers),
                                          fillColor: Colors.white,
                                          filled: true,
                                          labelText: "Vehicle",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      23030, 23, 32, 49),
                                                  style: BorderStyle.solid))),
                                      items: vehicles
                                          .map<DropdownMenuItem<String>>((e) {
                                        if (widget.SuplCode == e[1] ||
                                            widget.SuplCode == null) {
                                          return DropdownMenuItem(
                                            child: Text(e[0] + "-" + e[1]),
                                            value: e[0],
                                          );
                                        } else {
                                          return DropdownMenuItem(
                                            enabled: false,
                                            child: Text(e[0] + "-" + e[1]),
                                            value: e[0],
                                          );
                                        }
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          widget.Vehicle = val.toString();
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
                          future: widget.getSupplyVehicleDetails_obj,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              Map map = snapshot.data as Map;
                              List milktypes = map['milktypes'] as List;
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
                                      value: widget.MilkType,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.water),
                                          fillColor: Colors.white,
                                          filled: true,
                                          labelText: "Milk Type",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      23030, 23, 32, 49),
                                                  style: BorderStyle.solid))),
                                      items: milktypes
                                          .map<DropdownMenuItem<String>>((e) {
                                        return DropdownMenuItem(
                                          child: Text(e),
                                          value: e,
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          widget.MilkType = val.toString();
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
                        validator: (val) {
                          if (val.toString().isEmpty == true) {
                            return "Quantity is Compulsary";
                          }
                        },
                        controller: widget.qty,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.numbers),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Quantity",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(23030, 23, 32, 49),
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
                              labelText: "Units",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(23030, 23, 32, 49),
                                      style: BorderStyle.solid))),
                          value: widget.Unit,
                          items: [
                            DropdownMenuItem(value: "KG", child: Text("KG")),
                            DropdownMenuItem(value: "Ltr", child: Text("LTR")),
                          ],
                          onChanged: (val) {
                            setState(() {
                              widget.Unit = val.toString();
                            });
                          }),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        onChanged: (val) => updateLtrRate(val),
                        validator: (val) {
                          if (val.toString().isEmpty == false &&
                              !RegExp("[45][.]?[0-9]?")
                                  .hasMatch(val.toString())) {
                            return "Fat can only be between 4-5 and only 1 decimal allowed";
                          }
                        },
                        controller: widget.fat,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.numbers),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Fat(4-5)",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(23030, 23, 32, 49),
                                    style: BorderStyle.solid))),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        onChanged: (val) => updateLtrRate(val),
                        validator: (val) {
                          if (val.toString().isEmpty == false &&
                              RegExp("([5-9][.]?[0-9]{0,2}|1[0-2]{1}[.]?[0-9]{0,2})")
                                      .hasMatch(val.toString()) ==
                                  false) {
                            return "Snf can only be between 5-12 and only 2 decimal allowed";
                          }
                        },
                        controller: widget.snf,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.numbers),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "SNF(5-12)",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(23030, 23, 32, 49),
                                    style: BorderStyle.solid))),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        onChanged: (val) => updateLtrRate(val),
                        validator: (val) {
                          if (val.toString().isEmpty == false &&
                              !RegExp("[3][0-9][0-9][.]{0,1}[0-9]{0,1}|400\.0")
                                  .hasMatch(val.toString())) {
                            return "TS Rate can only be between 300 and 400 with 1 decimal place";
                          }
                        },
                        controller: widget.tsRate,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.numbers),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "TS Rate(300-400)",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(23030, 23, 32, 49),
                                    style: BorderStyle.solid))),
                      ),
                      SizedBox(
                        height: 5,
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
                                  "Auto Update LTR Rate: ",
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
                        onChanged: (val) => updateAmt(val),
                        validator: (val) {
                          if (val.toString().isEmpty == false &&
                              !RegExp("[2][789]|[345][0-9]|[6][0-8]")
                                  .hasMatch(val.toString())) {
                            return "Ltr Rate can only be between 27-68 ";
                          }
                        },
                        controller: widget.ltrRate,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.numbers),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Ltr Rate",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(23030, 23, 32, 49),
                                    style: BorderStyle.solid))),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        enabled: false,
                        controller: widget.amt,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.numbers),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Amount(LtrRate * Quantity)",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(23030, 23, 32, 49),
                                    style: BorderStyle.solid))),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        enabled: false,
                        controller: widget.porefno,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.numbers),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "PO Ref No (currently N/A)",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(23030, 23, 32, 49),
                                    style: BorderStyle.solid))),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {},
                        // () => datePicker.showDatePicker(
                        //     context, OnDateChange3, widget.PoRefDate),
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
                                    "PoRefDate(N/A): ",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    DateFormat('dd-MM-yyyy')
                                        .format(widget.PoRefDate)
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
                          value: widget.PayStat,
                          items: [
                            DropdownMenuItem(
                                value: "Received", child: Text("Received")),
                            DropdownMenuItem(
                                value: " Invoice_Not_Sent",
                                child: Text(" Invoice Not Sent")),
                            DropdownMenuItem(
                                value: "Pending", child: Text(" Pending"))
                          ],
                          onChanged: (val) {
                            setState(() {
                              widget.PayStat = val.toString();
                            });
                          }),
                      SizedBox(
                        height: 5,
                      ),
                      Visibility(
                        visible: widget.PayStat == "Received" ? true : false,
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
                        visible: widget.PayStat == "Received" ? true : false,
                        child: GestureDetector(
                          onTap: () => datePicker.showDatePicker(
                              context, OnDateChange2, widget.recievedDate),
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
                                          .format(widget.recievedDate)
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
                        visible: widget.PayStat == "Received" ? true : false,
                        child: FutureBuilder(
                            future: widget.getSupplyVehicleDetails_obj,
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
                        visible: widget.PayStat == "Received" ? true : false,
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
                            String invNum = widget.invcNumber.toString() +
                                "/" +
                                widget.batch.text.toString();
                            Map<String, String> body = {
                              'inv': invNum,
                              "date": DateFormat("dd-MM-yyyy")
                                  .format(widget.selectedDate),
                              "suplCode": widget.SuplCode.toString(),
                              "vehicle": widget.Vehicle.toString(),
                              "qty": widget.qty.text.toString(),
                              "fat": widget.fat.text.toString(),
                              "snf": widget.snf.text.toString(),
                              "tsRate": widget.tsRate.text.toString(),
                              "ltrRate": widget.ltrRate.text.toString(),
                              "milkType": widget.MilkType.toString(),
                              "payStat": widget.PayStat.toString(),
                              "bankRefno": widget.bankrefno.text.toString(),
                              "recvdate": DateFormat('dd-MM-yyyy')
                                  .format(widget.recievedDate),
                              "bankifsc": widget.Bank.toString(),
                              "recamt": widget.recAmount.text.toString(),
                              "amt": widget.amt.text.toString(),
                              "loginId": storage.getItem("loggedPhone"),
                              "invType": widget.InvType.toString(),
                              "Tmode": widget.TMode.toString(),
                              "Unit": widget.Unit.toString(),
                              "porefno": "NA",
                              "porefdate": "NA",
                            };
                            int val = await purchaseOrder(body);
                            if (val == 202) {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BasePage(
                                          "Manage Purchase Order",
                                          PurchaseManageOrderPage())));
                              popUpMsg(
                                  "Successfully created Order on Invoice number: " +
                                      widget.invcNumber.toString(),
                                  Colors.green,
                                  context,
                                  "Success");
                            }
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
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
                                "Purchase",
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
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
