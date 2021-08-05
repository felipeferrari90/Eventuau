import 'dart:convert';

import 'package:event_uau/models/funcionario_model.dart';
import 'package:flutter/cupertino.dart';

import 'evento_model.dart';

class ContratoModel{
  int idContrato;
  EventoModel evento;
  FuncionarioModel funcionario;
  int notaFuncionario;
  int notaEvento;
  StatusContrato statusContrato;
  StatusFuncionario statusFuncionario;
  DateTime horaMatch = DateTime.now();
  DateTime horaSaidaEvento;
  double valorExcedente = 0.00;
  bool eventoFoiCurtido;
  bool funcionarioFoiCurtido;

  ContratoModel({
    this.idContrato,
    this.evento,
    this.funcionario,
    this.notaFuncionario,
    this.notaEvento,
    this.statusContrato,
    this.statusFuncionario,
    this.horaMatch,
    this.horaSaidaEvento,
    this.valorExcedente,
    this.eventoFoiCurtido,
    this.funcionarioFoiCurtido
  });

  factory ContratoModel.fromMap(Map<String, dynamic> json) => ContratoModel(
    idContrato: json["idContrato"],
    evento: json["evento"],
    funcionario: json["funcionario"],
    notaFuncionario: json["notaFuncionario"],
    notaEvento: json["notaEvento"],
    statusContrato: json["statusContrato"],
    statusFuncionario: json["statusFuncionario"],
    horaMatch: json["horaMatch"],
    horaSaidaEvento: json["horaSaidaEvento"],
    valorExcedente: json["valorExcedente"],
    eventoFoiCurtido: json["eventoFoiCurtido"],
    funcionarioFoiCurtido: json["funcionarioFoiCurtido"],
  );

  Map<String, dynamic> toMap() => {
    "idContrato": this.idContrato,
    "evento": this.evento,
    "funcionario": this.funcionario,
    "notaFuncionario": this.notaFuncionario,
    "notaEvento": this.notaEvento,
    "statusContrato": this.statusContrato,
    "statusFuncionario" : this.statusFuncionario,
    "horaMatch": this.horaMatch,
    "horaSaidaEvento": this.horaSaidaEvento,
    "valorExcedente": this.valorExcedente,
    "eventoFoiCurtido": this.eventoFoiCurtido,
    "funcionarioFoiCurtido": this.funcionarioFoiCurtido
  };

  factory ContratoModel.fromJson(String str) => ContratoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());


}

enum StatusContrato {
  PARCIAL_MATCH, MATCH, FECHADO, TERMINADO, CANCELADO
}

enum StatusFuncionario{
  PRESENTE , ATRASADO, AUSENTE, DEMITIDO
}