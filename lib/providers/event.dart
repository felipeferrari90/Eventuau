import 'package:collection/collection.dart';
import 'package:event_uau/models/address_model.dart';
import 'package:event_uau/service/address_service_event.dart';
import 'package:event_uau/service/event_service.dart' as EventService;
import 'package:flutter/material.dart';

class EventItem {
  int id;
  String name;
  String description;
  String observations;
  DateTime startDate;
  DateTime endDate;
  int minDuration;
  int maxDuration;
  StatusEvento status;
  AddressModel address;
  List employees;

  EventItem(
      {this.id,
      @required this.name,
      @required this.description,
      @required this.startDate,
      @required this.endDate,
      this.status,
      this.address,
      this.employees = const []});
}

enum StatusEvento {
  CRIADO, // evento foi criado apenas, sem funcionarios contratados
  CONTRATANDO,
  FECHADO, //todas as vagas ja foram ocupadas porem funcionarios que aceitaram a proposta podem aparecer na lista de espera
  ACONTECENDO, // evento em questão esta acontecendo no momento
  TERMINADO, // evento acabou, nao aparece mais na tela principal de eventos
  CANCELADO // evento cancelado antes do termino estipulado,
}

StatusEvento enumFromString(String str) {
  StatusEvento f = StatusEvento.values
      .firstWhere((e) => e.toString() == 'StatusEvento.' + str);

  return f;
}

class Event with ChangeNotifier {
  List<EventItem> _events = [];

  List<Object> get events {
    return [..._events];
  }

  Future<void> fetchEvents() async {
    final response = await EventService.getEvents();
    _events.clear();

    final results = response['resultados'] as List;

    try {
      if (response['total'] > 0) {
        final addresses = await Future.wait(
            results.map((e) => EventService.getEventAddress(e['id'])));

        (response['resultados'] as List).forEachIndexed((index, element) {
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
            new EventItem(
              id: element['id'],
              description: element['descricao'],
              name: element['nome'],
              startDate: DateTime.parse(element['dataInicio']),
              endDate: DateTime.parse(element['dataTermino']),
              status: enumFromString(element['status']['id']),
              address: address,
              employees: element['funcionarios'],
            ),
          );
        });
      }
    } catch (e) {
      debugPrint(e);
    }

    notifyListeners();
  }

  Future<void> createEvent(EventItem event) async {
    try {
      event.status = StatusEvento.CRIADO;
      final eventId = await EventService.postEvent(event);

      event.id = eventId;

      await createEventAddress(event.address, eventId);

      _events.add(event);
    } catch (e) {
      debugPrint(e);
      debugPrint('fail create event');
      throw e;
    }

    notifyListeners();
  }
}
