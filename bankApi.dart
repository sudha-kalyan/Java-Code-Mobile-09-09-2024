import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_ver/main.dart' as main;

Future<String> Bank(bankName, ifsc, branch, swift,remove) async {
  String url = "${main.main_url}bank";
  print(url);
  Map<String, String> body = {
    "bankName": bankName.toString(),
    "ifsc": ifsc.toString(),
    "branch": branch.toString(),
    "swift": swift.toString(),
    "remove":remove.toString(),
  };
  print(body);
  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
  print(response.body);
  return response.statusCode.toString();
}
