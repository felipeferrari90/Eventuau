import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/components/card_event_dismissible.dart';
import 'package:event_uau/components/card_event_to_employee.dart';
import 'package:event_uau/components/employee/event_card.dart';
import 'package:flutter/material.dart';

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({Key key}) : super(key: key);

  static const routeName = '/employee/home';

  @override
  _EmployeeHomeScreenState createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
  List<String> _tabs = ['Todos', 'Solicitações', 'Confirmados', 'Finalizados'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("/");
              },
              child: Text(
                'Sair da Área do Parceiro',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            IconButton(
                icon: CircleAvatar(
                  backgroundColor: Theme.of(context).accentColor,
                  child: Text(
                    'FF',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                onPressed: () {
                  print('open user options menu');
                })
          ],
          title: Text(
            'Meus Eventos',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
              isScrollable: true,
              labelColor: Theme.of(context).primaryColor,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              tabs:
                  _tabs.map((e) => TabWithUnreadIndicator(label: e)).toList()),
        ),
        body: TabBarView(
            children: _tabs
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [EventCard()]),
                  ),
                )
                .toList()),
      ),
    );
  }
}

class TabWithUnreadIndicator extends StatelessWidget {
  const TabWithUnreadIndicator(
      {Key key, @required this.label, this.amountUnread})
      : super(key: key);

  final String label;
  final int amountUnread;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(children: [
        Text(label),
        if (amountUnread != null)
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            padding: EdgeInsets.all(6),
            margin: EdgeInsets.only(left: 6),
            child: Text(
              amountUnread.toString(),
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          )
      ]),
    );
  }
}
