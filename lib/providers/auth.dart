import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

const baseUrl = 'https://10.0.2.2:6001';

class Auth with ChangeNotifier {
  String _token;

  bool get isAuth {
    return _token != null;
  }

  Future<void> login(String email, String senha) async {
    try {
      final res = await http.post(
        '$baseUrl/api/usuario/$email/login',
        headers: {
          "content-type": "application/json",
        },
        body: json.encode({'senha': senha}),
      );

      final responseData = res.toString();

      if (res.statusCode != 200) {
        throw HttpException(responseData);
      }

      _token = responseData; // PASS THE TOKEN HERE XDDDDD

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
