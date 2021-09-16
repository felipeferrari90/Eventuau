import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';
import 'dart:io';

import '../models/signup_model.dart';

const baseUrl = 'https://10.0.2.2:6001/api';

class Auth with ChangeNotifier {
  String _token;

  bool get isAuth {
    return _token != null;
  }

  Future<void> login(String email, String senha) async {
    final res = await http.post(
      '$baseUrl/usuario/$email/login',
      headers: {
        "content-type": "application/json",
      },
      body: json.encode({'senha': senha}),
    );

    if (res.statusCode != 200) {
      throw HttpException(res.body);
    }

    final responseData = res.toString();

    _token = responseData; // PASS THE TOKEN HERE XDDDDD

    notifyListeners();
  }

  Future<void> signup(SignupModel signupInfo) async {
    var url = '$baseUrl/api/usuario';

    await http.post(url, body: signupInfo.signUpIntegrationPayload);
  }
}
