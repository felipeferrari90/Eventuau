import 'package:event_uau/models/contratante_model.dart';
import 'package:event_uau/repository/database_helper.dart';
import 'package:sqflite_common/sqlite_api.dart';


class ContratanteRepository {


  Future<List<ContratanteModel>> getAllContratantes() async {
    Database db = await DatabaseHelper().connection; 
    List<Map> maps = await db.query("contratanteModel",
        columns:  ["nome","cpf", "email", "telefone","dataNascimento","dataCriacaoConta","valorEmCaixaDisponivel","valorBloqueado"] ,
    );
    List<ContratanteModel> contratantes = [];
    maps.forEach((element) {
       ContratanteModel contratante= new ContratanteModel.fromMap(element);
       contratantes.add(contratante);
    });
    return contratantes;
  }

  Future<ContratanteModel> insert(ContratanteModel contratanteModel) async {
    Database db = await DatabaseHelper().connection; 
    contratanteModel.id = await db.insert("contratanteModel", contratanteModel.toMap());
    return contratanteModel;
  }

  Future<ContratanteModel> getContratante(int id) async {
    Database db = await DatabaseHelper().connection; 
    List<Map> maps = await db.query("contratanteModel",
        columns: ["nome","cpf", "email", "telefone","dataNascimento","dataCriacaoConta","valorEmCaixaDisponivel","valorBloqueado"],
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return ContratanteModel.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    Database db = await DatabaseHelper().connection; 
    return await db.delete("contratanteModel", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(ContratanteModel contratanteModel) async {
    Database db = await DatabaseHelper().connection; 
    return await db.update("contratanteModel", contratanteModel.toMap(),
        where: 'id= ?', whereArgs: [contratanteModel.id]);
  }

  
  
}
