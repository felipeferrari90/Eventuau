import 'package:enum_to_string/enum_to_string.dart';
import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/components/buttons.dart';
import 'package:event_uau/models/evento_model.dart';
import 'package:event_uau/providers/auth.dart';
import 'package:event_uau/providers/employee_wallet_data.dart';
import 'package:event_uau/providers/event.dart';
import 'package:event_uau/screens/contratante/employees_screen.dart';
import 'package:event_uau/service/evento_service.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:event_uau/utils/icons.dart';
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
  @override
  Widget build(BuildContext context) {
    final walletData = Provider.of<EmployeeWalletData>(context);
    return Scaffold(
        appBar: EventUauAppBar(
          title: 'Detalhes',
        ),
        body: Container(
            padding: EdgeInsets.all(16),
            color: colorBg,
            child: Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 32),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
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
                                " ${widget.event.minDuration ?? widget.event.endDate.difference(widget.event.startDate).inHours} Hora ${widget.event.endDate.difference(widget.event.startDate).inHours > 1 ? 's' : ''}",
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
                                EnumToString.convertToString(
                                    (widget.event.status)),
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
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => EmployeeChoiceScreen(
                            //               eventoModel: widget.event,
                            //             )));
                          },
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          icon: Icon(Icons.search, size: 16),
                          label: Text("IR PRA TELA DE ESCOLHAS"),
                          color: primaryColor,
                          textColor: colorBg,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        "Você pode gerenciar os funcionários que já foram contratados para esse evento",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(0, 0, 0, 0.7),
                        ),
                      ),
                      if (widget.event.employees.length > 0) ...[
                        Divider(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 2, 0, 4),
                          child: Text(
                            "${widget.event.employees?.length} funcionarios contratados: ",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(0, 0, 0, 0.7)),
                          ),
                        ),
                        SizedBox(height: 24),
                        Align(
                          alignment: Alignment.center,
                          child: RaisedButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, "/employee/management");
                            },
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            icon: Icon(Icons.assignment_ind, size: 16),
                            label: Text("Gerenciador de Funcionarios"),
                            color: secundaryColor,
                            textColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                      ],
                      Divider(),
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
                        Divider(),
                      ],
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Saldo Disponível: ",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                )),
                            Text(
                                'R\$ ${walletData.avaliableBalance.toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 16,
                                  color: Colors.black,
                                )),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Valor Total: ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w700)),
                            Text("R\$ -.--",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w700)),
                          ]),
                      // SizedBox(height: 24),
                      // setButton(
                      //   text: "editar evento",
                      //   uppercase: true,
                      //   icon: Icons.edit,
                      // ),
                      // setButtonText(
                      //     text: "cancelar evento",
                      //     icon: Icons.delete_outline,
                      //     uppercase: true,
                      //     color: Colors.red.shade400)
                    ],
                  ),
                ))));
  }
}
