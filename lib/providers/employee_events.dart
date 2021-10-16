import 'dart:convert';
import 'dart:io';

import 'package:event_uau/models/employee_event_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EmployeeEvents with ChangeNotifier {
  String token;
  List<EmployeeEventModel> _events;

  EmployeeEvents(this.token);

  List get events {
    return _events != null ? [..._events] : [];
  }

  Future<void> fetchEmployeeEvents() async {
    final url =
        'https://10.0.2.2:6011/api/propostas/parceiro?indice=0&tamanhoPagina=20';
    try {
      final res = await http.get(url,
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});

      if (res.statusCode != 200) throw res;

      final body = json.decode(res.body);
      final results = (body['resultados'] as List<Map<String, dynamic>>);

      if (results.length > 0)
        _events = results
            .map(
              (e) => new EmployeeEventModel(
                  id: e['id'],
                  name: e['nome'],
                  description: e['descricao'],
                  startDate: DateTime.parse(e['dataInicio']),
                  endDate: DateTime.parse(e['dataFim']),
                  maxDuration: e['minDuracao'],
                  minDuration: e['maxDuracao']),
            )
            .toList();
    } catch (e) {
      return Future.error(e);
    }

    notifyListeners();
  }
}
