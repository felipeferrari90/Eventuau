import 'package:event_uau/models/evento_model.dart';
import 'package:event_uau/service/event_service.dart';
import 'package:event_uau/service/evento_service.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'auth.dart';

class EventoProvider with ChangeNotifier {
  List<EventoModel> _events = [];
  EventoService eventoService = EventoService();

  get events async {
    return [..._events];
  }

  Future<List<EventoModel>> fetchEvents() async {
    _events..clear();
    final response = await eventoService.getAllEvents();
    if (response.length > 0) {
      response.forEach((element) => events.add(element));
    }
    notifyListeners();
    return _events;
  }

  Future<void> createEvent(EventoModel eventoModel) async {
    await eventoService
        .create(eventoModel)
        .then((_) => _events.add(eventoModel));

    notifyListeners();
  }
}
