import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_ver/main.dart' as main;

Future<String> Register(name, email, phone, password, address, city, state,
    pincode, orgcode) async {
  String url = "${main.main_url}registerMobile";
  print(url);
  Map<String, String> body = {
    "name": name.toString(),
    "email": email.toString(),
    "loginID": phone.toString(),
    "password": password.toString(),
    "address": address.toString(),
    "city": city.toString(),
    "state": state.toString(),
    "pincode": pincode.toString(),
    "role": "Rustomer",
    "branch": "Raithanna",
    "orgCode": orgcode.toString(),
  };
  print(body);
  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
  print(response.body);
  return response.statusCode.toString();
}

Future<Map> getOrganisations() async {
  final http.Response response = await http.get(
    Uri.parse("${main.main_url}getOrganisations"),
  );
  return jsonDecode(response.body) as Map;
}
