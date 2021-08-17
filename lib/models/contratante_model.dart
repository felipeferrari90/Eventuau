
import 'dart:convert';
import 'package:flutter/material.dart';

import 'evento_model.dart';
import 'notifications_model.dart';

class ContratanteModel{

   int id;
   String nome;
   String cpf;
   String senha;
   String telefone;
   DateTime dataNascimento;
   DateTime dataCriacaoConta;
   double valorEmCaixaDisponivel;
   double valorBloqueado;
   List<EventoModel> eventosCriados;
   List<EventoModel> historicoEventos;
   List<NotificationsModel> notificacoes;
   // fotos

   ContratanteModel({
        this.id ,
        this.nome, 
        this.cpf, 
        this.senha, 
        this.telefone , 
        this.dataNascimento, 
        this.dataCriacaoConta,
        this.valorEmCaixaDisponivel,
        this.valorBloqueado,
        this.eventosCriados,
        this.historicoEventos,
        this.notificacoes
        //this.fotos
   });

   factory ContratanteModel.fromMap(Map<String, dynamic> json) => ContratanteModel(
       id: json["id"], 
       nome: json["nome"], 
       cpf: json["cpf"], 
       senha: json["senha"], 
       telefone: json["telefone"], 
       dataNascimento: json["dataNascimento"] , 
       dataCriacaoConta : json["dataCriacaoConta"],
       valorEmCaixaDisponivel: json["valorEmCaixa"],
       valorBloqueado: json["valorBloqueado"],
       eventosCriados: json["eventosCriados"],
       historicoEventos: json["historicoEventos"],
       notificacoes: json["notificacoes"]
   );

   Map<String, dynamic> toMap() => {
     "id" : this.id,
     "nome" : this.nome,
     "senha" : this.senha,
     "cpf" : this.cpf,
     "telefone" : this.telefone,
     "dataNascimento" : this.dataNascimento,
     "dataCriacaoConta" : this.dataCriacaoConta,
     "valorEmCaixaDisponivel": this.valorEmCaixaDisponivel,
     "valorBloqueado" : this.valorBloqueado,
     "eventosCriados": this.eventosCriados,
     "historicoEventos" : this.historicoEventos,
     "notificacoes" : this.notificacoes
   };

   factory ContratanteModel.fromJson(String str) => ContratanteModel.fromMap(json.decode(str));

   String toJson() => json.encode(toMap());

}