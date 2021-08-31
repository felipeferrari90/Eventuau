

import 'dart:async';
import 'dart:convert';
import 'package:event_uau/models/contratante_model.dart';
import 'package:event_uau/models/evento_model.dart';
import 'package:http/http.dart' as http;



class EventoService {
   
  Future<int?> create(EventoModel eventoModel) async{

    
    try{
       http.Response response = await http.post(Uri.parse("API"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: eventoModel.toJson(),
       );
       if(response.statusCode == 201){
          Map<String,dynamic> jsonResponse =  json.decode(response.body);
          int idRetornado = jsonResponse["id"];
          return idRetornado;
       }
    } catch (error) {
      print("Service Error: $error ");
      throw error;
    }
  }

  Future<List<EventoModel>> getAllbyContratante() async {
    List<EventoModel> lista = new List.empty();
    try{
      http.Response response = await http.get(Uri.parse("API"));
      if(response.statusCode == 200){
        (json.decode(response.body) as List<EventoModel>).forEach(
          (value)  {
            lista.add(EventoModel.fromMap(value as Map<String,dynamic>));
          }
        );
      } 
    } catch(error){
       throw error;
    }
    return lista; 
  }

  

  Future<EventoModel?> getById(int id) async {
    try{
      http.Response response = await http.get(Uri.parse("API/${id}"));
      if(response.statusCode == 200){
        return EventoModel.fromJson(response.body);
      }   
    } catch(error) {
      throw error;
    }
  }

  Future<int?> update(EventoModel eventoModel) async{
    try{
      http.Response response = await http.put(Uri.parse("API/${eventoModel.id}"),
        body: eventoModel.toJson(),
      );
      if(response.statusCode == 200){
        Map<String,dynamic> jsonResponse =  json.decode(response.body);
          int idRetornado = (jsonResponse['id'] is String) ? int.parse(jsonResponse["id"]) : jsonResponse["id"] ;
          return idRetornado;
      }   
    }catch(error){
      throw error;
    }
  } 
  
  Future<void> delete(EventoModel eventoModel) async {
    try{
      http.Response response = await http.delete(Uri.parse("API/${eventoModel.id}"));
      if(response.statusCode == 206){
         throw Exception("Não foi possível excluir seu evento!");
      }
    } catch(error) {
      throw error;
    }
  }
       
}

/*
class ContratanteService {

  static final String _endpoint =
      "https://60ff7206257411001707898c.mockapi.io/eventuau/api/contratante";

  static final String _resource = 'curso';

  final ServiceConfig service = new ServiceConfig(_endpoint);


  Future<List<ContratanteModel>> findAll() async {
    List<ContratanteModel> lista = new List<ContratanteModel>();
    try {
      Response response = await service.create().get(_resource);
      if (response.statusCode == 200) {
        response.data.forEach(
          (value) {
            print(value);
            lista.add(
              ContratanteModel.fromMap(value),
            );
          },
        );
      }
    } catch (error) {
      print("Service Error: $error ");
      throw error;
    }

    return lista;
  }

  Future<int> create(ContratanteModel contratanteModel) async {
    try {
      contratanteModel.id = 0;
      Response response = await service.create().post(
            _resource,
            data: contratanteModel.toMap(),
          );

      if (response.statusCode == 201) {
        var retorno = ( response.data["id"] is String ) ? 
            int.parse(response.data["id"]) : 
            response.data["id"];
        return retorno;
      }
    } catch (error) {
      print("Service Error: $error ");
      throw error;
    }
  }

  Future<ContratanteModel> getById(int id) async {
    try {
      String endpoint = _resource + "/" + id.toString();
      Response response = await service.create().get(endpoint);

      if (response.statusCode == 200) {
        var retorno = ContratanteModel.fromMap(response.data);
        return retorno;
      }

    } catch (error) {
      print("Service Error: $error ");
      throw error;
    }
  }

  Future<int> update(ContratanteModel cursoModel) async {
    try {
      String endpoint = _resource + "/" + cursoModel.id.toString();

      Response response = await service.create().put(
            endpoint,
            data: cursoModel.toMap(),
          );

      var retorno = ( response.data["id"] is String ) ? 
            int.parse(response.data["id"]) : 
            response.data["id"];
        return retorno;
    } catch (error) {
      print("Service Error: $error ");
      throw error;
    }
  }

  Future<void> delete(ContratanteModel contratanteModel) async {
    try {
      String endpoint = _resource + "/" + contratanteModel.id.toString();

      Response response = await service.create().delete(
            endpoint,
          );

      if (response.statusCode != 200) {
        throw Exception("Não foi possível excluir o recurso!");
      }

    } catch (error) {
      throw error;
    }
  }
}*/
