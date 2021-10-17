import 'package:collection/collection.dart';
import 'dart:convert';
import 'dart:io';

import 'package:event_uau/models/address_model.dart';
import 'package:event_uau/models/employee_event_model.dart';
import 'package:event_uau/service/event_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EmployeeEvents with ChangeNotifier {
  String token;
  List<EmployeeEventModel> _events = [];

  EmployeeEvents(this.token);

  List get events {
    return _events != null ? [..._events] : [];
  }

  EmployeeEventModel getById(int id) {
    return _events.firstWhere(((element) => element.id == id));
  }

  Future<void> fetchEmployeeEvents() async {    
    final url =
        'https://10.0.2.2:6011/api/propostas/parceiro?indice=0&tamanhoPagina=20';
    try {
      final res = await http.get(url,
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});

      if (res.statusCode != 200) throw res;

      final body = json.decode(res.body);
      final results = body['resultados'] as List;

      if (results.length > 0) {
        _events?.clear();
        final addresses =
            await Future.wait(results.map((e) => getEventAddress(e['id'])));

        results.forEachIndexed((index, e) {
          final address = new AddressModel(
              id: addresses[index]['id'],
              latitude: addresses[index]['latitude'],
              longitude: addresses[index]['longitude'],
              cep: addresses[index]['cep'],
              rua: addresses[index]['logradouro'],
              numero: addresses[index]['numero'],
              bairro: addresses[index]['bairro'],
              cidade: addresses[index]['cidade'],
              estado: addresses[index]['estado'],
              complemento: addresses[index]['complemento']);

          _events.add(
            new EmployeeEventModel(
              id: e['id'],
              name: e['nome'],
              description: e['descricao'],
              startDate: DateTime.parse(e['dataInicio']),
              endDate: DateTime.parse(e['dataTermino']),
              maxDuration: e['duracaoMinima'],
              minDuration: e['duracaoMaxima'],
              status: e['status'],
              address: address,
            ),
          );
        });
      }
    } catch (e) {
      _events = null;
      throw e;
    }
    notifyListeners();
  }
}
