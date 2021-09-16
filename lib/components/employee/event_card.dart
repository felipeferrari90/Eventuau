import 'package:flutter/material.dart';

import '../../screens/event_detail_screen.dart';
import './employee_event_card.dart';

const _innerPadding = 12.0;

class EventCard extends StatelessWidget {
  const EventCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(EventDetailScreen.routeName),
      onLongPress: () => print('open options menu'),
      child: Card(
        color: Colors.white,
        elevation: 2,
        child: Column(
          children: [
            EventCardHeader(),
            EventCardBody(),
            Padding(
              padding: const EdgeInsets.all(_innerPadding),
              child: EventCardEmployee(
                trailing: RaisedButton(
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  visualDensity: VisualDensity.compact,
                  onPressed: () {},
                  child: Text(
                    'Avaliar',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EventCardBody extends StatelessWidget {
  const EventCardBody({
    Key key,
  }) : super(key: key);

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
                  'Rua 14 de Abril, Brasilândia - São Paulo - SP',
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(fontSize: 16),
                ),
                SizedBox(
                  height: 8,
                ),
                const Text(
                  'Status',
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  'Finalizado',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      fontSize: 16),
                )
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
  }) : super(key: key);

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
            'Aniversário da Ana',
            style: Theme.of(context).textTheme.headline6.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
          Text('20 de Novambro de 2021 - 13:30 até 18:45',
              style: Theme.of(context).textTheme.headline5)
        ],
      ),
    );
  }
}
