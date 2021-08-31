

import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/components/buttons.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContractScreen extends StatefulWidget {

  final bool professional;
  const ContractScreen({ Key? key , this.professional = false}) : super(key: key);

  
  @override
  _ContractScreenState createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: setAppBar(context, title: "Pedro Lemes",username:"Felipe Ferreira"),
       body: Container(
         padding: EdgeInsets.all(16),
         color: colorBg,
         child: SingleChildScrollView(
           child: Column(
            mainAxisAlignment:  MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height : 10),
              Text("Nome: Pedro Lemes", style: TextStyle(fontSize: 16, color: Colors.black54),),
              SizedBox(height : 16),
              Text("Status: Á Espera do evento", style: TextStyle(fontSize: 16, color: Colors.black54), ),
              SizedBox(height : 16),
              Text("Hora de Chegada: - ", style: TextStyle(fontSize: 16, color: Colors.black54),),
              SizedBox(height : 16),
              Text("Hora de Saida: - ", style: TextStyle(fontSize: 16, color: Colors.black54),),
              SizedBox(height : 16),
              Text("Tempo Excedente : 1:20 ", style: TextStyle(fontSize: 16, color: Colors.black54),),
              SizedBox(height : 16),
              Text("Avaliação: - ", style: TextStyle(fontSize: 16, color: Colors.black54),),
              SizedBox(height : 16),
              Divider(),
              Text("Valor total á ser pago:  430,00 ", style: TextStyle(fontSize: 16, color: Colors.black54),),
              SizedBox(height : 32),
              Center(
                child: RaisedButton.icon(
                  onPressed: (){}, 
                  elevation: 0,
                  icon: Icon(Icons.chat_bubble_outline, size:  16,), 
                  label: Text('abrir chat', textAlign: TextAlign.center),
                  textColor: primaryColor,
                  color: colorBg, 
                ),
              ),
              widget.professional?
              setButton(text: "Demitir funcionario") : SizedBox(height: 24),
            ],
           )
         )
       ),
    );
  }
}