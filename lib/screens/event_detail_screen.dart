import 'package:event_uau/components/employee/employee_event_card.dart';
import 'package:event_uau/providers/auth.dart';
import 'package:event_uau/providers/employee_events.dart';
import 'package:event_uau/screens/profissional/employee_home_screen.dart';
import 'package:event_uau/service/event_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({Key key}) : super(key: key);

  static const routeName = '/event/details';
  final bool _showPrices = false;

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final eventData = Provider.of<EmployeeEvents>(
      context,
    ).getById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text('Resumo do evento'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Field(
                label: 'Nome do Evento',
                value: eventData.name,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Field(
                      label: 'Data de Inicio',
                      value:
                          DateFormat('dd/M/yyyy').format(eventData.startDate),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Field(
                      label: 'Data de Término',
                      value: DateFormat('dd/M/yyyy').format(eventData.endDate),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Field(
                      label: 'Horário de Inicio',
                      value: DateFormat.Hm('pt_BR').format(eventData.startDate),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Field(
                      label: 'Horário de Término',
                      value: DateFormat.Hm('pt_BR').format(eventData.endDate),
                    ),
                  )
                ],
              ),
              Field(
                  label: 'Endereço',
                  value:
                      '${eventData.address.cep} - ${eventData.address.bairro}, ${eventData.address.cidade}'),
              if (eventData.isConsideringProposal)
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      'O endereço completo será revelado no dia do evento.',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),

              Container(
                padding: EdgeInsets.only(top: 2),
                height: 200,
                width: double.infinity,
                child: GoogleMap(
                    zoomGesturesEnabled: true,
                    liteModeEnabled: true,
                    circles: {
                      Circle(
                          strokeWidth: 1,
                          strokeColor: Color.fromRGBO(0, 0, 255, 0.4),
                          fillColor: Color.fromRGBO(0, 0, 255, 0.2),
                          visible: true,
                          circleId: CircleId('thisisaneasteregg'),
                          center: LatLng(eventData.address.latitudeValue,
                              eventData.address.longitudeValue),
                          radius: 800)
                    },
                    initialCameraPosition: CameraPosition(
                        zoom: 14,
                        target: LatLng(eventData.address.latitudeValue,
                            eventData.address.longitudeValue))),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'Parceiros Contratados:',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              FutureBuilder(
                future: fetchEventById(id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  if (snapshot.hasData &&
                      snapshot.data['funcionariosContratados'].length > 0) {
                    final funcionariosContratados =
                        snapshot.data['funcionariosContratados'] as List;
                    return Column(children: [
                      ...funcionariosContratados
                          .map((e) => EventCardEmployee(
                                name: e['funcionario']['nome'],
                                job: 'Garçom',
                              )) //@TODO TIRAR O MOCK
                          .toList()
                    ]);
                  }
                  return Text(
                    'Você é o primeiro à receber proposta para esse evento!',
                    style: Theme.of(context).textTheme.headline2,
                  );
                },
              ),
              Proposal(),
              // Title('Assistentes Selecionados'),
              // SizedBox(
              //   height: 12,
              // ),
              // EventCardEmployee(trailing: null),
              SizedBox(
                height: 12,
              ),
              if (_showPrices)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Title('Total:'), Title('R\$160,00')],
                )
            ],
          ),
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title(
    @required this.text, {
    Key key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headline2
          .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

class Field extends StatelessWidget {
  const Field(
      {Key key, @required this.label, @required this.value, this.hintText})
      : super(key: key);

  final String label;
  final String value;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      maxLines: 3,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 18,
      ),
      readOnly: true,
      decoration: InputDecoration(
        helperText: hintText,
        helperStyle:
            TextStyle(fontSize: 14, decoration: TextDecoration.underline),
        border: InputBorder.none,
        labelText: label,
        labelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: Theme.of(context).primaryColor),
      ),
      initialValue: value,
    );
  }
}

class Proposal extends StatelessWidget {
  const Proposal({Key key}) : super(key: key);

  AlertDialog _renderDialog(BuildContext context, String option) => AlertDialog(
        title: Text('Você quer mesmo $option a proposta?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Não',
            ),
          ),
          TextButton(
            onPressed: option != 'aceitar'
                ? () => Navigator.of(context).popUntil((route) =>
                    route.settings.name == EmployeeHomeScreen.routeName)
                : () async {
                    final id = ModalRoute.of(context).settings.arguments;
                    bool success = await acceptProposal(id);
                    if (!success) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Erro ao aceitar a proposta')));
                    } else {
                      Navigator.of(context).popUntil((route) =>
                          route.settings.name == EmployeeHomeScreen.routeName);
                    }
                  },
            child: Text(
              'Sim',
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final eventData =
        Provider.of<EmployeeEvents>(context, listen: false).getById(id);

    final eventDuration = eventData.endDate.difference(eventData.startDate);
    final eventDurationSplit = eventDuration.toString().split(':');
    final hourlyRate =
        Provider.of<Auth>(context, listen: false).user.partnerData.valorHora;
    final subtotal =
        (eventData.endDate.difference(eventData.startDate).inMinutes / 60) *
            hourlyRate;
    final serviceTax = 0.13;
    final eventUauCut = subtotal * serviceTax;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 12,
        ),
        Text('Proposta: ',
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold)),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tempo de Evento:'),
            Text('${eventDurationSplit[0]}H:${eventDurationSplit[1]}M')
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Preço por hora:'),
            Text(
              'R\$${hourlyRate.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.green,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Subtotal:',
            ),
            Text(
              'R\$${subtotal.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.green,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Taxa EventUau:',
            ),
            Text(
              'R\$ -${eventUauCut.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.redAccent,
              ),
            )
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total à receber:',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.bold)),
            Text('R\$${(subtotal - eventUauCut).toStringAsFixed(2)}',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.bold))
          ],
        ),
        SizedBox(
          height: 12,
        ),
        if (eventData.isConsideringProposal == true)
          Row(
            children: [
              Expanded(
                child: RaisedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => _renderDialog(context, 'recusar'),
                    );
                  },
                  child: Text('Recusar'),
                ),
              ),
              SizedBox(
                width: 24,
              ),
              Expanded(
                  child: RaisedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => _renderDialog(context, 'aceitar'),
                  );
                },
                child: Text('Aceitar'),
                color: Theme.of(context).accentColor,
              ))
            ],
          )
      ],
    );
  }
}
