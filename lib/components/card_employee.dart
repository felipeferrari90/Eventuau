import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';

class CardEmployee extends StatefulWidget {

  final String name;
  final int idade;
  final double nota;
  final double valor;
  final int horaInicial;
  final int horafinal;

  CardEmployee({Key key, 
    @required this.name, 
    @required this.idade, 
    @required this.nota, 
    @required this.valor, 
    this.horaInicial,
    this.horafinal }) : super(key: key);

  @override
  _CardEmployeeState createState() => _CardEmployeeState();
}

class _CardEmployeeState extends State<CardEmployee> {
  @override
  Widget build(BuildContext context) {
    return Container(
       padding: EdgeInsets.all(8),
       margin: EdgeInsets.all(16),
       width: MediaQuery.of(context).size.width * 0.5,
       height: 100,
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(25.0),
         color: white
       ),
    );
  }
}