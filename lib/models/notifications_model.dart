import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsModel {
  DateTime dataCriacao;
  String tipo;
  String texto;

  NotificationsModel({this.dataCriacao, this.texto, this.tipo});

  factory NotificationsModel.fromMap(Map<String, dynamic> map) => NotificationsModel(
      dataCriacao : map["dataCriacao"],
      texto: map["texto"],
      tipo : map["tipo"]
  );

  Map<String, dynamic> toMap() => {
    "dataCriacao" : this.dataCriacao,
    "texto" : this.texto,
    "tipo" : this.tipo
  };

  factory NotificationsModel.fromJson(String value) =>  NotificationsModel.fromMap(json.decode(value));

  String toJson() =>  json.encode(toMap());

  Icon getIconOfType(){
    switch (this.tipo) {
      case "evento" : return Icon(Icons.calendar_today);
      break;
      case "funcionario" : return Icon(Icons.assignment_ind);
      break;
      case "info" : return Icon(Icons.info_outline);
      break;
      case "dinheiro" : return Icon(Icons.monetization_on_sharp);
      break;
      default: return null;
    }
  }

}