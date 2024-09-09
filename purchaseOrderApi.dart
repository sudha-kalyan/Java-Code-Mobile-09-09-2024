import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile_ver/main.dart' as main;

Future<Map> getSupplyVehicleDetails(DateTime date) async {
  Map<String, String> body = {
    'date': DateFormat("dd-MM-yyyy").format(date).toString()
  };
  print(body);
  final http.Response response = await http.post(
      Uri.parse("${main.main_url}getSupplyVehicleDetails"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body));
  return jsonDecode(response.body) as Map;
}

Future<Map> getInvs(DateTime date) async {
  Map<String, String> body = {
    'date': DateFormat("dd-MM-yyyy").format(date).toString()
  };
  print(body);
  final http.Response response = await http.post(
      Uri.parse("${main.main_url}getInvs"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body));
  return jsonDecode(response.body) as Map;
}

Future<Map> getPO(String invNo) async {
  Map<String, String> body = {
    'InvNo': invNo,
  };
  print(body);
  final http.Response response = await http.post(
      Uri.parse("${main.main_url}getPO"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body));
  return jsonDecode(response.body) as Map;
}

Future<List> getPOS(String supplier, DateTime date, String InvType) async {
  Map<String, String> body = {
    'suplCode': supplier,
    'date': DateFormat("dd-MM-yyyy").format(date).toString(),
    "invType": InvType,
  };
  print(body);
  final http.Response response = await http.post(
      Uri.parse("${main.main_url}getPOS"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body));
  print(jsonDecode(response.body));
  return jsonDecode(response.body) as List;
}

Future<Map> getSuplrs() async {
  final http.Response response = await http.get(
    Uri.parse("${main.main_url}getSuppliers"),
  );
  return jsonDecode(response.body) as Map;
}

Future<int> purchaseOrder(Map body) async {
  String url = "${main.main_url}purchaseOrderMob";
  print(url);
  print(body);
  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
  print(response.body);
  return response.statusCode;
}

Future<int> updpurchaseOrder(Map body) async {
  String url = "${main.main_url}updatepurchaseOrderMob";
  print(url);

  print(body);
  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
  print(response.body);
  return response.statusCode;
}
// working 28-08-2024 16:30 PM
// Future<List> getPOSOA() async {
//   Map<String, String> body = {};
//   print(body);
//   final http.Response response = await http.post(
//       Uri.parse("${main.main_url}getPOSOA"),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode(body));
//   print(jsonDecode(response.body));
//   return jsonDecode(response.body) as List;
// }

Future<List> getPOSOA(String supplier, DateTime fromDate,DateTime toDate,String paymentStatus) async {
  Map<String, String> body = {
    'suplCode': supplier,
    'paymentStatus': paymentStatus,
    'fromDate': DateFormat("dd-MM-yyyy").format(fromDate).toString(),
    'toDate': DateFormat("dd-MM-yyyy").format(toDate).toString(),


  };
  print('payment status chagned ${body}');
  print(body);
  final http.Response response = await http.post(
      Uri.parse("${main.main_url}getPOSOA"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body));
  print(jsonDecode(response.body));
  return jsonDecode(response.body) as List;
}

// Future<List> getPOSOA(String supplier, DateTime date) async {
//   Map<String, String> body = {
//   'suplCode': supplier,
//   'date': DateFormat("dd-MM-yyyy").format(date).toString(),
//
//   print(body);
//   final http.Response response = await http.post(
//       Uri.parse("${main.main_url}getPOSOA"),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode(body));
//   print(jsonDecode(response.body));
//   return jsonDecode(response.body) as List;
// }
//
//   }
