import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/models/contratado_model.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:event_uau/utils/icons.dart';
import 'package:flutter/material.dart';

class EmployeeScreenDescription extends StatefulWidget {
  const EmployeeScreenDescription({Key key, this.contratado, this.valorTotal})
      : super(key: key);

  final ContratadoModel contratado;
  final double valorTotal;
  @override
  _EmployeeScreenDescriptionState createState() =>
      _EmployeeScreenDescriptionState();
}

class _EmployeeScreenDescriptionState extends State<EmployeeScreenDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EventUauAppBar(),
      body: Container(
        padding: EdgeInsets.all(16),
        color: colorBg,
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 32),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 200),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Text("${widget.contratado.nome}",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                  child: Text("300+ horas trabalhadas",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: primaryColor)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 2, 0, 4),
                      child: Icon(
                        EventuauIcons2.star,
                        size: 24,
                        color: yellow,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 2, 12, 4),
                      child: Text("3.50/5",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: primaryColor)),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 2, 0, 4),
                      child: Icon(
                        EventuauIcons2.dollar,
                        size: 24,
                        color: yellow,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 2, 12, 4),
                      child: Text("Total: R\$S ${widget.valorTotal ?? 0}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: primaryColor)),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 2, 0, 4),
                      child: Icon(Icons.my_location,
                          size: 24, color: secundaryColor),
                    ),
                  ],
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Text("sobre mim",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                  child: Text(
                      "trabalhei como gar??om tem 4 anos sou formado em engenharia civil, trabalhei na doceria doce lar, tenho experiencia com crian??as ",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 0, 0, 0.7))),
                ),
                Divider(),

                //COLOCAR AQUI DEPOIS PRA VER OUTRAS FOTOS DELE

                Positioned(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: RaisedButton(
                          onPressed: () {},
                          color: primaryColor,
                          padding: EdgeInsets.all(24),
                          shape: CircleBorder(),
                          child: Icon(
                            EventuauIcons2.handshake,
                            color: colorBg,
                            size: 64,
                          ),
                        )),
                    Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: RaisedButton(
                          onPressed: () {},
                          color: pink,
                          padding: EdgeInsets.all(24),
                          shape: CircleBorder(),
                          child: Icon(
                            EventuauIcons2.cancel,
                            color: primaryColor,
                            size: 64,
                          ),
                        )),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
