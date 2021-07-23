import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/components/buttons.dart';
import 'package:event_uau/components/input_form_eventual.dart';
import 'package:flutter/material.dart';

class EventNewScreen extends StatefulWidget {
  
  const EventNewScreen({ Key
   key }) : super(key: key);

  @override
  _EventNewScreenState createState() => _EventNewScreenState();
}

class _EventNewScreenState extends State<EventNewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar(context, title: "Criar Evento", username: "Antonio conceicao"),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              setInputForm(context, labeltext: "Nome do evento:" ),
              setInputForm(context, labeltext: "Data do evento:", keyboardType: TextInputType.datetime),
              setInputForm(context, labeltext: "Hora do evento:", keyboardType: TextInputType.number),
              setInputForm(context, labeltext: "Duração",  keyboardType: TextInputType.number ),
              setButton(text: "Publicar evento", uppercase: true, 
                function: (){
                  Navigator.pushNamed(context,"/events");
                }),
            ]   
          )
        ),
      ),
    );

 
  }
}