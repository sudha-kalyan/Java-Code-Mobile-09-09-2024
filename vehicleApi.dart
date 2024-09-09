import 'dart:convert';

import 'package:mobile_ver/main.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_ver/main.dart' as main;

import '../main.dart';

Future<String> Vehicle(
    vehicleNo, suplAttached1, chasisNumber, owner, rateperKm) async {
  var main_url;
  String url = "${main.main_url}vehicle";
  print(url);
  Map<String, String> body = {
    "vehicleNo": vehicleNo.toString(),

    "suplAttached1": suplAttached1.toString(),
    // "suplAttached2": suplAttached2.toString(),
    // "suplAttached3": suplAttached3.toString(),
    // "active": active.toString(),
    // "remove": remove.toString(),
    "chasisNumber": chasisNumber.toString(),
    "owner": owner.toString(),
    // "capacity": capacity.toString(),
    // "compartments": compartments.toString(),
    "rateperKm": rateperKm.toString()
  };
  print(body);
  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
  print(response.body);
  return response.statusCode.toString();
}
