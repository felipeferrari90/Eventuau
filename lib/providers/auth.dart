import 'package:event_uau/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';
import 'dart:io';

import '../models/signup_model.dart';

const baseUrl = 'https://10.0.2.2:6001/api';

const Map<String, String> headers = {
  "Content-Type": "application/json",
};

class Auth with ChangeNotifier {
  String _token;

  bool get isAuth {
    return _token != null;
  }

  Future<void> login(String email, String senha) async {
    final response = await AuthService.login(email, senha);

    _token = response['token'];

    notifyListeners();
  }
}
