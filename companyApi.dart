import 'dart:convert';

import 'package:mobile_ver/main.dart';

import '../main.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_ver/main.dart' as main;

Future<String> Company(
    orgName,
    orgCode,
    orgAddress1,
    orgAddress2,
    orgAddress3,
    orgEmail,
    orgMobile,
    pinCode,
    active,
    remove,
    gst,
    orgBankAcctNo,
    orgBankName,
    orgBankIFSC,
    orgBankBranch,
    orgBankSWIFT) async {
  String url = "${main.main_url}company";
  print(url);
  Map<String, String> body = {
    "orgName": orgName.toString(),
    "orgCode": orgCode.toString(),
    "orgAddress1": orgAddress1.toString(),
    "orgAddress2": orgAddress2.toString(),
    "orgAddress3": orgAddress3.toString(),
    "orgEmail": orgEmail.toString(),
    "orgMobile": orgMobile.toString(),
    "pinCode": pinCode.toString(),
    "active": active.toString(),
    "remove": remove.toString(),
    "gst": gst.toString(),
    "orgBankAcctNo": orgBankAcctNo.toString(),
    "orgBankName": orgBankName.toString(),
    "orgBankIFSC": orgBankIFSC.toString(),
    "orgBankBranch": orgBankBranch.toString(),
    "orgBankSWIFT": orgBankSWIFT.toString(),
  };
  print(body);
  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
  print(response.body);
  return response.statusCode.toString();
}
