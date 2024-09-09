import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_ver/main.dart' as main;

Future<List<String>> loginSub(
  phone,
  password,
) async {
  String url = "${main.main_url}loginMobile";
  print(url);
  Map<String, String> body = {
    "mobile": phone.toString(),
    "password": password.toString(),
  };
  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
  print(response.body);
  return [response.statusCode.toString(), response.body.toString()];
}
