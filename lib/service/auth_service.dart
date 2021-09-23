import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/signup_model.dart';

const baseUrl = 'https://10.0.2.2:6001/api';

const Map<String, String> headers = {
  "Content-Type": "application/json",
};

class AuthService {
  static Future<Map> login(String email, String senha) async {
    final res = await http.post(
      '$baseUrl/usuario/$email/login',
      headers: headers,
      body: json.encode({'senha': senha}),
    );

    if (res.statusCode != 200) {
      throw HttpException(res.body);
    }

    return json.decode(res.body);    
  }

  static Future<void> signup(SignupModel signupInfo) async {
    var url = '$baseUrl/usuario';
    var body = jsonEncode(signupInfo.signUpIntegrationPayload);

    final res = await http.post(url, headers: headers, body: body);

    if (res.statusCode != 200) {
      throw json.decode(res.body);
    }

    return res;
  }
}
