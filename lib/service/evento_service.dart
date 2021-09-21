import 'dart:async';
import 'dart:convert';
import 'package:event_uau/models/contratante_model.dart';
import 'package:event_uau/models/evento_model.dart';
import 'package:http/http.dart' as http;

class EventoService {

  String _endPoint = "https://localhost:6011/api/eventos";

  Future<int> create(EventoModel eventoModel) async {
    try {
      http.Response response = await http.post(
        Uri.parse(_endPoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: eventoModel.toJson(),
      );
      if (response.statusCode == 201) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
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
    try {
      http.Response response = await http.get(Uri.parse(_endPoint));
      if (response.statusCode == 200) {
        (json.decode(response.body) as List<EventoModel>).forEach((value) {
          lista.add(EventoModel.fromMap(value as Map<String, dynamic>));
        });
      }
    } catch (error) {
      throw error;
    }
    return lista;
  }

  Future<EventoModel> getById(int id) async {
    try {
      http.Response response = await http.get(Uri.parse("$_endPoint/$id"));
      if (response.statusCode == 200) {
        return EventoModel.fromJson(response.body);
      }
    } catch (error) {
      throw error;
    }
    return null;
  }

  Future<int> update(EventoModel eventoModel) async {
    try {
      http.Response response = await http.put(
        Uri.parse("$_endPoint/${eventoModel.id}"),
        body: eventoModel.toJson(),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        int idRetornado = (jsonResponse['id'] is String)
            ? int.parse(jsonResponse["id"])
            : jsonResponse["id"];
        return idRetornado;
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> delete(EventoModel eventoModel) async {
    try {
      http.Response response =
          await http.delete(Uri.parse("$_endPoint/${eventoModel.id}"));
      if (response.statusCode == 206) {
        throw Exception("Não foi possível excluir seu evento!");
      }
    } catch (error) {
      throw error;
    }
  }
}

