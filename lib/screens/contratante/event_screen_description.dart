import 'package:enum_to_string/enum_to_string.dart';
import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/components/buttons.dart';
import 'package:event_uau/models/evento_model.dart';
import 'package:event_uau/providers/auth.dart';
import 'package:event_uau/service/evento_service.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:event_uau/utils/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventScreenDescription extends StatefulWidget {
  const EventScreenDescription({Key key, this.event}) : super(key: key);

  final EventoModel event;

  _EventScreenDescriptionState createState() => _EventScreenDescriptionState();
}

class _EventScreenDescriptionState extends State<EventScreenDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: EventUauAppBar(
          username: Provider.of<Auth>(context).user.name,
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
                      SizedBox(height: 200),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 2),
                        child: Text("${widget.event.nome}",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                        child: Text(
                            "${DateFormat.yMMMMd('pt_BR').format(widget.event.dataEHorarioInicio) ?? "Sem data e horario marcados"} - ${DateFormat.Hm('pt_BR').format(widget.event.dataEHorarioTermino) ?? ""}",
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
                            child: Text("Duração Minima: ",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: primaryColor)),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 2, 0, 4),
                            child: Text("${widget.event.duracaoMinima} Horas",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Color.fromRGBO(0, 0, 0, 0.7))),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 2, 4),
                            child: Text("Endereco: ",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: primaryColor)),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 2, 0, 4),
                            child: Text(
                                "${widget.event.endereco.toString() ?? "Sem endereco"}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Color.fromRGBO(0, 0, 0, 0.7))),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 2, 4),
                            child: Text("status evento: ",
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
                      SizedBox(
                        height: 24,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: RaisedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, "/employees");
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
                      Divider(),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: Text("sobre o evento",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                        child: Text("${widget.event.descricao}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Color.fromRGBO(0, 0, 0, 0.7))),
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 2, 0, 4),
                        child: Text(
                          "${widget.event.funcionarios.length} funcionarios contratados: ",
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          icon: Icon(Icons.assignment_ind, size: 16),
                          label: Text("Gerenciador de Funcionarios"),
                          color: secundaryColor,
                          textColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: Text("observacoes",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                        child: Text("${widget.event.observacoes}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Color.fromRGBO(0, 0, 0, 0.7))),
                      ),
                      Divider(),
                      SizedBox(height: 24),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("saldo disponivel: ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700)),
                              Text("R\$ 420,00",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700)),
                            ]),
                      ),
                      SizedBox(height: 24),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("VALOR TOTAL: ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w700)),
                              Text("R\$ 350,00",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w700)),
                            ]),
                      ),
                      SizedBox(height: 24),
                      setButton(
                        text: "editar evento",
                        uppercase: true,
                        icon: Icons.edit,
                      ),
                      setButtonText(
                          text: "cancelar evento",
                          icon: Icons.delete_outline,
                          uppercase: true,
                          color: Colors.red.shade400)
                    ],
                  ),
                ))));
  }
}
