import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:event_uau/models/funcionario_model.dart';
import 'evento_model.dart';

class ContratoModel{
  int id;
  EventoModel evento;
  FuncionarioModel funcionario;
  int notaFuncionario;
  StatusFuncionario statusFuncionario;
  DateTime horaContratacao;
  DateTime horaChegadaFuncionario;
  DateTime horaSaidaFuncionario;
  Duration horaExtra;
  double precoAhoraCombinado;
  double valorTotal;

  ContratoModel({
    this.id,
    this.evento,
    this.funcionario,
    this.notaFuncionario,
    this.statusFuncionario,
    this.horaContratacao,
    this.horaChegadaFuncionario,
    this.horaSaidaFuncionario,
    this.horaExtra,
    this.precoAhoraCombinado,
    this.valorTotal,
  });

  factory ContratoModel.fromMap(Map<String, dynamic> json) => ContratoModel(
    id: json["idContrato"],
    evento: json["evento"],
    funcionario: json["funcionario"],
    notaFuncionario: json["notaFuncionario"],
    statusFuncionario: EnumToString.fromString(StatusFuncionario.values, json["statusFuncionario"]),
    horaContratacao: DateTime.fromMillisecondsSinceEpoch(json["horaContratacao"]),
    horaChegadaFuncionario: DateTime.fromMillisecondsSinceEpoch(json["horaChegadaFuncionario"]),
    horaSaidaFuncionario: DateTime.fromMillisecondsSinceEpoch(json["horaSaidaFuncionario"]),
    horaExtra: json["valorExcedente"],
    valorTotal: json["valorTotal"],
  );

  Map<String, dynamic> toMap() => {
    "idContrato": this.id,
    "evento": this.evento,
    "funcionario": this.funcionario,
    "notaFuncionario": this.notaFuncionario,
    "statusFuncionario" : EnumToString.convertToString(this.statusFuncionario),
    "horahoraContratacao": this.horaContratacao.millisecondsSinceEpoch,
    "horaChegadaFuncionario" : this.horaChegadaFuncionario.millisecondsSinceEpoch,
    "horaSaidaEvento": this.horaSaidaFuncionario.millisecondsSinceEpoch,
    "horaExtra": this.horaExtra,
    "valorTotal": this.valorTotal,
  };

  factory ContratoModel.fromJson(String str) => ContratoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());
 
  double pegarValorTotalContrato(){
    return (((this.horaSaidaFuncionario.millisecondsSinceEpoch.toDouble() - 
            this.horaChegadaFuncionario.millisecondsSinceEpoch.toDouble()) + 
            this.horaExtra.inMilliseconds) / 3600000 ) * this.precoAhoraCombinado.toDouble();       
  }

  double _getHoraCombinada() {
    return this.funcionario.precoDoServicoAHora;
  }
}

enum StatusFuncionario{
  PROPOSTA_ENVIADA,   //funcionario recebeu a proposta e ainda nao deu feedback
  RECUSADO,    //proposta que o funcionario recusou
  ACEITADO,   //status que perdura até a data do evento
  PRESENTE,   //quando o funcionario chegou no local e esta trabalhando
  ATRASADO,   //quando o funcionario ainda nao chegou ao local mas contrato esta ativo
  AUSENTE,    //quando o funcionario nao comparece ao evento marcado
  DEMITIDO    //contrato encerrado
}