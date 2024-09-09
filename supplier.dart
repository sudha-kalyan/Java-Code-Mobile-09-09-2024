import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_ver/ApiHandler/supplierApi.dart';
import 'package:mobile_ver/appbar.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_ver/base.dart';
import 'package:mobile_ver/components/popUpMessage.dart';

import 'ApiHandler/supplierApi.dart';
import 'homePage.dart';

class SupplierPage extends StatefulWidget {
  TextEditingController SupplierNameController = new TextEditingController();

  TextEditingController SupAddress1Controller = new TextEditingController();
  TextEditingController SupAddress2Controller = new TextEditingController();
  TextEditingController SupAddress3Controller = new TextEditingController();
  TextEditingController SupEmailController = new TextEditingController();
  TextEditingController SupMobileController = new TextEditingController();
  TextEditingController PinCodeController = new TextEditingController();
  TextEditingController DistanceController = new TextEditingController();
  TextEditingController GstController = new TextEditingController();
  TextEditingController ShipAddress1Controller = new TextEditingController();
  TextEditingController ShipAddress2Controller = new TextEditingController();
  TextEditingController ShipAddress3Controller = new TextEditingController();
  TextEditingController ShipMobileController = new TextEditingController();
  TextEditingController ShippinCodeController = new TextEditingController();
  TextEditingController ShipdistanceController = new TextEditingController();
  String ActiveDropDown_val = "Yes";
  String RemoveDropDown_val = "No";

  @override
  State<SupplierPage> createState() => _Supplier();
}

