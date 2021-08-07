
import 'dart:convert';
import 'package:flutter/material.dart';

import 'evento_model.dart';

class ContratanteModel{

   int id;
   String nome;
   String cpf;
   String senha;
   String telefone;
   String endereco;
   DateTime dataNascimento;
   double valorEmCaixa;
   List<EventoModel> eventos;
   // fotos.

   ContratanteModel({
        this.id ,
        this.nome, 
        this.cpf, 
        this.senha, 
        this.telefone ,
        this.endereco, 
        this.dataNascimento, 
        this.valorEmCaixa,
        this.eventos,
        //this.fotos
   });

   factory ContratanteModel.fromMap(Map<String, dynamic> json) => ContratanteModel(
       id: json["id"], 
       nome: json["nome"], 
       cpf: json["cpf"], 
       senha: json["senha"], 
       telefone: json["telefone"], 
       endereco: json["endereco"],
       dataNascimento: json["dataNascimento"] , 
       valorEmCaixa: json["valorEmCaixa"],
       eventos: json["eventos"]
   );

   Map<String, dynamic> toMap() => {
     "id" : this.id,
     "nome" : this.nome,
     "senha" : this.senha,
     "cpf" : this.cpf,
     "telefone" : this.telefone,
     "dataNascimento" : this.dataNascimento,
     "eventos": this.eventos,
   };

   factory ContratanteModel.fromJson(String str) => ContratanteModel.fromMap(json.decode(str));

   String toJson() => json.encode(toMap());



}