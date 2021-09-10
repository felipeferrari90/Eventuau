import 'package:flutter/material.dart';

const _innerPadding = 8.0;

class EventCard extends StatelessWidget {
  const EventCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Column(
        children: [
          EventCardHeader(),
          EventCardBody(),
          Card(
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              tileColor: Color.fromRGBO(0, 0, 0, 0.05),
              leading: Icon(
                Icons.account_circle,
                color: Theme.of(context).primaryColor,
              ),
              title: Text('Pedro Lemes, 24'),
              subtitle: Row(
                children: [
                  Text(
                    'Garçom',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    '4.89/5',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class EventCardBody extends StatelessWidget {
  const EventCardBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.all(_innerPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromRGBO(0, 0, 0, 0.05),
          ),
          height: 100,
          width: 100,
          padding: EdgeInsets.all(_innerPadding),
          child: Center(child: Icon(Icons.location_pin, color: Colors.black12)),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rua 14 de Abril, Brasilândia - São Paulo - SP',
                maxLines: 2,
                style: Theme.of(context).textTheme.headline2,
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
      color: Theme.of(context).accentColor,
      width: double.infinity,
      padding: EdgeInsets.all(_innerPadding),
      child: Stack(
        children: [
          Column(
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
          Positioned(
            top: -10,
            right: -10,
            child: PopupMenuButton(
                padding: EdgeInsets.zero,
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text('Deletar'),
                      )
                    ]),
          )
        ],
      ),
    );
  }
}
