import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ApiHandler/companyApi.dart';
import 'appbar.dart';
import 'base.dart';
import 'components/popUpMessage.dart';
import 'homePage.dart';

class CompanyPage extends StatefulWidget {
  TextEditingController OrgNameController = new TextEditingController();
  TextEditingController OrgCodeController = new TextEditingController();
  TextEditingController OrgAddress1Controller = new TextEditingController();
  TextEditingController OrgAddress2Controller = new TextEditingController();
  TextEditingController OrgAddress3Controller = new TextEditingController();
  TextEditingController OrgEmailController = new TextEditingController();
  TextEditingController OrgMobileController = new TextEditingController();
  TextEditingController PinCodeController = new TextEditingController();
  TextEditingController GstController = new TextEditingController();
  TextEditingController OrgBankAcctNoController = new TextEditingController();
  TextEditingController OrgBankNameController = new TextEditingController();
  TextEditingController OrgBankIFSCController = new TextEditingController();
  TextEditingController OrgBankBranchController = new TextEditingController();
  TextEditingController OrgBankSWIFTController = new TextEditingController();
  String ActiveDropDown_val = "Yes";
  String RemoveDropDown_val = "No";
  @override
  State<CompanyPage> createState() => _Company();
}

class _Company extends State<CompanyPage> {
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
            AppBarCustom("Company", Size(double.infinity, 300), () {}),
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
                              return " OrgName is Compulsary";
                            } else if (!RegExp("[A-Za-z]+")
                                .hasMatch(val.toString())) {
                              return "Enter Valid  Org Name That Contains Only Letters";
                            }
                          },
                          controller: widget.OrgNameController,
                          decoration: InputDecoration(
                              prefix: Icon(Icons.person),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " Org Name",
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
                              return "Org Code is Compulsary";
                            } else if (!RegExp("[1-9][0-9]{9}")
                                .hasMatch(val.toString())) {
                              return "Enter Valid Org Code";
                            }
                          },
                          controller: widget.OrgCodeController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.code),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "Org Code",
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
                              return "OrgAddress1 is Compulsary";
                            } else if (!RegExp("[A-Za-z_0-9\.-\_,]+")
                                .hasMatch(val.toString())) {
                              return "Enter Valid OrgAddress1";
                            }
                          },
                          controller: widget.OrgAddress1Controller,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " OrgAddress1",
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
                              return "OrgAddress2 is Compulsary";
                            } else if (!RegExp("[A-Za-z_0-9\.-\_,]+")
                                .hasMatch(val.toString())) {
                              return "Enter Valid OrgAddress2";
                            }
                          },
                          controller: widget.OrgAddress2Controller,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " OrgAddress2",
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
                              return "OrgAddress3 is Compulsary";
                            } else if (!RegExp("[A-Za-z_0-9\.-\_,]+")
                                .hasMatch(val.toString())) {
                              return "Enter Valid OrgAddress3";
                            }
                          },
                          controller: widget.OrgAddress3Controller,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " OrgAddress3",
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
                              return "OrgEmail is Compulsary";
                            } else if (!RegExp(
                                    "[a-zA-Z_0-9\.\_]+[@][a-z]+[\.][a-z]{2,3}")
                                .hasMatch(val.toString())) {
                              return "Enter Valid OrgEmail";
                            }
                          },
                          controller: widget.OrgEmailController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " OrgEmail",
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
                              return "OrgMobile is Compulsary";
                            } else if (!RegExp("[1-9][0-9]{9}")
                                .hasMatch(val.toString())) {
                              return "Enter Valid OrgMobile";
                            }
                          },
                          controller: widget.OrgMobileController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " OrgMobile",
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
                        TextFormField(
                          validator: (val) {
                            if (val.toString().isEmpty == true) {
                              return " Org BankAcc is Compulsary";
                            } else if (!RegExp("[A-Za-z_0-9\.-\_,]+")
                                .hasMatch(val.toString())) {
                              return "Enter Valid  OrgBankAcc";
                            }
                          },
                          controller: widget.OrgBankAcctNoController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " OrgBankAcctNo",
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
                              return " OrgBankName is Compulsary";
                            } else if (!RegExp("[A-Za-z]+")
                                .hasMatch(val.toString())) {
                              return "Enter Valid  Bank Name That Contains Only Letters";
                            }
                          },
                          controller: widget.OrgBankNameController,
                          decoration: InputDecoration(
                              prefix: Icon(Icons.person),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " OrgBank Name",
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
                              return "Isfc is Compulsary";
                            } else if (!RegExp("[A-Za-z_0-9\.-\_,]+")
                                .hasMatch(val.toString())) {
                              return "Enter Valid OrgBankIfsc";
                            }
                          },
                          controller: widget.OrgBankIFSCController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " OrgBankIfsc",
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
                              return "OrgBranch is Compulsary";
                            } else if (!RegExp("[A-Za-z_0-9\.-\_,]+")
                                .hasMatch(val.toString())) {
                              return "Enter Valid OrgBranch";
                            }
                          },
                          controller: widget.OrgBankBranchController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " OrgBranch",
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
                              return " Org Swift is Compulsary";
                            } else if (!RegExp("[A-Za-z_0-9\.-\_,]+")
                                .hasMatch(val.toString())) {
                              return "Enter Valid  OrgSwift";
                            }
                          },
                          controller: widget.OrgBankSWIFTController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: " OrgSwift",
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
                              String companyVal = await Company(
                                widget.OrgNameController.text,
                                widget.OrgCodeController.text,
                                widget.OrgAddress1Controller.text,
                                widget.OrgAddress2Controller.text,
                                widget.OrgAddress3Controller.text,
                                widget.OrgEmailController.text,
                                widget.OrgMobileController.text,
                                widget.PinCodeController.text,
                                widget.ActiveDropDown_val.toString(),
                                widget.RemoveDropDown_val.toString(),
                                widget.GstController.text,
                                widget.OrgBankAcctNoController.text,
                                widget.OrgBankNameController.text,
                                widget.OrgBankIFSCController.text,
                                widget.OrgBankBranchController.text,
                                widget.OrgBankSWIFTController.text,
                              );
                              print(companyVal);
                              if (companyVal == "202") {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BasePage("Home", HomePage())));
                                popUpMsg("Successfully created Company",
                                    Colors.green, context, "Success");
                              } else if (companyVal == "203") {
                                popUpMsg(
                                    "Failed creating Company pls try again...",
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
