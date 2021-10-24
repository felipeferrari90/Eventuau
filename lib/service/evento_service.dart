import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:event_uau/models/contratante_model.dart';
import 'package:event_uau/models/evento_model.dart';
import 'package:event_uau/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final userData = Auth();

class EventoService {
  String _baseUrl = "https://10.0.2.2:6011/api";
  String _endPoint = "/eventos";

  final _headers = {
    HttpHeaders.authorizationHeader: 'Bearer ${userData.token}',
    HttpHeaders.contentTypeHeader: 'application/json'
  };

  Future<int> create(EventoModel eventoModel) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$_baseUrl$_endPoint"),
        headers: _headers,
        body: eventoModel.toJson(),
      );
      if (response.statusCode == 201) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        eventoModel.id = jsonResponse["id"];
        return eventoModel.id;
      }
      print("provider.create: status code ${response.statusCode}");
    } catch (error) {
      print("Service Error: $error");
      throw error;
    }
  }

  Future<Map<String, dynamic>> getAllEvents() async {
    http.Response response =
        await http.get("$_baseUrl$_endPoint", headers: _headers);

    if (response.statusCode != 200) throw response;
    print("provider.listagem: status code ${response.statusCode}");
    print("provider.listagem: status code ${response.body}");

    Map<String, dynamic> resposta = jsonDecode(response.body);
    return resposta;
  }

  Future<EventoModel> getById(int id) async {
    try {
      http.Response response =
          await http.get(Uri.parse("$_baseUrl$_endPoint/$id"));
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
        Uri.parse("$_baseUrl$_endPoint/${eventoModel.id}"),
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
          await http.delete(Uri.parse("$_baseUrl$_endPoint/${eventoModel.id}"));
      if (response.statusCode == 206) {
        throw Exception("Não foi possível excluir seu evento!");
      }
    } catch (error) {
      throw error;
    }
  }
}
