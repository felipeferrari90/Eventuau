import 'dart:async';

import 'package:event_uau/models/contratante_model.dart';
import 'package:event_uau/models/contrato_model.dart';
import 'package:event_uau/models/evento_model.dart';
import 'package:event_uau/repository/database_helper.dart';
import 'package:sqflite_common/sqlite_api.dart';


class ContratoRepository {

  

  Future<ContratoModel> insert(ContratoModel contratoModel) async {
    Database db = await DatabaseHelper().connection; 
    contratoModel.id = await db.insert("contratoModel", contratoModel.toMap());
    return contratoModel;
  }

  Future<List<ContratoModel>> getAllContratos() async {
    Database db = await DatabaseHelper().connection; 
    List<Map> maps = await db.query("contratoModel",
        columns: ["evento","funcionario", "notaFuncionario", "statusFuncionario", "horaContratacao","horaChegadaFuncionario","horaSaidaFuncionario","horaExtra","horaExtra","precoAhoraCombinado","valorTotal"] ,
    );
    List<ContratoModel> contratos = [];
    maps.forEach((element) {
       ContratoModel contrato = new ContratoModel.fromMap(element);
       contratos.add(contrato);
    });
    return contratos;
  }

  Future<ContratoModel> getContrato(int id) async {
    Database db = await DatabaseHelper().connection; 
    List<Map> maps = await db.query("contratoModel",
        columns: ["evento","funcionario", "notaFuncionario", "statusFuncionario", "horaContratacao","horaChegadaFuncionario","horaSaidaFuncionario","horaExtra","horaExtra","precoAhoraCombinado","valorTotal"] ,
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return ContratoModel.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    Database db = await DatabaseHelper().connection; 
    return await db.delete("contratoModel", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(ContratoModel contratoModel) async {
    Database db = await DatabaseHelper().connection; 
    return await db.update("contratoModel", contratoModel.toMap(),
        where: 'id = ?', whereArgs: [contratoModel.id]);
  }

  
  
}
