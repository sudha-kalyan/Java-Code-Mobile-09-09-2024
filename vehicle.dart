import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'ApiHandler/vehicleApi.dart';
import 'appbar.dart';
import 'base.dart';
import 'components/datePicker.dart' as datePicker;
import 'components/popUpMessage.dart';
import 'homePage.dart';

class VehiclePage extends StatefulWidget {
  // DateTime vehStartDate = DateTime.now();
  // DateTime vehEndDate = DateTime.now();

  TextEditingController VehicleNoController = new TextEditingController();

  TextEditingController SuplAttached1Controller = new TextEditingController();
  // TextEditingController SuplAttached2Controller = new TextEditingController();
  // TextEditingController SuplAttached3Controller = new TextEditingController();
  TextEditingController ChasisNumberController = new TextEditingController();
  TextEditingController OwnerController = new TextEditingController();
  TextEditingController RateperKmController = new TextEditingController();
  // String ActiveDropDown_val = "Yes";
  // String RemoveDropDown_val = "No";
  // String CapacityDropDown_val = "9L";
  // String CompartmentsDropDown_val = "1";
  @override
  State<VehiclePage> createState() => _Vehicle();
}

class _Vehicle extends State<VehiclePage> {
  // List ActiveDropDown = ["Yes", "No"];
  // List RemoveDropDown = ["No", "Yes"];
  // List CapacityDropDown = ["9L", "15L", "20L"];
  // List CompartmentsDropDown = ["1", "2"];

  bool obscureText = true;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBarCustom(
                "Create Vehicle Details", Size(double.infinity, 300), () {}),
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
                              return " VehicleNo is Compulsary";
                            } else if (!RegExp("[A-Za-z]+")
                                .hasMatch(val.toString())) {
                              return "Enter Valid  Org Name That Contains Only Letters";
                            }
                          },
                          controller: widget.VehicleNoController,
                          decoration: InputDecoration(
                              prefix: Icon(Icons.person),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "VehicleNo",
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
                        // GestureDetector(
                        //   onTap: () => datePicker.showDatePicker(
                        //       context, OnDateChange, widget.selectedDate),
                        //   child: Container(
                        //     height: 50,
                        //     width: double.infinity,
                        //     decoration: BoxDecoration(
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(50)),
                        //         color: Colors.white),
                        //     child: Center(
                        //       child: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceEvenly,
                        //           crossAxisAlignment: CrossAxisAlignment.center,
                        //           children: [
                        //             Icon(Icons.calendar_month),
                        //             Text(
                        //               "VehStartDate: ",
                        //               style: TextStyle(fontSize: 25),
                        //             ),
                        //             Text(
                        //               DateFormat('dd-MM-yyyy')
                        //                   .format(widget.selectedDate)
                        //                   .toString(),
                        //               style: TextStyle(fontSize: 15),
                        //             )
                        //           ]),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // GestureDetector(
                        //   onTap: () => datePicker.showDatePicker(
                        //       context, OnDateChange, widget.selectedDate),
                        //   child: Container(
                        //     height: 50,
                        //     width: double.infinity,
                        //     decoration: BoxDecoration(
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(50)),
                        //         color: Colors.white),
                        //     child: Center(
                        //       child: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceEvenly,
                        //           crossAxisAlignment: CrossAxisAlignment.center,
                        //           children: [
                        //             Icon(Icons.calendar_month),
                        //             Text(
                        //               "VehhEndDate: ",
                        //               style: TextStyle(fontSize: 25),
                        //             ),
                        //             Text(
                        //               DateFormat('dd-MM-yyyy')
                        //                   .format(widget.selectedDate)
                        //                   .toString(),
                        //               style: TextStyle(fontSize: 15),
                        //             )
                        //           ]),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        TextFormField(
                          validator: (val) {
                            if (val.toString().isEmpty == true) {
                              return "SuplAttached1 is Compulsary";
                            } else if (!RegExp("[A-Za-z_0-9\.-\_,]+")
                                .hasMatch(val.toString())) {
                              return "Enter Valid SuplAttached1";
                            }
                          },
                          controller: widget.SuplAttached1Controller,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " SuplAttached1",
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
                        // TextFormField(
                        //   validator: (val) {
                        //     if (val.toString().isEmpty == true) {
                        //       return "SuplAttached2 is Compulsary";
                        //     } else if (!RegExp("[A-Za-z_0-9\.-\_,]+")
                        //         .hasMatch(val.toString())) {
                        //       return "Enter Valid SuplAttached2";
                        //     }
                        //   },
                        //   controller: widget.SuplAttached2Controller,
                        //   decoration: InputDecoration(
                        //       prefixIcon: Icon(Icons.streetview),
                        //       fillColor: Colors.white,
                        //       filled: true,
                        //       labelText: "SuplAttached2",
                        //       border: OutlineInputBorder(
                        //           borderRadius:
                        //               BorderRadius.all(Radius.circular(30)),
                        //           borderSide: BorderSide(
                        //               color: Color.fromARGB(23030, 23, 32, 49),
                        //               style: BorderStyle.solid))),
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // TextFormField(
                        //   validator: (val) {
                        //     if (val.toString().isEmpty == true) {
                        //       return "SuplAttached3 is Compulsary";
                        //     } else if (!RegExp("[A-Za-z_0-9\.-\_,]+")
                        //         .hasMatch(val.toString())) {
                        //       return "Enter Valid SuplAttached3";
                        //     }
                        //   },
                        //   controller: widget.SuplAttached3Controller,
                        //   decoration: InputDecoration(
                        //       prefixIcon: Icon(Icons.streetview),
                        //       fillColor: Colors.white,
                        //       filled: true,
                        //       labelText: " SuplAttached3",
                        //       border: OutlineInputBorder(
                        //           borderRadius:
                        //               BorderRadius.all(Radius.circular(30)),
                        //           borderSide: BorderSide(
                        //               color: Color.fromARGB(23030, 23, 32, 49),
                        //               style: BorderStyle.solid))),
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        TextFormField(
                          validator: (val) {
                            if (val.toString().isEmpty == true) {
                              return "ChasisNumber is Compulsary";
                            } else if (!RegExp("[A-Za-z_0-9\.-\_,]+")
                                .hasMatch(val.toString())) {
                              return "Enter Valid ChasisNumber";
                            }
                          },
                          controller: widget.ChasisNumberController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " ChasisNumber",
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
                              return " OwnerName is Compulsary";
                            } else if (!RegExp("[A-Za-z]+")
                                .hasMatch(val.toString())) {
                              return "Enter Valid  Owner Name That Contains Only Letters";
                            }
                          },
                          controller: widget.OwnerController,
                          decoration: InputDecoration(
                              prefix: Icon(Icons.person),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " Owner Name",
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
                              return "RateperKm is Compulsary";
                            } else if (!RegExp("[1-9][0-9]{1}")
                                .hasMatch(val.toString())) {
                              return "Enter Valid RateperKm";
                            }
                          },
                          controller: widget.RateperKmController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " RateperKm",
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
                              String vehicleVal = await Vehicle(
                                  widget.VehicleNoController.text,
                                  widget.SuplAttached1Controller.text,
                                  widget.ChasisNumberController.text,
                                  widget.OwnerController.text,
                                  widget.RateperKmController.text);

                              print(vehicleVal);
                              if (vehicleVal == "202") {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BasePage("Home", HomePage())));
                                popUpMsg("Successfully created Vehicle",
                                    Colors.green, context, "Success");
                              } else if (vehicleVal == "203") {
                                popUpMsg(
                                    "Failed creating Vehicle pls try again...",
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
