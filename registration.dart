import 'package:flutter/material.dart';
import 'package:mobile_ver/ApiHandler/registrationApi.dart';
import 'package:mobile_ver/appbar.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_ver/base.dart';
import 'package:mobile_ver/components/popUpMessage.dart';
import 'package:mobile_ver/homePage.dart';

class RegisterPage extends StatefulWidget {
  TextEditingController NameController = new TextEditingController();
  TextEditingController EmailController = new TextEditingController();
  TextEditingController PhoneController = new TextEditingController();
  TextEditingController PasswordController = new TextEditingController();
  TextEditingController AddressController = new TextEditingController();
  TextEditingController CityController = new TextEditingController();
  TextEditingController PincodeController = new TextEditingController();
  String StateDropDown_val = "Telengana";
  String? orgCode;
  late Future getOrganisations_obj = getOrganisations();

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  List StateDropDown = ["Telengana", "Andhra Pradesh"];
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
            AppBarCustom("Register", Size(double.infinity, 300), () {}),
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
                              return "Name is Compulsary";
                            } else if (!RegExp("[A-Za-z]+")
                                .hasMatch(val.toString())) {
                              return "Enter Valid Name That Contains Only Letters";
                            }
                          },
                          controller: widget.NameController,
                          decoration: InputDecoration(
                              prefix: Icon(Icons.person),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "Name",
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
                              prefixIcon: Icon(Icons.email),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "Email",
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
                            future: widget.getOrganisations_obj,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                print(snapshot.data);
                                Map map = snapshot.data as Map;
                                print(map);
                                List orgs = map['orgs'] as List;
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
                                        value: widget.orgCode,
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.numbers),
                                            fillColor: Colors.white,
                                            filled: true,
                                            labelText: "Organisation",
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30)),
                                                borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        23030, 23, 32, 49),
                                                    style: BorderStyle.solid))),
                                        items: orgs
                                            .map<DropdownMenuItem<String>>((e) {
                                          return DropdownMenuItem(
                                              child: Text(e[0].toString()),
                                              value: e[1].toString());
                                        }).toList(),
                                        onChanged: (val) {
                                          setState(() {
                                            widget.orgCode = val as String?;
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
                              return "Phone Number is Compulsary";
                            } else if (!RegExp("[1-9][0-9]{9}")
                                .hasMatch(val.toString())) {
                              return "Enter Valid Phone Number";
                            }
                          },
                          keyboardType: TextInputType.phone,
                          controller: widget.PhoneController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "Phone",
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
                              return "Password is Compulsary";
                            } else if (!RegExp(
                                    "[A-Za-z_0-9\.-\_@!#\$%^&*()]{3,}")
                                .hasMatch(val.toString())) {
                              return "Password must Contain atleast 3 characters";
                            }
                          },
                          obscureText: obscureText,
                          controller: widget.PasswordController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.password),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                    });
                                  },
                                  icon: Icon(obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "password",
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
                          controller: widget.AddressController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.streetview),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "Address",
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
                              return "City is Compulsary";
                            } else if (!RegExp("[A-Za-z]+")
                                .hasMatch(val.toString())) {
                              return "Enter Valid City";
                            }
                          },
                          controller: widget.CityController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.location_city),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "City",
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
                                labelText: "State",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(23030, 23, 32, 49),
                                        style: BorderStyle.solid))),
                            value: widget.StateDropDown_val,
                            items: StateDropDown.map<DropdownMenuItem<String>>(
                                (e) {
                              return DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              );
                            }).toList(),
                            onChanged: (changeValue) {
                              setState(() {
                                widget.StateDropDown_val =
                                    changeValue.toString();
                              });
                            }),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val.toString().isEmpty == true) {
                              return "Pincode is Compulsary";
                            } else if (!RegExp("[0-9]{6}")
                                .hasMatch(val.toString())) {
                              return "Enter Valid Pincode";
                            }
                          },
                          keyboardType: TextInputType.number,
                          controller: widget.PincodeController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.pin),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "pincode",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(23030, 23, 32, 49),
                                      style: BorderStyle.solid))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_formkey.currentState!.validate()) {
                              String registerVal = await Register(
                                  widget.NameController.text,
                                  widget.EmailController.text,
                                  widget.PhoneController.text,
                                  widget.PasswordController.text,
                                  widget.AddressController.text,
                                  widget.CityController.text,
                                  widget.StateDropDown_val.toString(),
                                  widget.PincodeController.text,
                                  widget.orgCode.toString());
                              print(registerVal);
                              if (registerVal == "202") {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BasePage("Home", HomePage())));
                                popUpMsg(
                                    "Successfully created account pls login",
                                    Colors.green,
                                    context,
                                    "Success");
                              } else if (registerVal == "203") {
                                popUpMsg(
                                    "Failed creating account pls try again...",
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
                                  "Sign Up",
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
