import 'package:flutter/material.dart';

import 'ApiHandler/milkTypeApi.dart';
import 'appbar.dart';
import 'base.dart';
import 'components/popUpMessage.dart';
import 'homePage.dart';

class MilkTypePage extends StatefulWidget {
  @override
  State<MilkTypePage> createState() => _MilkTypePageState();
}

class _MilkTypePageState extends State<MilkTypePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  String removeDropDownVal = "No";
  List<String> removeDropDown = ["No", "Yes"];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppBarCustom("Milk", Size(double.infinity, 300), () {}),
              SizedBox(height: 30),
              Container(
                width: 0.8 * MediaQuery.of(context).size.width,
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Name is compulsory";
                          } else if (!RegExp(r"^[A-Za-z]+$").hasMatch(val)) {
                            return "Enter a valid name containing only letters";
                          }
                          return null;
                        },
                        controller: nameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                              color: Color.fromARGB(23030, 23, 32, 49),
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "Remove",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                              color: Color.fromARGB(23030, 23, 32, 49),
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        value: removeDropDownVal,
                        items: removeDropDown.map((e) {
                          return DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            removeDropDownVal = newValue!;
                          });
                        },
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Code is compulsory";
                          } else if (!RegExp(r"^[A-Za-z_0-9\.\-,]+$")
                              .hasMatch(val)) {
                            return "Enter a valid code";
                          }
                          return null;
                        },
                        controller: codeController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.streetview),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "Code",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                              color: Color.fromARGB(23030, 23, 32, 49),
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            String milkVal = await MilkType(
                              nameController.text,
                              codeController.text,
                              removeDropDownVal,
                            );

                            print(milkVal);
                            if (milkVal == "202") {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BasePage("Home", HomePage()),
                                ),
                              );
                              popUpMsg(
                                "Successfully created MilkType",
                                Colors.green,
                                context,
                                "Success",
                              );
                            } else if (milkVal == "203") {
                              popUpMsg(
                                "Failed creating Milk Type, please try again...",
                                Colors.red,
                                context,
                                "Error",
                              );
                            }
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            color: Color.fromARGB(255, 54, 103, 166),
                          ),
                          height: 60,
                          width: 0.5 * MediaQuery.of(context).size.width,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Submit",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
