import 'dart:convert';
import 'package:flutter/material.dart';

import 'evento_model.dart';
import 'notifications_model.dart';

class ContratanteModel {
  int id;
  String nome;
  String cpf;
  String senha;
  String email;
  String telefone;
  DateTime dataNascimento;
  DateTime dataCriacaoConta = DateTime.now();
  double valorEmCaixaDisponivel;
  double valorBloqueado;
  List<NotificationsModel> notificacoes;

  // fotos

  ContratanteModel({
    this.id,
    this.nome,
    this.cpf,
    this.senha,
    this.email,
    this.telefone,
    this.dataNascimento,
    this.dataCriacaoConta,
    this.valorEmCaixaDisponivel,
    this.valorBloqueado,
    //this.fotos
  });

  factory ContratanteModel.fromMap(Map<String, dynamic> json) =>
      ContratanteModel(
        id: json["id"],
        nome: json["nome"],
        cpf: json["cpf"],
        senha: json["senha"],
        email: json["email"],
        telefone: json["telefone"],
        dataNascimento:
            DateTime.fromMillisecondsSinceEpoch(json["dataNascimento"]),
        dataCriacaoConta:
            DateTime.fromMillisecondsSinceEpoch(json["dataCriacaoConta"]),
        valorEmCaixaDisponivel: json["valorEmCaixa"],
        valorBloqueado: json["valorBloqueado"],
      );

  Map<String, dynamic> toMap() => {
        "id": this.id,
        "nome": this.nome,
        "senha": this.senha,
        "cpf": this.cpf,
        "email": this.email,
        "telefone": this.telefone,
        "dataNascimento": this.dataNascimento.millisecondsSinceEpoch,
        "dataCriacaoConta": this.dataCriacaoConta.millisecondsSinceEpoch,
        "valorEmCaixaDisponivel": this.valorEmCaixaDisponivel,
        "valorBloqueado": this.valorBloqueado,
      };

  factory ContratanteModel.fromJson(String str) =>
      ContratanteModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());
}