class _Supplier extends State<SupplierPage> {
  List ActiveDropDown = ["Yes", "No"];
  List RemoveDropDown = ["No", "Yes"];
  bool obscureText = true;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBarCustom("Supplier", Size(double.infinity, 300), () {}),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 80 / 100 * MediaQuery.of(context).size.width,
              child: Form(
                  key: _formkey,
                  autovalidateMode: AutovalidateMode.always,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextFormField(
                          validator: (val) {
                            if (val.toString().isEmpty == true) {
                              return " SupplierName is Compulsary";
                            } else if (!RegExp("[A-Za-z]+")
                                .hasMatch(val.toString())) {
                              return "Enter Valid Name That Contains Only Letters";
                            }
                          },
                          controller: widget.SupplierNameController,
                          decoration: InputDecoration(
                              prefix: Icon(Icons.person),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " Supplier Name",
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
                          validator: (val) {
                            if (val.toString().isEmpty == true) {
                              return "Address is Compulsary";
                            } else if (!RegExp("[A-Za-z_0-9\.-\_,]+")
                                .hasMatch(val.toString())) {
                              return "Enter Valid Address";
                            }
                          },
                          controller: widget.SupAddress1Controller,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " SuppAddress1",
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
                          validator: (val) {
                            if (val.toString().isEmpty == true) {
                              return "Address is Compulsary";
                            } else if (!RegExp("[A-Za-z_0-9\.-\_,]+")
                                .hasMatch(val.toString())) {
                              return "Enter Valid Address";
                            }
                          },
                          controller: widget.SupAddress2Controller,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " SuppAddress2",
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
                          validator: (val) {
                            if (val.toString().isEmpty == true) {
                              return "Address is Compulsary";
                            } else if (!RegExp("[A-Za-z_0-9\.-\_,]+")
                                .hasMatch(val.toString())) {
                              return "Enter Valid Address";
                            }
                          },
                          controller: widget.SupAddress3Controller,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " SuppAddress3",
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
                          validator: (val) {
                            if (val.toString().isEmpty == true) {
                              return "Email is Compulsary";
                            } else if (!RegExp(
                                    "[a-zA-Z_0-9\.\_]+[@][a-z]+[\.][a-z]{2,3}")
                                .hasMatch(val.toString())) {
                              return "Enter Valid Email";
                            }
                          },
                          controller: widget.SupEmailController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " SupEmail",
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
                          validator: (val) {
                            if (val.toString().isEmpty == true) {
                              return "supMobile is Compulsary";
                            } else if (!RegExp("[1-9][0-9]{9}")
                                .hasMatch(val.toString())) {
                              return "Enter Valid Mobile";
                            }
                          },
                          controller: widget.SupMobileController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " SuppMobile",
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
                          validator: (val) {
                            if (val.toString().isEmpty == true) {
                              return "PinCode is Compulsary";
                            } else if (!RegExp("[1-9][0-9]{5}")
                                .hasMatch(val.toString())) {
                              return "Enter Valid PinCode";
                            }
                          },
                          controller: widget.PinCodeController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " PinCode",
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
                          validator: (val) {
                            if (val.toString().isEmpty == true) {
                              return "Distance is Compulsary";
                            } else if (!RegExp("[1-9][0-9]{1}")
                                .hasMatch(val.toString())) {
                              return "Enter Valid Distance";
                            }
                          },
                          controller: widget.DistanceController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " Distance",
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
                                fillColor: Colors.white,
                                filled: true,
                                labelText: "Active",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(23030, 23, 32, 49),
                                        style: BorderStyle.solid))),
                            value: widget.ActiveDropDown_val,
                            items: ActiveDropDown.map<DropdownMenuItem<String>>(
                                (e) {
                              return DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              );
                            }).toList(),
                            onChanged: (changeValue) {
                              setState(() {
                                widget.ActiveDropDown_val =
                                    changeValue.toString();
                              });
                            }),
                        SizedBox(
                          height: 5,
                        ),
                        DropdownButtonFormField(
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: "Remove",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(23030, 23, 32, 49),
                                        style: BorderStyle.solid))),
                            value: widget.RemoveDropDown_val,
                            items: RemoveDropDown.map<DropdownMenuItem<String>>(
                                (e) {
                              return DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              );
                            }).toList(),
                            onChanged: (changeValue) {
                              setState(() {
                                widget.RemoveDropDown_val =
                                    changeValue.toString();
                              });
                            }),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val.toString().isEmpty == true) {
                              return "GST is Compulsary";
                            } else if (!RegExp(
                                    "[0-9]{2}[a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}[1-9A-Za-z]{1}[Z]{1}[0-9a-zA-Z]{1}")
                                .hasMatch(val.toString())) {
                              return "Enter Valid GST";
                            }
                          },
                          controller: widget.GstController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " GST",
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
                        AppBarCustom("Shipping Address",
                            Size(double.infinity, 200), () {}),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val.toString().isEmpty == true) {
                              return "Address1 is Compulsary";
                            } else if (!RegExp("[A-Za-z_0-9\.-\_,]+")
                                .hasMatch(val.toString())) {
                              return "Enter Valid Address1";
                            }
                          },
                          controller: widget.ShipAddress1Controller,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " ShipAddress1",
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
                          validator: (val) {
                            if (val.toString().isEmpty == true) {
                              return "Address2 is Compulsary";
                            } else if (!RegExp("[A-Za-z_0-9\.-\_,]+")
                                .hasMatch(val.toString())) {
                              return "Enter Valid Address2";
                            }
                          },
                          controller: widget.ShipAddress2Controller,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " ShipAddress2",
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
                          validator: (val) {
                            if (val.toString().isEmpty == true) {
                              return "Address3 is Compulsary";
                            } else if (!RegExp("[A-Za-z_0-9\.-\_,]+")
                                .hasMatch(val.toString())) {
                              return "Enter Valid Address3";
                            }
                          },
                          controller: widget.ShipAddress3Controller,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " ShipAddress3",
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
                          validator: (val) {
                            if (val.toString().isEmpty == true) {
                              return "supMobile is Compulsary";
                            } else if (!RegExp("[1-9][0-9]{9}")
                                .hasMatch(val.toString())) {
                              return "Enter Valid Mobile";
                            }
                          },
                          controller: widget.ShipMobileController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " ShipMobile",
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
                          validator: (val) {
                            if (val.toString().isEmpty == true) {
                              return "ShipPinCode is Compulsary";
                            } else if (!RegExp("[1-9][0-9]{5}")
                                .hasMatch(val.toString())) {
                              return "Enter Valid PinCode";
                            }
                          },
                          controller: widget.ShippinCodeController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " ShipPinCode",
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
                          validator: (val) {
                            if (val.toString().isEmpty == true) {
                              return "Distance is Compulsary";
                            } else if (!RegExp("[1-9][0-9]{1}")
                                .hasMatch(val.toString())) {
                              return "Enter Valid Distance";
                            }
                          },
                          controller: widget.ShipdistanceController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " ShipDistance",
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
                          onTap: () async {
                            if (_formkey.currentState!.validate()) {
                              String supplierVal = await Supplier(
                                widget.SupplierNameController.text,
                                // widget.SupplierCodeController.text,
                                widget.SupAddress1Controller.text,
                                widget.SupAddress2Controller.text,
                                widget.SupAddress3Controller.text,
                                widget.SupEmailController.text,
                                widget.SupMobileController.text,
                                widget.PinCodeController.text,
                                widget.DistanceController.text,
                                widget.ActiveDropDown_val.toString(),
                                widget.RemoveDropDown_val.toString(),
                                widget.GstController.text,
                                widget.ShipAddress1Controller.text,
                                widget.ShipAddress2Controller.text,
                                widget.ShipAddress3Controller.text,
                                widget.ShipMobileController.text,
                                widget.ShippinCodeController.text,
                                widget.ShipdistanceController.text,
                              );
                              print(supplierVal);
                              if (supplierVal == "202") {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BasePage("Home", HomePage())));
                                popUpMsg(
                                    "Successfully created Supplier And Shipping",
                                    Colors.green,
                                    context,
                                    "Success");
                              } else if (supplierVal == "203") {
                                popUpMsg(
                                    "Failed creating Supplier And Shipping pls try again...",
                                    Colors.red,
                                    context,
                                    "Error");
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
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
