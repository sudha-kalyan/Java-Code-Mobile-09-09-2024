import 'dart:convert';

import '../main.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_ver/main.dart' as main;

Future<String> Supplier(
    supplierName,
    supAddress1,
    supAddress2,
    supAddress3,
    supEmail,
    supMobile,
    pinCode,
    distance,
    active,
    remove,
    gst,
    shipAddress1,
    shipAddress2,
    shipAddress3,
    shipMobile,
    shippinCode,
    shipdistance) async {
  String url = "${main.main_url}supplier";
  print(url);
  Map<String, String> body = {
    "supplierName": supplierName.toString(),
    "supAddress1": supAddress1.toString(),
    "supAddress2": supAddress2.toString(),
    "supAddress3": supAddress3.toString(),
    "supEmail": supEmail.toString(),
    "supMobile": supMobile.toString(),
    "pinCode": pinCode.toString(),
    "distance": distance.toString(),
    "active": active.toString(),
    "remove": remove.toString(),
    "gst": gst.toString(),
    "shipAddress1": shipAddress1.toString(),
    "shipAddress2": shipAddress2.toString(),
    "shipAddress3": shipAddress3.toString(),
    "shipMobile": shipMobile.toString(),
    "shippinCode": shippinCode.toString(),
    "shipdistance": shipdistance.toString(),
  };
  print(body);
  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
  print(response.body);
  return response.statusCode.toString();
}
