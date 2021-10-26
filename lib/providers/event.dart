import 'package:collection/collection.dart';
import 'package:event_uau/models/address_model.dart';
import 'package:event_uau/models/contratado_model.dart';
import 'package:event_uau/models/event_employment_status_model.dart';
import 'package:event_uau/models/funcionario_model.dart';
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
  List<ContratadoModel> employees;

  get durationInHours {
    final duration =
        (endDate.difference(startDate).inMinutes / 60).toStringAsPrecision(2);

    print(duration);

    return double.parse(duration);
  }

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

  EventItem getById(int id) =>
      _events.firstWhere((element) => element.id == id);

  Future<void> addEmployeesToEvent(
      List<ContratadoModel> employees, int id) async {
    final index = _events.indexWhere((element) => element.id == id);
    final eventToEdit = _events[index];
    try {
      await Future.wait(
          employees.map(
            (element) => EventService.sendProposal(
                eventId: eventToEdit.id,
                salary: element.valorHora * eventToEdit.durationInHours,
                specialtyId: element.especialidades[0]
                    .id, // THIS SUCKS IF THEY HAVE MORE THAN ONE SPECIALTY, FIX LATER
                userId: element.id),
          ),
          eagerError: true);

      final newEmployeesList = [..._events[index].employees, ...employees];

      eventToEdit.employees = newEmployeesList;

      _events.removeAt(index);
      _events.insert(index, eventToEdit);
    } catch (e) {
      debugPrint(e);
    }

    notifyListeners();
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

          final List<ContratadoModel> employees = [];
          final List _funcionarios = element['funcionarios'];

          if (_funcionarios.length > 0)
            _funcionarios.forEach(
              (e) {
                final funcionario = e['funcionario'];
                final statusContratacao = e['statusContratacao'];
                final especialidade = e['especialidade'];

                employees.add(
                  new ContratadoModel(
                    id: funcionario['id'],
                    nome: funcionario['nome'],
                    cpf: null,
                    phone: null,
                    valorHora:
                        double.parse(funcionario['valorPorHora'].toString()),
                    birthDate: DateTime.parse(funcionario['dataNascimento']),
                    especialidades: [
                      JobItem(
                          id: especialidade['id'],
                          descricao: especialidade['descricao'])
                    ],
                    status: new EventEmploymentStatus(
                        hasRefused: statusContratacao['ehRecusado'],
                        id: statusContratacao['id'],
                        descricao: statusContratacao['descricao']),
                  ),
                );
              },
            );

          _events.add(
            new EventItem(
              id: element['id'],
              description: element['descricao'],
              name: element['nome'],
              startDate: DateTime.parse(element['dataInicio']),
              endDate: DateTime.parse(element['dataTermino']),
              status: enumFromString(element['status']['id']),
              address: address,
              employees: employees,
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
