import 'package:flutter/material.dart';

import 'ApiHandler/customerApi.dart';
import 'appbar.dart';
import 'base.dart';
import 'components/popUpMessage.dart';
import 'homePage.dart';

class CustomerPage extends StatefulWidget {
  TextEditingController CustNameController = new TextEditingController();
  TextEditingController MobileNoController = new TextEditingController();
  TextEditingController EmailController = new TextEditingController();
  TextEditingController CustAddr1Controller = new TextEditingController();
  TextEditingController CustAddr2Controller = new TextEditingController();
  TextEditingController CustAddr3Controller = new TextEditingController();
  TextEditingController CustPostCodeController = new TextEditingController();
  TextEditingController CustGstController = new TextEditingController();

  @override
  State<CustomerPage> createState() => _Customer();
}

class _Customer extends State<CustomerPage> {
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
            AppBarCustom("Create Customer", Size(double.infinity, 300), () {}),
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
                              return " CustName is Compulsary";
                            } else if (!RegExp("[A-Za-z]+")
                                .hasMatch(val.toString())) {
                              return "Enter Valid  Cust Name That Contains Only Letters";
                            }
                          },
                          controller: widget.CustNameController,
                          decoration: InputDecoration(
                              prefix: Icon(Icons.person),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " Cust Name",
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
                              return "Mobile is Compulsary";
                            } else if (!RegExp("[1-9][0-9]{9}")
                                .hasMatch(val.toString())) {
                              return "Enter Valid Mobile";
                            }
                          },
                          controller: widget.MobileNoController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " Mobile",
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
                          controller: widget.EmailController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " Email",
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
                              return "CustAddr1 is Compulsary";
                            } else if (!RegExp("[A-Za-z_0-9\.-\_,]+")
                                .hasMatch(val.toString())) {
                              return "Enter Valid CustAddr1";
                            }
                          },
                          controller: widget.CustAddr1Controller,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " CustAddr1",
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
                              return "CustAddr2 is Compulsary";
                            } else if (!RegExp("[A-Za-z_0-9\.-\_,]+")
                                .hasMatch(val.toString())) {
                              return "Enter Valid CustAddr2";
                            }
                          },
                          controller: widget.CustAddr2Controller,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " CustAddr2",
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
                              return "CustAddr3 is Compulsary";
                            } else if (!RegExp("[A-Za-z_0-9\.-\_,]+")
                                .hasMatch(val.toString())) {
                              return "Enter Valid CustAddr3";
                            }
                          },
                          controller: widget.CustAddr3Controller,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " CustAddr3",
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
                              return "CustPostCode is Compulsary";
                            } else if (!RegExp("[1-9][0-9]{5}")
                                .hasMatch(val.toString())) {
                              return "Enter Valid PinCode";
                            }
                          },
                          controller: widget.CustPostCodeController,
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
                              return "GST is Compulsary";
                            } else if (!RegExp(
                                    "[0-9]{2}[a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}[1-9A-Za-z]{1}[Z]{1}[0-9a-zA-Z]{1}")
                                .hasMatch(val.toString())) {
                              return "Enter Valid GST";
                            }
                          },
                          controller: widget.CustGstController,
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
                        GestureDetector(
                          onTap: () async {
                            if (_formkey.currentState!.validate()) {
                              String customerVal = await Customer(
                                widget.CustNameController.text,
                                widget.MobileNoController.text,
                                widget.EmailController.text,
                                widget.CustAddr1Controller.text,
                                widget.CustAddr2Controller.text,
                                widget.CustAddr3Controller.text,
                                widget.CustPostCodeController.text,
                                widget.CustGstController.text,
                              );
                              print(customerVal);
                              if (customerVal == "202") {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BasePage("Home", HomePage())));
                                popUpMsg("Successfully created Customer",
                                    Colors.green, context, "Success");
                              } else if (customerVal == "203") {
                                popUpMsg(
                                    "Failed creating Customer pls try again...",
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
