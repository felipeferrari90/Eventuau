import 'package:event_uau/models/contratante_model.dart';
import 'package:event_uau/models/evento_model.dart';
import 'package:event_uau/repository/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite_common/sqlite_api.dart';


class EventoRepository {

  Future<List<EventoModel>> getAllEventosByIdContratante() async {

    Database db = await DatabaseHelper().connection; 
    

   
    List<Map> maps = await db.query("eventoModel",
        columns: ["id", "numeroDeEvento","nome", "descricao", "endereco","conteudo","statusEvento","idOrganizador","dataEHoraCriacaoEvento","dataEHorarioInicio","tempoDuracaoMinimoPreDeterminado","tempoDuracaoMaximoPreDeterminado","valorEvento","observacoes","statusContratacaoEvento","estaVisivel","estaPago","numeroMaximoDeGarcons","numeroMaximoDeAnimadores","numeroMaximoDeBuffets","numeroMaximoDeChurrasqueiros"] ,   
    );
    List<EventoModel> eventos = [];
    maps.forEach((element) {
       EventoModel evento = new EventoModel.fromMap(element);
       eventos.add(evento);
    });
    debugPrint("todos os eventos listados");
    return eventos;
  }

  Future<EventoModel> insert(EventoModel eventoModel) async {
    Database db = await DatabaseHelper().connection; 
    eventoModel.id = await db.insert("eventoModel", eventoModel.toMap());
    debugPrint("eventoCriado");
 
    return eventoModel;
  }

  Future<EventoModel> getEvento(int id) async {
    Database db = await DatabaseHelper().connection; 
    List<Map> maps = await db.query("eventoModel",
        columns: ["id","numeroDeEvento","nome", "descricao", "endereco","conteudo","statusEvento","idOrganizador","dataEHoraCriacaoEvento","dataEHorarioInicio","tempoDuracaoMinimoPreDeterminado","tempoDuracaoMaximoPreDeterminado","valorEvento","observacoes","statusContratacaoEvento","estaVisivel","estaPago","numeroMaximoDeGarcons","numeroMaximoDeAnimadores","numeroMaximoDeBuffets","numeroMaximoDeChurrasqueiros"] ,
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return EventoModel.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    Database db = await DatabaseHelper().connection; 
    return await db.delete("eventoModel", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(EventoModel eventoModel) async {
    Database db = await DatabaseHelper().connection; 
    return await db.update("eventoModel", eventoModel.toMap(),
        where: 'id= ?', whereArgs: [eventoModel.id]);
  }

 
  
  
}
