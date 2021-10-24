import 'dart:convert';
import 'dart:io';

import 'package:event_uau/models/evento_model.dart';
import 'package:event_uau/service/event_service.dart';
import 'package:event_uau/service/evento_service.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EventoProvider with ChangeNotifier {
  String token;

  List<EventoModel> _events = [];

  List get events {
    return _events != null ? [..._events] : [];
  }

  EventoModel getById(int id) {
    return _events.firstWhere(((element) => element.id == id));
  }
}
