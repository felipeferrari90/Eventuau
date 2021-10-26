import 'package:enum_to_string/enum_to_string.dart';
import 'package:event_uau/models/employee_event_model.dart';
import 'package:event_uau/models/evento_model.dart';
import 'package:event_uau/providers/event.dart';
import 'package:event_uau/screens/contratante/event_screen_description.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:event_uau/utils/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

const _innerPadding = 12.0;

class CardEvent extends StatelessWidget {
  const CardEvent({Key key, this.eventoModel}) : super(key: key);

  final EventItem eventoModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Column(
        children: [
          EventCardHeader(
            event: eventoModel,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: EventCardBody(
              event: eventoModel,
            ),
          ),
        ],
      ),
    );
  }
}

class EventCardBody extends StatelessWidget {
  const EventCardBody({Key key, this.event}) : super(key: key);

  final EventItem event;

  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (event.address != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      event.address == null
                          ? ''
                          : '${event.address.cep} - ${event.address.bairro}, ${event.address.cidade}',
                      // maxLines: ,
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(fontSize: 16),
                    ),
                  ),
                Row(
                  children: [
                    Icon(
                      Icons.hourglass_empty,
                      size: 16,
                    ),
                    Text(
                      " ${event.minDuration ?? event.endDate.difference(event.startDate).inHours} Hora${event.endDate.difference(event.startDate).inHours > 1 ? 's' : ''}",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 16,
                    ),
                    Text(
                      ' ${event.employees?.length ?? '0'} Contratado${event.employees?.length > 1 ? 's' : ''}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400),
                    ),
                  ],
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
                          EnumToString.convertToString(event.status) ??
                              'Desconhecido',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      elevation: 0,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 0),
                      visualDensity: VisualDensity.compact,
                      onPressed: () => // TODO CHANGES THIS IN THE FUTURE MAYBE
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => EventScreenDescription(
                                    event: event,
                                  ),
                        ),
                      ),                              
                      child: Text(
                        'Detalhes',
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

  final EventItem event;

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
