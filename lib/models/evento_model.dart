import 'dart:convert';

import 'package:event_uau/models/contratante_model.dart';
import 'package:event_uau/models/contrato_model.dart';
import 'package:event_uau/models/funcionario_model.dart';
import 'package:enum_to_string/enum_to_string.dart';

class EventoModel {
  int id;
  int numeroDeEvento;
  String nome;
  String descricao;
  String endereco;
  StatusEvento status;
  ContratanteModel organizador;
  DateTime dataEHoraCriacaoEvento;
  DateTime dataEHorarioInicio;
  Duration duracaoMinima;
  Duration duracaoMaxima;
  double valorEvento;
  String observacoes;
  bool estaPago;
  int numeroMaximoDeGarcons = 0;
  int numeroMaximoDeAnimadores = 0;
  int numeroMaximoDeBuffets = 0;
  int numeroMaximoDeChurrasqueiros = 0;
  
 
  EventoModel({
    this.id,
    this.numeroDeEvento,
    this.nome,
    this.descricao,
    this.endereco,
    this.status,
    this.organizador,
    this.dataEHoraCriacaoEvento,
    this.dataEHorarioInicio,
    this.duracaoMinima,
    this.duracaoMaxima,
    this.valorEvento,
    this.observacoes,
    this.estaPago,
    this.numeroMaximoDeGarcons,
    this.numeroMaximoDeAnimadores,
    this.numeroMaximoDeBuffets,
    this.numeroMaximoDeChurrasqueiros,
  });

  factory EventoModel.fromMap(Map<String, dynamic> json) => EventoModel(
      id: json["id"],
      numeroDeEvento: json["numeroDeEvento"],
      nome: json["nome"],
      descricao: json["descricao"],
      endereco: json["endereco"],
      status:
          EnumToString.fromString(StatusEvento.values, json["statusEvento"]),
      organizador: json["organizador"],
      dataEHoraCriacaoEvento: json["dataCriacaoEvento"],
      dataEHorarioInicio: json["inicio"],
      duracaoMinima: json["duracao minima"],
      duracaoMaxima: json["duracao maxima"],
      valorEvento: json["valorTotal"],
      estaPago: json["estaPago"],
      numeroMaximoDeGarcons: json["numeroMaximoDeGarcons"],
      numeroMaximoDeAnimadores: json["numeroMaximoDeAnimadores"],
      numeroMaximoDeBuffets: json["numeroMaximoDeBuffets"],
      numeroMaximoDeChurrasqueiros: json["numeroMaximoDeChurrasqueiros"],
   );

  Map<String, dynamic> toMap() => {
        "id": this.id,
        "numeroEvento": this.numeroDeEvento,
        "descricao": this.descricao,
        "nome": this.nome,
        "endereco": this.endereco,
        "statusEvento":
            EnumToString.convertToString(this.status , camelCase: false),
        "organizador": this.organizador,
        "dataCriacaoEvento": this.dataEHoraCriacaoEvento,
        "inicio": this.dataEHorarioInicio,
        "duracaoMinima":
            this.duracaoMinima,
        "duracaoMaxima":
            this.duracaoMaxima,
        "valorTotal": this.valorEvento,
        "observacoes": this.observacoes,
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
  CRIADO, // evento apenas foi pago e criado, mas nenhuma proposta foi enviada
  CONTRATANDO, // quando propostas ja são enviadas a funcionarios
  FECHADO, //todas as vagas ja foram ocupadas porem funcionarios que aceitaram a proposta podem aparecer na lista de espera
  PENDENTE, // quando esta faltando dinheiro em caixa para pagar funcionarios  
  ACONTECENDO, // evento em questão esta acontecendo no momento
  TERMINADO, // evento acabou, nao aparece mais na tela principal de eventos
  CANCELADO // evento cancelado antes do termino estipulado,
}


