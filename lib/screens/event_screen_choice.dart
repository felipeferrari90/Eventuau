import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/components/buttons.dart';
import 'package:event_uau/components/card_event_dismissible.dart';

import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';

class EventScreenChoice extends StatefulWidget {
  const EventScreenChoice({ Key key }) : super(key: key);

  @override
  _EventScreenChoiceState createState() => _EventScreenChoiceState();

}

class _EventScreenChoiceState extends State<EventScreenChoice> {

     @override
     Widget build(BuildContext context) {
      return Scaffold(
        appBar: setAppBar(context, username: "Felipe Ferreira Marques" ),
        backgroundColor: colorBg,
        drawer: Drawer(     
        ),
        body: Container(
          padding: EdgeInsets.all(16),
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only( bottom: 10),
              child: Text("MEUS EVENTOS",
                style: TextStyle(
                  fontSize: 24,
                  color: primaryColor,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Icon(Icons.history, 
                      size: 32,
                      color: pink,
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    color: primaryColor,
                    textColor: colorBg,                  
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),            
                    child: Padding(
                      padding:  EdgeInsets.symmetric( horizontal: 12 , vertical: 10),
                      child: Text("Criar Evento"),
                    ) 
                  ) 
                ],
              ),
              Container(
                child: Expanded(
                  child:  SingleChildScrollView(
                    child: Column(
                      children:[
                          setCardEventDismissible(context),
                          setCardEventDismissible(context),
                          setCardEventDismissible(context),
                          setCardEventDismissible(context),
                          setCardEventDismissible(context),
                          setCardEventDismissible(context),
                          setCardEventDismissible(context),
                          setCardEventDismissible(context),
                          setCardEventDismissible(context),
                          setCardEventDismissible(context),
                          setCardEventDismissible(context),
                      ]
                    ),
                  ),
                )
              ),
              setButton(text: "Contratar sem criar evento", uppercase: true),
            ],
          ),
        )
      );
  }
}