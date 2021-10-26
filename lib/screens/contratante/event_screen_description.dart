import 'package:enum_to_string/enum_to_string.dart';
import 'package:event_uau/components/app_bar_eventual.dart';

import 'package:event_uau/components/employee/employee_event_card.dart';

import 'package:event_uau/models/evento_model.dart';

import 'package:event_uau/providers/employee_wallet_data.dart';
import 'package:event_uau/providers/event.dart';
import 'package:event_uau/screens/contratante/employees_screen.dart';

import 'package:event_uau/utils/colors.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventScreenDescription extends StatefulWidget {
  const EventScreenDescription({Key key, this.event}) : super(key: key);

  final EventItem event;

  _EventScreenDescriptionState createState() => _EventScreenDescriptionState();
}

class _EventScreenDescriptionState extends State<EventScreenDescription> {
  void _finishEvent(int id) async {
    bool userConfirmedFinishing = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Quer mesmo finalizar o evento?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Não'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Sim'),
          )
        ],
      ),
    );

    if (!userConfirmedFinishing) return;

    await Provider.of<Event>(context, listen: false).finishEvent(id);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Evento finalizado')));
  }

  @override
  Widget build(BuildContext context) {
    final employees = widget.event.employees;
    final eventInfo = Provider.of<Event>(context).getById(widget.event.id);
    final duration = widget.event.endDate.difference(widget.event.startDate);
    final eventDurationSplit = duration.toString().split(':');

    return Scaffold(
      appBar: EventUauAppBar(
        title: 'Detalhes',
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 2),
                  child: Text("${widget.event.name}",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                  child: Text(
                      "De ${DateFormat.yMMMMd('pt_BR').format(widget.event.startDate) ?? "Sem data e horario marcados"} - ${DateFormat.Hm('pt_BR').format(widget.event.startDate) ?? ""}",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: primaryColor)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                  child: Text(
                      "Até ${DateFormat.yMMMMd('pt_BR').format(widget.event.endDate) ?? "Sem data e horario marcados"} - ${DateFormat.Hm('pt_BR').format(widget.event.endDate) ?? ""}",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: primaryColor)),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 2, 4),
                      child: Text("Duração: ",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: primaryColor)),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 2, 0, 4),
                      child: Text(
                          "${eventDurationSplit[0]} Hora${int.parse(eventDurationSplit[0]) > 1 ? 's' : ''} e ${eventDurationSplit[1]} Minuto${int.parse(eventDurationSplit[1]) > 1 ? 's' : ''}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Color.fromRGBO(0, 0, 0, 0.7))),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 2, 4),
                      child: Text("Endereco: ",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: primaryColor)),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 2, 0, 4),
                        child: Text(
                            "${widget.event?.address?.toString() ?? "Sem endereco"}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Color.fromRGBO(0, 0, 0, 0.7))),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 2, 4),
                      child: Text("Status Evento: ",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: primaryColor)),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 2, 0, 4),
                      child: Text(
                          EnumToString.convertToString((widget.event.status)),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: primaryColor)),
                    ),
                  ],
                ),
                Divider(),
                if (widget.event.description != null) ...[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Text("Sobre o Evento",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                    child: Text("${widget.event.description}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Color.fromRGBO(0, 0, 0, 0.7))),
                  ),
                  Divider(),
                ],
                Text(
                    "Agora que o evento foi criado você pode contratar funcionários",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Color.fromRGBO(0, 0, 0, 0.7))),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: RaisedButton.icon(
                    onPressed: () => Navigator.pushNamed(
                        context, EmployeeChoiceScreen.routeName, arguments: {
                      'duration': widget.event.durationInHours,
                      'eventId': widget.event.id
                    }),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    icon: Icon(Icons.search, size: 16),
                    label: Text("IR PRA TELA DE ESCOLHAS"),
                    color: primaryColor,
                    textColor: colorBg,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                if (employees.length > 0) ...[
                  SizedBox(
                    height: 12,
                  ),
                  Divider(),
                  Text(
                    "Você pode gerenciar os funcionários que já foram contratados para esse evento ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 2, 0, 4),
                    child: Text(
                      "${widget.event.employees.length} Funcionário${widget.event.employees.length > 1 ? 's' : ''} Contratado${widget.event.employees.length > 1 ? 's' : ''}: ",
                      style: TextStyle(
                          fontSize: 16, color: Color.fromRGBO(0, 0, 0, 0.7)),
                    ),
                  ),
                  SizedBox(height: 12),
                  ...eventInfo.employees.map(
                    (e) => EventCardEmployee(
                      age: (DateTime.now().year - e.birthDate.year).toString(),
                      id: e.id,
                      name: e.nome,
                      job: e.especialidades[0].descricao,
                      trailing: Text(
                          e.status?.hasRefused != null && e.status.hasRefused
                              ? 'Recusado'
                              : 'Pendente'),
                    ),
                  ),
                ],
                if (widget.event.observations != null) ...[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Text("Observações:",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                    child: Text("${widget.event.observations}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Color.fromRGBO(0, 0, 0, 0.7))),
                  ),
                ],
                if (DateTime.now().isAfter(eventInfo.startDate)) ...[
                  SizedBox(
                    height: 6,
                  ),
                  Divider(),
                  Align(
                    alignment: Alignment.center,
                    child: RaisedButton.icon(
                      color: Theme.of(context).accentColor,
                      label: Text('Finalizar Evento'),
                      padding:
                          EdgeInsets.symmetric(horizontal: 92, vertical: 12),
                      icon: Icon(
                        Icons.done,
                        size: 20,
                      ),
                      onPressed: DateTime.now().isAfter(eventInfo.startDate) &&
                              eventInfo.status != StatusEvento.FINALIZADO &&
                              eventInfo.status != StatusEvento.CANCELADO
                          ? () => _finishEvent(eventInfo.id)
                          : null,
                    ),
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
