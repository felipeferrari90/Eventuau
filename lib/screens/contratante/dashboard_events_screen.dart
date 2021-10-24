import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:event_uau/components/card_event.dart';
import 'package:event_uau/models/evento_model.dart';
import 'package:event_uau/providers/evento_provider.dart';
import 'package:event_uau/repository/evento_repository.dart';
import 'package:event_uau/service/event_service.dart';
import 'package:event_uau/service/evento_service.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DashBoardScreenEvents extends StatefulWidget {
  const DashBoardScreenEvents({Key key}) : super(key: key);

  @override
  _DashBoardScreenEventsState createState() => _DashBoardScreenEventsState();
}

class _DashBoardScreenEventsState extends State<DashBoardScreenEvents> {
  EventoService eventoService = EventoService();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              "MEUS EVENTOS",
              style: TextStyle(
                  fontSize: 24,
                  color: primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 16,
                ),
                child: Icon(
                  Icons.history,
                  size: 32,
                  color: pink,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: RaisedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/event/new")
                          .then((value) => setState(() {}));
                    },
                    color: primaryColor,
                    textColor: colorBg,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Text("Criar Evento"),
                    )),
              )
            ],
          ),
          Container(
              child: Expanded(
            child: SingleChildScrollView(
              child: FutureBuilder<Map<String, dynamic>>(
                  future: eventoService.getAllEvents(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      // Uncompleted State
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                        break;
                      default:
                        // Completed with error
                        if (snapshot.hasError)
                          return Container(
                              child: Text(snapshot.error.toString()));
                        // Completed with data
                        return Container(
                            child: (snapshot.data['total'] == 0)
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                      ),
                                      Text(
                                        "você não possui eventos no momento\n, crie um para você poder contratar funcionarios",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: (snapshot.data['resultados']
                                                as List ??
                                            [])
                                        .map((e) => setCardEvent(context,
                                            eventoModel: new EventoModel(
                                              id: (e as Map<String, dynamic>)[
                                                  'id'],
                                              descricao: (e as Map<String,
                                                  dynamic>)['descricao'],
                                              nome: (e as Map<String, dynamic>)[
                                                  'nome'],
                                              dataEHorarioInicio:
                                                  DateTime.parse((e as Map<
                                                      String,
                                                      dynamic>)['dataInicio']),
                                              dataEHorarioTermino:
                                                  DateTime.parse((e as Map<
                                                      String,
                                                      dynamic>)['dataTermino']),
                                              duracaoMinima: DateTime.parse((e
                                                          as Map<String,
                                                              dynamic>)[
                                                      'dataTermino'])
                                                  .difference(DateTime.parse((e
                                                          as Map<String,
                                                              dynamic>)[
                                                      'dataInicio']))
                                                  .inHours,
                                              observacoes: (e as Map<String,
                                                      dynamic>)["observacao"] ??
                                                  "Sem observacoes",
                                              status: EnumToString.fromString(
                                                      StatusEvento.values,
                                                      e["statusEvento"]) ??
                                                  StatusEvento.CONTRATANDO,
                                              funcionarios: (e as Map<String,
                                                          dynamic>)[
                                                      'funcionariosContratados'] ??
                                                  List.empty(),
                                            )))
                                        .toList()));
                    }
                  }),
            ),
          )),
        ],
      ),
    );
  }
}
