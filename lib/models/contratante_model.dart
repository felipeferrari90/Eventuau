
import 'dart:convert';
import 'package:flutter/material.dart';

class ContratanteModel{

   @required String nome;
   @required String cpf;
   String senha;
   String telefone;
   String dataNascimento;

   ContratanteModel({
        this.nome, this.cpf, this.senha, this.telefone , this.dataNascimento
   });

   factory ContratanteModel.fromMap(Map<String, dynamic> json) => ContratanteModel(
       nome: json["nome"], cpf: json["cpf"], senha: json["senha"], 
       telefone: json["telefone"], dataNascimento: json["dataNascimento"] 
   );

   Map<String, dynamic> toMap() => {
     "nome" : this.nome,
     "senha" : this.senha,
     "cpf" : this.cpf,
     "telefone" : this.telefone,
     "dataNascimento" : dataNascimento
   };

   factory ContratanteModel.fromJson(String str) => ContratanteModel.fromMap(json.decode(str));

   String toJson() => json.encode(toMap());

}