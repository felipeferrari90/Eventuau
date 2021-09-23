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
    _token = await AuthService.login(email,senha);
    notifyListeners();
  }

  

}
