import 'dart:convert';

import 'package:event_uau/models/funcionario_model.dart';

import 'evento_model.dart';

class ContratoModel{
  int idContrato;
  EventoModel evento;
  FuncionarioModel funcionario;
  int notaFuncionario;
  StatusFuncionario statusFuncionario;
  DateTime horaContratacao;
  DateTime horaChegadaFuncionario;
  DateTime horaSaidaFuncionario;
  double valorExcedente;
  bool eventoFoiCurtido;
  bool funcionarioFoiCurtido;

  ContratoModel({
    this.idContrato,
    this.evento,
    this.funcionario,
    this.notaFuncionario,
    this.statusFuncionario,
    this.horaContratacao,
    this.horaChegadaFuncionario,
    this.horaSaidaFuncionario,
    this.valorExcedente,
    this.eventoFoiCurtido,
    this.funcionarioFoiCurtido
  });

  factory ContratoModel.fromMap(Map<String, dynamic> json) => ContratoModel(
    idContrato: json["idContrato"],
    evento: json["evento"],
    funcionario: json["funcionario"],
    notaFuncionario: json["notaFuncionario"],
    statusFuncionario: json["statusFuncionario"],
    horaContratacao: json["horaMatch"],
    horaChegadaFuncionario: json["horaChegadaFuncionario"],
    horaSaidaFuncionario: json["horaSaidaEvento"],
    valorExcedente: json["valorExcedente"],
    eventoFoiCurtido: json["eventoFoiCurtido"],
    funcionarioFoiCurtido: json["funcionarioFoiCurtido"],
  );

  Map<String, dynamic> toMap() => {
    "idContrato": this.idContrato,
    "evento": this.evento,
    "funcionario": this.funcionario,
    "notaFuncionario": this.notaFuncionario,
    "statusFuncionario" : this.statusFuncionario,
    "horahoraContratacao": this.horaContratacao,
    "horaChegadaFuncionario" : this.horaChegadaFuncionario,
    "horaSaidaEvento": this.horaSaidaFuncionario,
    "valorExcedente": this.valorExcedente,
    "eventoFoiCurtido": this.eventoFoiCurtido,
    "funcionarioFoiCurtido": this.funcionarioFoiCurtido
  };

  factory ContratoModel.fromJson(String str) => ContratoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());


}

enum StatusFuncionario{
  EM_ESPERA,   //status que perdura até a data do evento
  PRESENTE,   //quando o funcionario chegou no local e esta trabalhando
  ATRASADO,   //quando o funcionario ainda nao chegou ao local mas contrato esta ativo
  AUSENTE,    //quando o funcionario nao comparece ao evento marcado
  DEMITIDO    //funcionario demitido 
}