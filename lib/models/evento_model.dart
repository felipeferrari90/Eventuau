import 'dart:convert';

import 'package:event_uau/models/contratante_model.dart';
import 'package:event_uau/models/contrato_model.dart';
import 'package:event_uau/models/funcionario_model.dart';
import 'package:enum_to_string/enum_to_string.dart';

class EventoModel {
  int id;
  int numeroEvento;
  String nome;
  String descricao;
  String endereco;
  StatusEvento statusEvento;
  ContratanteModel organizador;
  DateTime dataEHoraCriacaoEvento;
  DateTime dataEHorarioInicio;
  Duration tempoDuracaoMinimoPreDeterminado;
  Duration tempoDuracaoMaximoPreDeterminado;
  double valorEvento;
  String observacoes;
  StatusContratacaoEvento statusContratacaoEvento;
  bool estaVisivel;
  bool estaPago;
  int numeroMaximoDeGarcons = 0;
  int numeroMaximoDeAnimadores = 0;
  int numeroMaximoDeBuffets = 0;
  int numeroMaximoDeChurrasqueiros = 0;
  List<ContratoModel> funcionariosContratados = List.empty();
  List<FuncionarioModel> funcionariosEmListaDeEspera = List.empty();
 
  EventoModel({
    this.id,
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
    this.valorEvento,
    this.observacoes,
    this.statusContratacaoEvento,
    this.estaVisivel,
    this.estaPago,
    this.numeroMaximoDeGarcons,
    this.numeroMaximoDeAnimadores,
    this.numeroMaximoDeBuffets,
    this.numeroMaximoDeChurrasqueiros,
    funcionariosContratados, 
    funcionariosEmListaDeEspera,
  });

  factory EventoModel.fromMap(Map<String, dynamic> json) => EventoModel(
      id: json["id"],
      numeroEvento: json["numeroEvento"],
      nome: json["nome"],
      descricao: json["descricao"],
      endereco: json["endereco"],
      statusEvento:
          EnumToString.fromString(StatusEvento.values, json["statusEvento"]),
      organizador: json["organizador"],
      dataEHoraCriacaoEvento: json["dataCriacaoEvento"],
      dataEHorarioInicio: json["inicio"],
      valorEvento: json["valorTotal"],
      statusContratacaoEvento: EnumToString.fromString(
          StatusContratacaoEvento.values, json["statusContratacaoEvento"]),
      estaVisivel: json["estaVisivel"],
      estaPago: json["estaPago"],
      numeroMaximoDeGarcons: json["numeroMaximoDeGarcons"],
      numeroMaximoDeAnimadores: json["numeroMaximoDeAnimadores"],
      numeroMaximoDeBuffets: json["numeroMaximoDeBuffets"],
      numeroMaximoDeChurrasqueiros: json["numeroMaximoDeChurrasqueiros"],
      funcionariosContratados: json["funcionariosContratados"],
      funcionariosEmListaDeEspera: json["funcionariosEmListaDeEspera"],
   );

  Map<String, dynamic> toMap() => {
        "id": this.id,
        "numeroEvento": this.numeroEvento,
        "descricao": this.descricao,
        "nome": this.nome,
        "endereco": this.endereco,
        "statusEvento":
            EnumToString.convertToString(this.statusEvento, camelCase: false),
        "statusContratacaoEvento": EnumToString.convertToString(
            this.statusContratacaoEvento,
            camelCase: false),
        "organizador": this.organizador,
        "dataCriacaoEvento": this.dataEHoraCriacaoEvento,
        "inicio": this.dataEHorarioInicio,
        "tempoDuracaoMinimoPreDeterminado":
            this.tempoDuracaoMinimoPreDeterminado,
        "tempoDuracaoMaximoPreDeterminado":
            this.tempoDuracaoMaximoPreDeterminado,
        "valorTotal": this.valorEvento,
        "estaVisivel": this.estaVisivel,
        "observacoes": this.observacoes,
        "funcionariosContratados": this.funcionariosContratados,
        "funcionariosEmListaDeEspera": this.funcionariosEmListaDeEspera,
      };

  factory EventoModel.fromJson(String str) =>
      EventoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  double pegarValorTotalEvento(){
    double aux = 0;
    for (var contrato in this.funcionariosContratados) {
       aux += contrato.valorTotal;
    }
    return aux;
  }

}

enum StatusEvento {
  PENDENTE, //o evento é criado, da pra contratar funcionarios, porem eles sabem que o contratante nao tem o valor em conta no app suficiente, e isso fica visivel na tela de escolha,
  CRIADO, //evento é criado, da pra contratar, porem os funcionarios contratados ficam retidos aguardando a data ser definida, funcionarios podem sair a qualquer momento do evento sem punicoes, ja que nao tem data determinada
  AGENDADO, //evento é criado, agendado com data, se o funcionario for contratado e sair faltando pouco tempo do evento ou faltar, sofrera punicoes
  EM_ANDAMENTO, // evento em questão esta acontecendo no momento
  TERMINADO, // evento acabou, nao aparece mais visivel na tela de escolhas
  CANCELADO // evento cancelado, nao aparecera na lista de escolhas, sujeito a puniçoes
}

enum StatusContratacaoEvento {
  SEM_CONTRATAR, // significa que vc nao quer mais contratar funcionarios, ficara visivel para o funcionario, matchs percussores moverao o funcionario para lista de reserva
  CONTRATANDO_FUNCIONARIOS, // significa que o funcionario sabe que vc ainda esta contratando
  FUNCIONARIOS_CONTRATADOS, // significa que o numero de contratados chegou no limite estabelecido pelo contratante , quaisquer match depois disso movera o funcionario para uma lista de reserva
  FIM_DE_EVENTO // aqui todas as listas de matchs e funcionarios sao excluidas, nem aparece na lista de matches, e sim do historico
}
