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
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(EventDetailScreen.routeName, arguments: id),
      onLongPress: () => print('open options menu'),
      child: Card(
        color: Colors.white,
        elevation: 2,
        child: Column(
          children: [
            EventCardHeader(
              event: event,
            ),
            EventCardBody(
              event: event,
            ),
          ],
        ),
      ),
    );
  }
}

class EventCardBody extends StatelessWidget {
  const EventCardBody({Key key, this.event}) : super(key: key);

  final EmployeeEventModel event;

  void showOptionsDialog() {}

  void navigateToEvenetDetails() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: _innerPadding, right: _innerPadding, top: 16),
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
                child: Icon(Icons.location_pin, color: Colors.black12)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.address.toString(),
                  // maxLines: ,
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(fontSize: 16),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      const Text(
                          'Status',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          event.status ?? 'Desconhecido',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    RaisedButton(
                      color: Theme.of(context).accentColor,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      visualDensity: VisualDensity.compact,
                      onPressed: () => Navigator.of(context).pushNamed(
                          EventDetailScreen.routeName,
                          arguments: event.id),
                      child: Text(
                        'Ver Proposta',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
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
            style: Theme.of(context).textTheme.headline6.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
          Text(
              '${DateFormat.yMMMMd('pt_BR').format(event.startDate)} - das ${DateFormat.Hm('pt_BR').format(event.startDate)} às ${DateFormat.Hm('pt_BR').format(event.endDate)}',
              style: Theme.of(context).textTheme.headline5)
        ],
      ),
    );
  }
}
