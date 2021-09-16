import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

   // Instancia do SQFLite Database
  static Database _database;

  // Instancia da classe Helper
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  // Fábrica de construtor
  factory DatabaseHelper() {
    return _instance;
  }

  // Construtor nomeado 
  DatabaseHelper._internal();
  
  // Abre conexão com o banco
  Future<Database> get connection async {
    if (_database == null) {
      _database = await _createDatabase();
    }
    return _database;
  }
  

  
  //cria banco de dados
  Future<Database> _createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'eventuau.db');

    var database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: _createTables,
      onOpen: _selectTables,
    );

    
    return database;
  }

  void _createTables(Database database, int version) async {
  
    await database.execute(
      '''CREATE TABLE eventoModel (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        numeroDeEvento INTEGER,
        nome TEXT,
        descricao TEXT,
        endereco TEXT,
        conteudo TEXT,
        statusEvento TEXT,
        idOrganizador INTEGER,
        dataEHoraCriacaoEvento INTEGER,
        dataEHorarioInicio INTEGER,
        tempoDuracaoMinimoPreDeterminado REAL,
        tempoDuracaoMaximoPreDeterminado REAL,
        valorEvento REAL,
        observacoes TEXT,
        statusContratacaoEvento TEXT,
        estaVisivel INTEGER,
        estaPago INTEGER,
        numeroMaximoDeGarcons INTEGER,
        numeroMaximoDeAnimadores INTEGER,
        numeroMaximoDeBuffets INTEGER,
        numeroMaximoDeChurrasqueiros INTEGER
        )
      '''
    
    );
    await database.execute(
      '''
      CREATE TABLE contratoModel (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        idEvento INTEGER,
        notaFuncionario INTEGER,
        statusFuncionario TEXT,
        horaContratacao INTEGER,
        horaChegadaFuncionario INTEGER,
        horaSaidaFuncionario INTEGER,
        horaExtra INTEGER,
        precoAhoraCombinado INTEGER,
        valorTotal REAL
      )
      '''
    );

    await database.execute(
      '''
      CREATE TABLE contratanteModel (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nome TEXT,
        senha TEXT,
        cpf TEXT,
        email TEXT,
        telefone TEXT,
        dataNascimento INTEGER,
        dataCriacaoConta INTEGER,
        valorEmCaixaDisponivel REAL,
        valorBloqueado REAL
      )
      '''
    );

    debugPrint("banco criado poha");

    
  }
  
  FutureOr<void> _selectTables(Database database) async {

      debugPrint("funcao onopene chamada");
      await database.execute(
        "DROP TABLE eventoModel"
      );
      await database.execute(
      '''CREATE TABLE eventoModel (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        numeroDeEvento INTEGER,
        nome TEXT,
        descricao TEXT,
        endereco TEXT,
        conteudo TEXT,
        statusEvento TEXT,
        idOrganizador INTEGER,
        dataEHoraCriacaoEvento INTEGER,
        dataEHorarioInicio INTEGER,
        tempoDuracaoMinimoPreDeterminado REAL,
        tempoDuracaoMaximoPreDeterminado REAL,
        valorEvento REAL,
        observacoes TEXT,
        statusContratacaoEvento TEXT,
        estaVisivel INTEGER,
        estaPago INTEGER,
        numeroMaximoDeGarcons INTEGER,
        numeroMaximoDeAnimadores INTEGER,
        numeroMaximoDeBuffets INTEGER,
        numeroMaximoDeChurrasqueiros INTEGER
        )
      '''
      );


  }

 
}
