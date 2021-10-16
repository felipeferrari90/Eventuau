import '../models/address_model.dart';
import 'package:event_uau/service/auth_service.dart' as AuthService;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';
import 'dart:io';

import '../models/signup_model.dart';

const Map<String, String> headers = {
  "Content-Type": "application/json",
};

class User {
  int id;
  String name;
  String cpf;
  AddressModel address;
  String phone;
  String aboutMe;
  DateTime birthDate;
  String status;
  File profilePicture;

  User({
    @required this.id,
    @required this.name,
    @required this.cpf,
    @required this.address,
    @required this.phone,
    @required this.aboutMe,
    @required this.birthDate,
    @required this.status,
    this.profilePicture,
  });

  File get userProfilePicture {
    return profilePicture != null ? new File(profilePicture.path) : null;
  }

  Map<String, dynamic> get userInfoPayload => {
        'id': this.id,
        'nome': this.name,
        'sobreMim': this.aboutMe,
        'endereco': this.address,
        'dataNascimento': this.birthDate.toIso8601String(),
        'cpf': this.cpf,
        'telefone': this.phone,
        'status': this.status,
      };
}

class Auth with ChangeNotifier {
  static final Auth _auth = Auth._internal();
  String _token;
  User user;

  // SINGLETON TO ACCESS USER DATA ON API`S
  // https://stackoverflow.com/questions/12649573/how-do-you-build-a-singleton-in-dart
  factory Auth() {
    return _auth;
  }
  Auth._internal();

  String get token {
    return _token;
  }

  bool get isAuth {
    _token != null ? print(_token) : print("nao tem token");
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

  void signout() {
    _token = null;
    notifyListeners();
  }

  Future<void> updateUserInfo(Map<String, dynamic> newData) async {
    try {
      final _userData =
          await AuthService.updateUser({...user.userInfoPayload, ...newData});

      print(_userData);
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
    } catch (e) {
      print(json.decode(e.body));
      if (e?.statusCode == 401) signout();
      throw e;
    }
  }

  set userProfilePicture(File profilePicture) {
    user.profilePicture = profilePicture;
    notifyListeners();
  }
}
