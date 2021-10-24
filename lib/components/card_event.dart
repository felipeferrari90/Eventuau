import 'package:enum_to_string/enum_to_string.dart';
import 'package:event_uau/models/evento_model.dart';
import 'package:event_uau/screens/contratante/event_screen_description.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:event_uau/utils/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget setCardEvent(context, {EventoModel eventoModel}) => Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: secundaryColor,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    EventScreenDescription(event: eventoModel)),
          );
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                color: secundaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventoModel.nome ?? "Sem Título",
                    maxLines: 3,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.calendar_today,
                        color: primaryColor,
                        size: 16,
                      ),
                    ),
                    Text(
                        "${DateFormat.yMMMMd('pt_BR').format(eventoModel.dataEHorarioInicio) ?? "Sem data e hora marcados"} - ${DateFormat.Hm('pt_BR').format(eventoModel.dataEHorarioTermino) ?? ""}",
                        style: Theme.of(context).textTheme.headline5)
                  ])
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      color: colorBg,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.info_outline_rounded,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  //inicio da coluna de flexiveis
                  Container(
                    height: MediaQuery.of(context).size.width / 2.5,
                    padding: EdgeInsets.only(left: 12),
                    child: Column(children: [
                      Spacer(flex: 3),
                      Container(
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.hourglass_empty,
                                  size: 24,
                                  color: primaryColor,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "${eventoModel.duracaoMinima ?? 0} Horas",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                )
                              ],
                            ),
                          )),
                      Spacer(flex: 2),
                      Container(
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.assignment_ind,
                                  size: 24,
                                  color: primaryColor,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "${eventoModel.funcionarios.length ?? 0} contratados",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                )
                              ],
                            ),
                          )),
                      Spacer(flex: 2),
                      Container(
                          width: MediaQuery.of(context).size.width / 2.4,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Text(
                                  "status: ",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black54),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "${EnumToString.convertToString(eventoModel.status)}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          )),
                      Spacer(flex: 2),
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        spacing: 24,
                        clipBehavior: Clip.hardEdge,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: colorBg,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                elevation: 8,
                                fixedSize: Size(40, 20),
                              ),
                              child: Icon(Icons.person_add,
                                  color: primaryColor, size: 24),
                              onPressed: () {
                                Navigator.pushNamed(context, "/employees");
                              }),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                primary: colorBg,
                                elevation: 8,
                                fixedSize: Size(40, 20),
                              ),
                              child: Icon(Icons.assignment_ind,
                                  color: primaryColor, size: 24),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, "/employee/management");
                              }),
                        ],
                      ),
                      Spacer(),
                    ]),
                  ),
                  //fim da coluna de flexiveis
                ],
              ),
            ),
            //colocar aqui as coisas do conteudo abaixo do container com foto e icones acima
          ],
        ),
      ),
    );
