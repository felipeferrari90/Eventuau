import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:event_uau/components/card_event.dart';
import 'package:event_uau/models/evento_model.dart';
import 'package:event_uau/providers/event.dart';
import 'package:event_uau/providers/evento_provider.dart';
import 'package:event_uau/repository/evento_repository.dart';
import 'package:event_uau/service/event_service.dart';
import 'package:event_uau/service/evento_service.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DashBoardScreenEvents extends StatefulWidget {
  const DashBoardScreenEvents({Key key}) : super(key: key);

  @override
  _DashBoardScreenEventsState createState() => _DashBoardScreenEventsState();
}

class _DashBoardScreenEventsState extends State<DashBoardScreenEvents> {    
  Future _eventFutureRef;

  @override
  void didUpdateWidget(covariant DashBoardScreenEvents oldWidget) {
    _eventFutureRef = _getEvents();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();    
    _eventFutureRef = _getEvents();
  }

  Future<void> _getEvents() async {
    await Provider.of<Event>(context, listen: false).fetchEvents();
  }

  @override
  Widget build(BuildContext context) {    
    final events = Provider.of<Event>(context).events;
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => Navigator.pushNamed(context, "/event/new"),            
        child: Icon(
          Icons.add,
          size: 32,
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Expanded(
                child: SingleChildScrollView(
                  child: FutureBuilder(
                    future: _eventFutureRef,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError)
                        return Center(
                            child: Text('Erro ao buscar dados de evento.'));
                      return Container(
                        width: double.infinity,
                        child: Column(
                          children: events.length == 0
                              ? [
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 4,
                                  ),
                                  Text(
                                    "Você não possui eventos no momento. \n Crie um para você poder contratar funcionários",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ]
                              : events
                                  .map(
                                    (e) => CardEvent(
                                      eventoModel: e,
                                    ),
                                  )
                                  .toList(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
