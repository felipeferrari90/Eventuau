import 'dart:convert';
import 'dart:io';
import '../providers/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/signup_model.dart';

const baseUrl = 'https://10.0.2.2:6001/api';

const Map<String, String> headers = {
  "Content-Type": "application/json",
};

final userData = Auth();

Future<Map> login(String email, String senha) async {
  final res = await http.post(
    '$baseUrl/usuario/$email/login',
    headers: headers,
    body: json.encode({'senha': senha}),
  );

  if (res.statusCode != 200) {
    debugPrint("ERRO NA LISTAGEM");
    throw HttpException(res.body);
  }
  return json.decode(res.body);
}

Future<void> signup(SignupModel signupInfo) async {
  var url = '$baseUrl/usuario';
  var body = jsonEncode(signupInfo.signUpIntegrationPayload);

  final res = await http.post(url, headers: headers, body: body);

  if (res.statusCode != 200 && res.statusCode != 201)
    throw json.decode(res.body);
  
  return res;
}

Future<Map<String, dynamic>> updateUser(Map<String, dynamic> payload) async {
  final res = await http.put('$baseUrl/usuario',
      headers: {
        ...headers,
        HttpHeaders.authorizationHeader: 'Bearer ${userData.token}'
      },
      body: json.encode(payload));

  if (res.statusCode != 200) throw res;

  return json.decode(res.body);
}
