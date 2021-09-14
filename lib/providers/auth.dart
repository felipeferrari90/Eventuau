import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

const baseUrl = 'https://localhost:6001';

class Auth with ChangeNotifier {
  String _token;

  bool get isAuth {
    return _token != null;
  }

  Future<void> login(String email, String senha) async {
    // try {
    //   final res = await http.post(
    //     '$baseUrl/api/usuario/$email/login',
    //     body: json.encode({'senha': senha}),
    //   );

    //   final responseData = json.decode(res.body);

    //   if (res.statusCode != 200) {
    //     throw HttpException(responseData);
    //   }

    //   _token = 'ohwow'; // PASS THE TOKEN HERE XDDDDD

    //   notifyListeners();
    // } catch (e) {
    //   throw e;
    // }

    await Future.delayed(Duration(seconds: 5), () {
      _token = "HAHAHAHA";
    });

    notifyListeners();
  }
}
