import 'package:event_uau/models/employee_event_model.dart';
import 'package:event_uau/providers/employee_events.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../screens/event_detail_screen.dart';
import './employee_event_card.dart';

const _innerPadding = 12.0;

class EventCard extends StatelessWidget {
  const EventCard({Key key, this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    final EmployeeEventModel event =
        Provider.of<EmployeeEvents>(context, listen: false).getById(id);
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Column(
        children: [
          EventCardHeader(
            event: event,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: EventCardBody(
              event: event,
            ),
          ),
        ],
      ),
    );
  }
}

class EventCardBody extends StatelessWidget {
  const EventCardBody({Key key, this.event}) : super(key: key);

  final EmployeeEventModel event;

  void _navigateToDetails(BuildContext context, Function callback) async {
    await Navigator.of(context).pushNamed(EventDetailScreen.routeName,
        arguments: {
          'id': event.id,
          'previousRoute': ModalRoute.of(context).settings.name
        });

    callback();
  }

  Widget build(BuildContext context) {
    final refreshEventsList =
        Provider.of<EmployeeEvents>(context, listen: false).fetchEmployeeEvents;

    return Padding(
      padding: const EdgeInsets.all(_innerPadding),
      child: Row(        
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.only(right: _innerPadding),
            child: SizedBox(
                height: 90,
                width: 90,
                child: Icon(Icons.event, color: Colors.black26)),
          ),
          Expanded(
            child: Column(              
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    '${event.address.cep} - ${event.address.bairro}, ${event.address.cidade}',
                    // maxLines: ,
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        .copyWith(fontSize: 16),
                  ),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Status do Evento:',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          event.eventStatus.descricao ?? 'Desconhecido',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              fontSize: 16),
                        ),
                        const Text(
                          'Sua Contratação:',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          event.employmentStatus.descricao ?? 'Desconhecido',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    RaisedButton(                      
                      color: event.isConsideringProposal
                          ? Theme.of(context).accentColor
                          : Theme.of(context).primaryColor,
                      elevation: 0,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 0),
                      visualDensity: VisualDensity.compact,
                      onPressed: () =>
                          _navigateToDetails(context, refreshEventsList),
                      child: Text(
                        '${event.isConsideringProposal ? 'Ver Proposta' : 'Detalhes'}',
                      ),
                    ),
                  ],
                ),            
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EventCardHeader extends StatelessWidget {
  const EventCardHeader({
    Key key,
    this.event,
  }) : super(key: key);

  final EmployeeEventModel event;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(_innerPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
        color: Theme.of(context).accentColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.name,
            style: Theme.of(context).textTheme.headline5.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
              '${DateFormat.yMMMMd('pt_BR').format(event.startDate)} - das ${DateFormat.Hm('pt_BR').format(event.startDate)} às ${DateFormat.Hm('pt_BR').format(event.endDate)}',
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .copyWith(color: Colors.black))
        ],
      ),
    );
  }
}
