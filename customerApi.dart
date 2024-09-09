import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_ver/main.dart';

import '../main.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_ver/main.dart' as main;

Future<String> Customer(custName, mobileNo, email, custAddr1, custAddr2,
    custAddr3, custPostCode, custGst) async {
  String url = "${main.main_url}createCustomer";
  print(url);
  Map<String, String> body = {
    "custName": custName.toString(),
    "mobileNo": mobileNo.toString(),
    "email": email.toString(),
    "custAddr1": custAddr1.toString(),
    "custAddr2": custAddr2.toString(),
    "custAddr3": custAddr3.toString(),
    "custPostCode": custPostCode.toString(),
    "custGst": custGst.toString(),
  };
  print(body);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
  print(response.body);
  return response.statusCode.toString();
}
