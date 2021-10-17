import 'package:event_uau/service/event_service.dart' as EventService;
import 'package:flutter/material.dart';

class EventItem {
  int id;
  String name;
  String description;
  DateTime startDate;
  DateTime endDate;
  int minDuration;
  int maxDuration;
  String status;
  String address;
  List employees;

  EventItem(
      {this.id,
      @required this.name,
      @required this.description,
      @required this.startDate,
      @required this.endDate,
      this.status,
      this.address,
      this.employees});
}

class Event with ChangeNotifier {
  List<EventItem> _events;

  get events {
    return [..._events];
  }

  Future<void> fetchEvents() async {
    final response = await EventService.getEvents();
    _events.clear();

    if (response['total'] > 0) {
      (response['resultados'] as List).forEach(
        (element) => events.add(
          new EventItem(
            id: element['id'],
            description: element['descricao'],
            name: element['name'],
            startDate: new DateTime(element['dataInicio']),
            endDate: new DateTime(element['dataFim']),
            status: element['status'],
            address: element['address'],
            employees: element['employees'],
          ),
        ),
      );
    }

    notifyListeners();
  }

  Future<void> createEvent(EventItem event) async {
    await EventService.postEvent(event);

    _events.add(event);

    notifyListeners();
  }
}
