import 'package:event_uau/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';
import 'dart:io';

import '../models/signup_model.dart';

const baseUrl = 'https://localhost:6001/api';

const Map<String, String> headers = {
  "Content-Type": "application/json",
};

class Auth with ChangeNotifier {
  String _token;
  String _userName;

  bool get isAuth {
    return _token != null;
  }

  String get username{
    return _userName;
  }

  Future<void> login(String email, String senha) async {
<<<<<<< HEAD
    final res = await http.post(
      '$baseUrl/usuario/$email/login',
      headers: headers,
      body: json.encode({'senha': senha}),
    );

    if (res.statusCode != 200) {
      throw HttpException(res.body);
    }

    final responseData = res.body.toString();

    _token = responseData; // PASS THE TOKEN HERE XDDDDD
    _userName = jsonDecode(res.body).toMap()['name'];

    notifyListeners();
  }

  Future<void> signup(SignupModel signupInfo) async {
    var url = '$baseUrl/usuario';
    var body = jsonEncode(signupInfo.signUpIntegrationPayload);

    final res = await http.post(url, headers: headers, body: body);

    if (res.statusCode != 200) {
      throw json.decode(res.body);
    }

    
  }

    await AuthService.login(email, senha);

    notifyListeners();
  }

}
