import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:mobile_ver/main.dart' as main;

Future<Map> getOrderDetails(DateTime date) async {
  Map<String, String> body = {
    'date': DateFormat("dd-MM-yyyy").format(date).toString(),
  };
  print(body);

  final http.Response response = await http.post(
      Uri.parse("${main.main_url}getOrderDetails"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body));
  print(jsonDecode(response.body));
  return jsonDecode(response.body) as Map;
}

Future<String> SaleOrder(
  DateTime date,
  orderNo,
  prodCode,
  custCode,
  disc,
  netAmount,
  amount,
  quantity,
  unitRate,
    paymentStatus,
    prodLabel


) async {
  String url = "${main.main_url}saleOrderMob";
  print(url);
  Map<String, String> body = {
    'date': DateFormat("dd-MM-yyyy").format(date).toString(),
    "orderNo": orderNo.toString(),
    "prodCOde": prodCode.toString(),
    "custCode": custCode.toString(),
    "disc": disc.toString(),
    "netAmount": netAmount.toString(),
    "amount": amount.toString(),
    "quantity": quantity.toString(),
    "unitRate": unitRate.toString(),
    "paymentStatus": paymentStatus.toString(),
    "prodLabel": prodLabel.toString(),

  };
  // it is same chek the order
  print(body);
  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
  print(response.body);
  return response.statusCode.toString();
}

Future<Map> getCustomerDetails(DateTime date) async {
  Map<String, String> body = {
    'date': DateFormat("dd-MM-yyyy").format(date).toString()
  };
  print(body);
  final http.Response response = await http.post(
      Uri.parse("${main.main_url}getCustomerDetails"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body));
  return jsonDecode(response.body) as Map;
}

Future<int> saleOrderMob(Map body) async {
  String url = "${main.main_url}saleOrderMob";
  print(url);
  print(body);


  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
  print(response.body);
  return response.statusCode;
}

Future<Map> getSO(String orderNo) async {
  Map<String, String> body = {
    'orderNo': orderNo,
  };
  print(body);
  final http.Response response = await http.post(
      Uri.parse("${main.main_url}getSO"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body));
  return jsonDecode(response.body) as Map;
}

//29-08-2024
Future<List> getSOA(String customer, DateTime fromDate,DateTime toDate,String paymentStatus) async {
  Map<String, String> body = {
    'custCode': customer,
    'paymentStatus': paymentStatus,
    'fromDate': DateFormat("dd-MM-yyyy").format(fromDate).toString(),
    'toDate': DateFormat("dd-MM-yyyy").format(toDate).toString(),


  };
  print('payment statch chagned ${body}');
  print(body);
  final http.Response response = await http.post(
      Uri.parse("${main.main_url}getSOA"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body));
  print(jsonDecode(response.body));
  return jsonDecode(response.body) as List;
}
//29-08-2024

Future<Map> getSales(DateTime date) async {
  Map<String, String> body = {
    'date': DateFormat("dd-MM-yyyy").format(date).toString()
  };
  print(body);
  final http.Response response = await http.post(
      Uri.parse("${main.main_url}getSales"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body));
  print("@23" + response.body.toString());

  return jsonDecode(response.body) as Map;
}

// Future<Map> getSOS(String orderNo, String string) async {
//   Map<String, String> body = {
//     'OrderNo': orderNo,
//   };
//   print(body);
//   final http.Response response = await http.post(
//       Uri.parse("${main.main_url}getSOS"),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode(body));
//   return jsonDecode(response.body) as Map;
// }

Future<List> getSOS(String customer, DateTime date,String orderNo) async {
  Map<String, String> body = {
    'custCode': customer,
    'date': DateFormat("dd-MM-yyyy").format(date).toString(),
    "orderNo" :orderNo,

  };
  print(body);
  final http.Response response = await http.post(
      Uri.parse("${main.main_url}getSOS"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body));
  print(jsonDecode(response.body));
  return jsonDecode(response.body) as List;
}

Future<Map> getCustomrs() async {
  final http.Response response = await http.get(
    Uri.parse("${main.main_url}getCustomers"),
  );
  return jsonDecode(response.body) as Map;
}

Future<int> updsaleOrder(Map body) async {
  String url = "${main.main_url}updatesaleOrderMob";
  print(url);

  print(body);
  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
  print(response.body);
  return response.statusCode;
}
