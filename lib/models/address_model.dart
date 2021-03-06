import 'dart:convert';

import 'package:flutter/material.dart';

enum AddressType { Event, User }

class AddressModel {
  int id;
  String latitude;
  String longitude;
  String cep;
  String rua;
  String numero;
  String complemento;
  String bairro;
  String cidade;
  String estado;
  AddressType tipoEnd;

  get latitudeValue => double.parse(latitude);

  get longitudeValue => double.parse(longitude);

  AddressModel(
      {@required this.id,
      @required this.latitude,
      @required this.longitude,
      @required this.cep,
      @required this.rua,
      @required this.numero,
      @required this.bairro,
      @required this.cidade,
      @required this.estado,
      @required this.complemento,
      this.tipoEnd});

  AddressModel.create({
    @required this.cep,
    @required this.rua,
    @required this.bairro,
    @required this.cidade,
    @required this.estado,
  });

  set setTipoEnd(int id) {
    tipoEnd = id == 1 ? AddressType.User : AddressType.Event;
  }

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
    return '${this.cep} ${this.rua} ${this.numero} ${this.complemento} ${this.bairro} ${this.cidade} - ${this.estado}';
  }
}
