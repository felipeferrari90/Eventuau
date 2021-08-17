import 'dart:convert';

import 'package:event_uau/models/contratante_model.dart';
import 'package:event_uau/models/funcionario_model.dart';

class EventoModel{

  int id;
  int numeroEvento;
  String nome;
  String descricao;
  String endereco;
  StatusEvento statusEvento;
  ContratanteModel organizador;
  DateTime dataEHoraCriacaoEvento;
  DateTime dataEHorarioInicio;
  double tempoDuracaoMinimoPreDeterminado;
  double tempoDuracaoMaximoPreDeterminado;
  int numeroCurtidas;
  int numeroFuncionariosContratados;
  int numeroFuncionariosMatches;
  double valorEvento;
  double valorEventoComHoraExcedente;
  String observacoes;
  StatusContratacaoEvento statusContratacaoEvento;
  bool estaVisivel;
  List<FuncionarioModel> funcionariosContratados = List<FuncionarioModel>();
  List<FuncionarioModel> funcionariosMatch = List<FuncionarioModel>();
  //this.fotos

  EventoModel({this.id,
               this.numeroEvento,
               this.nome,
               this.descricao,
               this.endereco,
               this.statusEvento,
               this.organizador,
               this.dataEHoraCriacaoEvento,
               this.dataEHorarioInicio,
               this.tempoDuracaoMinimoPreDeterminado,
               this.tempoDuracaoMaximoPreDeterminado,
               this.numeroCurtidas,
               this.numeroFuncionariosContratados,
               this.numeroFuncionariosMatches,
               this.valorEvento,
               this.valorEventoComHoraExcedente,
               this.observacoes,
               this.statusContratacaoEvento,
               this.estaVisivel,
               this.funcionariosContratados,
               this.funcionariosMatch
  });

  factory EventoModel.fromMap(Map<String, dynamic> json) => EventoModel(
     id: json["id"], 
     numeroEvento: json["numeroEvento"] , 
     nome: json["nome"],
     descricao: json["descricao"],
     endereco: json["endereco"],
     statusEvento: json["statusEvento"],
     organizador:  json["organizador"],
     dataEHoraCriacaoEvento: json["dataCriacaoEvento"],
     dataEHorarioInicio: json["inicio"],
     numeroCurtidas: json["numeroCurtidas"],
     numeroFuncionariosContratados: json["numeroFuncionariosContratados"],
     numeroFuncionariosMatches: json["numeroFuncionariosMatches"],
     valorEvento: json["valorTotal"],
     valorEventoComHoraExcedente: json["valorEventoComHoraExcedente"],
     statusContratacaoEvento: json["statusContratacaoEvento"],
     estaVisivel: json["estaVisivel"],
     funcionariosContratados: json["funcionariosContratados"],
     funcionariosMatch: json["funcionariosMatch"] 
  );

  Map<String, dynamic> toMap() => {
      "id" :  this.id,
      "numeroEvento" : this.numeroEvento,
      "descricao" : this.descricao,
      "nome" : this.nome,
      "endereco": this.endereco,
      "statusEvento" : this.statusEvento,
      "organizador" : this.organizador,
      "dataCriacaoEvento" : this.dataEHoraCriacaoEvento,
      "inicio" : this.dataEHorarioInicio,
      "tempoDuracaoMinimoPreDeterminado" : this.tempoDuracaoMinimoPreDeterminado,
      "tempoDuracaoMaximoPreDeterminado" : this.tempoDuracaoMaximoPreDeterminado,
      "valorTotal": this.valorEvento,
      "estaVisivel" : this.estaVisivel,
      "valorEventoComHoraExcedente": this.valorEventoComHoraExcedente,
      "observacoes": this.observacoes,
      "funcionariosContratados": this.funcionariosContratados,
      "funcionariosMatch": this.funcionariosMatch,   //equivalente a uma lista de reserva de funcionarios (que nao foram contratados)
  };
     
  factory EventoModel.fromJson(String str) => EventoModel.fromMap(json.decode(str));

  String toJson(Map<String, dynamic> map) => json.encode(toMap()); 

}

enum StatusEvento{
   PENDENTE,    //o evento é criado, da pra contratar funcionarios, porem eles sabem que o contratante nao tem o valor em conta no app suficiente, e isso fica visivel na tela de escolha,  
   CRIADO,      //evento é criado, da pra contratar, porem os funcionarios contratados ficam retidos aguardando a data ser definida, funcionarios podem sair a qualquer momento do evento sem punicoes, ja que nao tem data determinada
   AGENDADO,    //evento é criado, agendado com data, se o funcionario for contratado e sair faltando pouco tempo do evento ou faltar, sofrera punicoes
   ANDAMENTO,   // evento em questão esta acontecendo no momento
   TERMINADO,   // evento acabou, nao aparece mais visivel na tela de escolhas
   CANCELADO    // evento cancelado, nao aparecera na lista de escolhas, sujeito a puniçoes
}

enum StatusContratacaoEvento{
   SEM_CONTRATAR,               // significa que vc nao quer mais contratar funcionarios, ficara visivel para o funcionario, matchs percussores moverao o funcionario para lista de reserva
   CONTRATANDO_FUNCIONARIOS,    // significa que o funcionario sabe que vc ainda esta contratando
   FUNCIONARIOS_CONTRATADOS,    // significa que o numero de contratados chegou no limite estabelecido pelo contratante , quaisquer match depois disso movera o funcionario para uma lista de reserva
   EMERGENCIA_PARA_CONTRATACAO, // quer um funcionario o mais rapido possivel, em menos de 10 minutos a chegar no local, 
   FIM_DE_EVENTO                // aqui todas as listas de matchs e funcionarios sao excluidas, nem aparece na lista de matches, e sim do historico 
}