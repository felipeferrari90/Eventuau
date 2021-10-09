import 'dart:convert';

import 'package:flutter/material.dart';

class AddressModel {
  String latitude;
  String longitude;
  String cep;
  String rua;
  String numero;
  String complemento;
  String bairro;
  String cidade;
  String estado;

  AddressModel(
      {@required this.latitude,
      @required this.longitude,
      @required this.cep,
      @required this.rua,
      @required this.numero,
      @required this.bairro,
      @required this.cidade,
      @required this.estado,
      this.complemento});

  get apiPayload {
    return json.encode({
      "latitude": this.latitude,
      "longitude": this.longitude,
      "cep": this.cep,
      "numero": this.numero,
      "complemento": this.complemento,
    });
  }

  @override
  String toString() {
    return '${this.rua} ${this.numero} ${this.complemento}, ${this.cep} - ${this.bairro} ${this.cidade} - ${this.estado}';
  }
}
