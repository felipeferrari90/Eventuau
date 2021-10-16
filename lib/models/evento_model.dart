import 'dart:convert';

import 'package:event_uau/models/contratante_model.dart';
import 'package:event_uau/models/contrato_model.dart';
import 'package:event_uau/models/funcionario_model.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';

class EventoModel with ChangeNotifier {
  int id;
  int numeroDeEvento;
  String nome;
  String descricao;
  String endereco;
  StatusEvento status;
  ContratanteModel organizador;
  DateTime dataEHoraCriacaoEvento = DateTime.now();
  DateTime dataEHorarioInicio;
  DateTime dataEHorarioTermino;
  int duracaoMinima;
  int duracaoMaxima;
  double valorEvento = 0.0;
  String observacoes;
  bool estaPago;
  List<FuncionarioModel> funcionarios = List.empty();

  EventoModel(
      {this.id,
      this.numeroDeEvento,
      this.nome,
      this.descricao,
      this.endereco,
      this.status,
      this.organizador,
      this.dataEHoraCriacaoEvento,
      this.dataEHorarioInicio,
      this.dataEHorarioTermino,
      this.duracaoMinima,
      this.duracaoMaxima,
      this.valorEvento,
      this.observacoes,
      this.estaPago,
      this.funcionarios});

  factory EventoModel.fromMap(Map<String, dynamic> json) => EventoModel(
      id: json["id"],
      numeroDeEvento: json["numeroDeEvento"],
      nome: json["nome"],
      descricao: json["descricao"],
      endereco: json["endereco"],
      status:
          EnumToString.fromString(StatusEvento.values, json["statusEvento"]),
      organizador: json["organizador"],
      dataEHoraCriacaoEvento: DateTime(json["dataCriacaoEvento"]),
      dataEHorarioInicio: DateTime(json["dataEHorarioInicio"]),
      dataEHorarioTermino: DateTime(json["dataEHorarioTermino"]),
      duracaoMinima: json["duracao minima"],
      duracaoMaxima: json["duracao maxima"],
      valorEvento: json["valorTotal"],
      estaPago: json["estaPago"],
      funcionarios: json["funcionarios"]);

  Map<String, dynamic> toMap() => {
        "id": this.id,
        "numeroEvento": this.numeroDeEvento,
        "descricao": this.descricao,
        "nome": this.nome,
        "endereco": this.endereco,
        "status": EnumToString.convertToString(
            this.status ?? StatusEvento.PENDENTE,
            camelCase: false),
        "dataCriacao":
            (this.dataEHoraCriacaoEvento ?? DateTime.now()).toIso8601String(),
        "dataInicio":
            (this.dataEHorarioInicio ?? DateTime.now()).toIso8601String(),
        "dataTermino":
            (this.dataEHorarioTermino ?? DateTime.now()).toIso8601String(),
        "duracaoMinima": this.duracaoMinima,
        "valorTotal": this.valorEvento,
        "observacao": this.observacoes,
        "funcionariosContratados": this.funcionarios,
      };

  factory EventoModel.fromJson(String str) =>
      EventoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  /*
  double pegarValorTotalEvento(){
    double aux = 0;
    for (var contrato in this.funcionariosContratados) {
       aux += contrato.valorTotal;
    }
    return aux;
  }*/

}

enum StatusEvento {
  PENDENTE, // evento foi criado apenas, sem funcionarios contratados
  CONTRATANDO,
  FECHADO, //todas as vagas ja foram ocupadas porem funcionarios que aceitaram a proposta podem aparecer na lista de espera
  ACONTECENDO, // evento em questão esta acontecendo no momento
  TERMINADO, // evento acabou, nao aparece mais na tela principal de eventos
  CANCELADO // evento cancelado antes do termino estipulado,
}
