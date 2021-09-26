import 'package:event_uau/service/auth_service.dart' as AuthService;
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

class User {
  int id;
  String name;
  String cpf;
  String address;
  String phone;
  String aboutMe;
  DateTime birthDate;
  String status;

  User({
    @required this.id,
    @required this.name,
    @required this.cpf,
    @required this.address,
    @required this.phone,
    @required this.aboutMe,
    @required this.birthDate,
    @required this.status,
  });
}

class Auth with ChangeNotifier {
  String _token;  
  User user;

  bool get isAuth {
    return _token != null;
  }

  Future<void> login(String email, String senha) async {
    final response = await AuthService.login(email, senha);

    _token = response['token'];
    Map<String, dynamic> _userData = response['usuario'];

    user = new User(
      id: _userData['id'],
      name: _userData['nome'],
      aboutMe: _userData['sobreMim'],
      address: _userData['endereco'],
      birthDate: DateTime.parse((_userData['dataNascimento'])),
      cpf: _userData['cpf'],
      phone: _userData['telefone'],
      status: _userData['status'],
    );

    notifyListeners();
  }
}
