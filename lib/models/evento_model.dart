import 'dart:convert';

import 'package:event_uau/models/contratante_model.dart';
import 'package:event_uau/models/funcionario_model.dart';

class EventoModel{

  int id;
  int numeroEvento;
  String nome;
  String endereco;
  StatusEvento statusEvento;
  ContratanteModel organizador;
  DateTime inicio;
  DateTime fimPrevisto;
  DateTime fimReal;
  double tempoDuracaoPrevisto;
  double tempoDuracaoReal;
  int numeroCurtidas;
  int numeroFuncionarios;
  double valorEvento;
  double valorReservaEmergencia;
  StatusContratacaoEvento statusContratacaoEvento;
  List<FuncionarioModel> funcionarios = List();
  //this.fotos

  EventoModel({this.id,
               this.numeroEvento,
               this.nome,
               this.endereco,
               this.statusEvento,
               this.organizador,
               this.inicio,
               this.fimPrevisto,
               this.numeroCurtidas,
               this.numeroFuncionarios,
               this.valorEvento,
               this.valorReservaEmergencia,
               this.statusContratacaoEvento,
               this.funcionarios
  });

  factory EventoModel.fromMap(Map<String, dynamic> json) => EventoModel(
     id: json["id"], 
     numeroEvento: json["numeroEvento"] , 
     nome: json["nome"],
     endereco: json["endereco"],
     statusEvento: json["statusEvento"],
     organizador:  json["organizador"],
     inicio: json["inicio"],
     fimPrevisto: json["fimPrevisto"],
     numeroCurtidas: json["numeroCurtidas"],
     numeroFuncionarios: json["numeroFuncionarios"],
     valorEvento: json["valorTotal"],
     valorReservaEmergencia: json["valorReservaEmergencia"],
     statusContratacaoEvento: json["statusContratacaoEvento"] 
  );

  Map<String, dynamic> toMap() => {
      "id" :  this.id,
      "numeroEvento" : this.numeroEvento,
      "nome" : this.nome,
      "endereco": this.endereco,
      "statusEvento" : this.statusEvento,
      "organizador" : this.organizador,
      "inicio" : this.inicio,
      "fimPrevisto" : this.fimPrevisto,
      "fimReal" : this.fimReal,
      "tempoDuracaoPrevisto;" : this.tempoDuracaoPrevisto,
      "tempoDuracaoReal": this.tempoDuracaoReal,
      "valorTotal": this.valorEvento,
      "valorReservaEmergencia": this.valorReservaEmergencia
  };
     
  factory EventoModel.fromJson(String str) => EventoModel.fromMap(json.decode(str));

  String toJson(Map<String, dynamic> map) => json.encode(toMap()); 

}

enum StatusEvento{
   PENDENTE, CRIADO, AGENDADO , ANDAMENTO ,  TERMINADO , CANCELADO, 
}

enum StatusContratacaoEvento{
   SEM_CONTRATAR,
   CONTRATANDO_FUNCIONARIOS, 
   FUNCIONARIOS_CONTRATADOS,
   EMERGENCIA_PARA_CONTRATACAO
}