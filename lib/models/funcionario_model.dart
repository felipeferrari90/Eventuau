import 'dart:convert';
import 'dart:ffi';

import 'evento_model.dart';

class FuncionarioModel{
  
   int id;
   String nome;
   String cpf;
   String senha;
   String endereco;
   String telefone;
   String sobreMim; 
   DateTime dataNascimento;
   Status status;
   TipoProfissao tipoProfissao;
   double valorASerSacado;
   double valorEmCaixa;
   double valorBloqueado;
   double horasTrabalhadas;
   double mediaDeAvaliacao;
   double valorCobradoAHora;
   List<EventoModel> eventosEmEspera;
   List<EventoModel> eventosEmAndamento;
   List<EventoModel> historicoEventos;
   //campo para fotos 
   

   FuncionarioModel({
        this.id ,
        this.nome, 
        this.cpf, 
        this.senha, 
        this.endereco, 
        this.telefone,
        this.sobreMim, 
        this.dataNascimento,
        this.status,
        this.tipoProfissao,
        this.valorASerSacado,
        this.valorEmCaixa,
        this.valorBloqueado,
        this.horasTrabalhadas,
        this.mediaDeAvaliacao,
        this.valorCobradoAHora,
        this.eventosEmEspera,
        this.eventosEmAndamento,
        this.historicoEventos
        //this.fotos
   });

   factory FuncionarioModel.fromMap(Map<String, dynamic> json) => FuncionarioModel(
       id: json["id"], 
       nome: json["nome"], 
       cpf: json["cpf"], 
       senha: json["senha"], 
       endereco: json["endereco"], 
       telefone: json["endereco"], 
       sobreMim: json["sobreMim"],
       dataNascimento: json["dataNascimento"] ,
       status: json["status"],
       tipoProfissao: json["tipoProfissao"],
       valorASerSacado: json["telefone"],
       valorEmCaixa: json["valorEmCaixa"], 
       valorBloqueado: json["valorBloqueado"] , 
       horasTrabalhadas: json["horasTrabalhadas"] , 
       mediaDeAvaliacao: json["mediaDeAvaliacao"] , 
       valorCobradoAHora: json["valorCobradoAHora"] , 
       eventosEmEspera: json["eventosEmEspera"] , 
       eventosEmAndamento: json["eventosEmAndamento"],
       historicoEventos: json["historicoEventos"],
   );

   Map<String, dynamic> toMap() => {
     "id" : this.id,
     "nome" : this.nome,
     "cpf" : this.senha,
     "senha" : this.cpf,
     "telefone" : this.telefone,
     "sobreMim" : this.dataNascimento,
     "dataNascimento": this.dataNascimento,
     "status": this.status,
     "tipoProfissao": status,
     "valorEmCaixa": this.valorEmCaixa,
     "valorBloqueado": this.valorBloqueado,
     "horasTrabalhadas": this.horasTrabalhadas,
     "mediaDeAvaliacao": this.mediaDeAvaliacao,
     "valorCobradoAHora": this.valorCobradoAHora,
     "eventosEmEspera": this.eventosEmEspera,
     "eventosEmAndamento": this.historicoEventos,
     "historicoEventos": this.historicoEventos
   };

   factory FuncionarioModel.fromJson(String str) => FuncionarioModel.fromMap(json.decode(str));

   String toJson() => json.encode(toMap());
}

enum TipoProfissao {
    GARCOM, ANIMADOR, BUFFET, CHURRASCO
}

enum Status {
   ATIVO, EM_EVENTO, INATIVO
}