import 'package:flutter/material.dart';
import 'package:mobile_ver/ApiHandler/loginApi.dart';
import 'package:mobile_ver/appbar.dart';
import 'package:mobile_ver/main.dart';

import 'base.dart';
import 'homePage.dart';
import 'components/popUpMessage.dart';

class LoginPage extends StatefulWidget {
  TextEditingController PhoneController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscureText = true;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: [
          AppBarCustom("Login", Size(double.infinity, 50), () {}),
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
                          } else if (!RegExp("[A-Za-z_0-9\.-\_@!#\$%^&*()]{3,}")
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
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_formkey.currentState!.validate()) {
                            List loginVal = await loginSub(
                                widget.PhoneController.text,
                                widget.PasswordController.text);
                            if (loginVal[0] == "202") {
                              storage.setItem("loggedIn", true);
                              storage.setItem(
                                  "loggedPhone", widget.PhoneController.text);
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BasePage("Home", HomePage())));
                              popUpMsg("Successfully logged in", Colors.green,
                                  context, "Success");
                            } else {
                              popUpMsg(
                                  loginVal[1], Colors.red, context, "Error");
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
                                "Login",
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
    );
  }
}
