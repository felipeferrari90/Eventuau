import 'package:flutter/material.dart';

class SignupModel {
  String name;

  String email;
  String cpf;
  String password;
  String phone;
  String birthDate;

  SignupModel(
      {@required this.name,
      @required this.email,
      @required this.cpf,
      @required this.birthDate,
      @required this.password,
      @required this.phone});

  Map<String, String> get signUpIntegrationPayload {
    var splitName = name.split(' ');

    return {
      'nome': '${splitName[0]} ${splitName[1]}',
      'sobreNome': splitName.last,
      'email': email,
      'cpf': cpf,
      'senha': password,
      'confirmarSenha': password,
      'telefone': phone,
      'dataNascimento': birthDate.split('/').reversed.join('-')
    };
  }
}
