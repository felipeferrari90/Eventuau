import 'dart:convert';


import 'evento_model.dart';
import 'notifications_model.dart';

class FuncionarioModel{
   int id;
   String nome;
   String cpf;
   String rg;
   String senha;
   String endereco;
   String telefone;
   String sobreMim; 
   DateTime dataNascimento;
   DateTime ultimoLogin;
   Status status;
   TipoProfissao tipoProfissao;
   double valorASerSacado;
   double valorEmCaixa;
   double valorBloqueado;
   double horasTrabalhadas;
   double mediaDeAvaliacao;
   double precoDoServicoAHora;
   List<EventoModel> eventosParaEscolher;
   List<EventoModel> eventosEmEspera;
   List<EventoModel> eventosEmAndamento;
   List<EventoModel> historicoEventos;
   List<NotificationsModel> notificacoes;
   //fotos de funcionario
   

   FuncionarioModel({
        this.id ,
        this.nome, 
        this.rg,
        this.cpf, 
        this.senha, 
        this.endereco, 
        this.telefone,
        this.sobreMim, 
        this.dataNascimento,
        this.ultimoLogin,
        this.status,
        this.tipoProfissao,
        this.valorASerSacado,
        this.valorEmCaixa,
        this.valorBloqueado,
        this.horasTrabalhadas,
        this.mediaDeAvaliacao,
        this.precoDoServicoAHora,
        this.eventosParaEscolher,
        this.eventosEmEspera,
        this.eventosEmAndamento,
        this.historicoEventos,
        this.notificacoes
        //fotos de funcionario
   });

   factory FuncionarioModel.fromMap(Map<String, dynamic> json) => FuncionarioModel(
       id: json["id"], 
       nome: json["nome"], 
       rg: json["rg"],
       cpf: json["cpf"], 
       senha: json["senha"], 
       endereco: json["endereco"], 
       telefone: json["endereco"], 
       sobreMim: json["sobreMim"],
       dataNascimento: json["dataNascimento"] ,
       ultimoLogin: json["ultimoLogin"] ,
       status: json["status"],
       tipoProfissao: json["tipoProfissao"],
       valorASerSacado: json["telefone"],
       valorEmCaixa: json["valorEmCaixa"], 
       valorBloqueado: json["valorBloqueado"] , 
       horasTrabalhadas: json["horasTrabalhadas"] , 
       mediaDeAvaliacao: json["mediaDeAvaliacao"] , 
       precoDoServicoAHora: json["precoDoServicoAHora"] , 
       eventosParaEscolher: json["eventosParaEscolher"],
       eventosEmEspera: json["eventosEmEspera"] , 
       eventosEmAndamento: json["eventosEmAndamento"],
       historicoEventos: json["historicoEventos"],
       notificacoes: json["Notificacoes"]
   );

   Map<String, dynamic> toMap() => {
     "id" : this.id,
     "nome" : this.nome,
     "cpf" : this.senha,
     "rg" : this.rg,
     "senha" : this.cpf,
     "telefone" : this.telefone,
     "sobreMim" : this.dataNascimento,
     "dataNascimento": this.dataNascimento,
     "ultimoLogin" : this.ultimoLogin,
     "status": this.status,
     "tipoProfissao": this.tipoProfissao,
     "valorEmCaixa": this.valorEmCaixa,
     "valorBloqueado": this.valorBloqueado,
     "horasTrabalhadas": this.horasTrabalhadas,
     "mediaDeAvaliacao": this.mediaDeAvaliacao,
     "precoDoServicoAHora": this.precoDoServicoAHora,
     "eventosEmEspera": this.eventosEmEspera,
     "eventosEmAndamento": this.historicoEventos,
     "historicoEventos": this.historicoEventos,
     "notificacoes" : this.notificacoes
   };

   factory FuncionarioModel.fromJson(String str) => FuncionarioModel.fromMap(json.decode(str));

   String toJson() => json.encode(toMap());
}

enum TipoProfissao {
    GARCOM, ANIMADOR, BUFFET, CHURRASCO
}

enum Status {
   DISPONIVEL , //ONLINE NO APP
   EM_EVENTO,   
   AUSENTE ,    //desinstalou o app mas nao excluiu a conta
   INVISIVEL, 
   DELETADO      
}