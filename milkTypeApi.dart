import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_ver/main.dart' as main;

Future<String> MilkType(name, code, remove) async {
  String url = "${main.main_url}milktype";
  print(url);
  Map<String, String> body = {
    "name": name.toString(),
    "code": code.toString(),
    "remove":remove.toString(),
  };
  print(body);
  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
  print(response.body);
  return response.statusCode.toString();
}
