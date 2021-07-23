import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/components/buttons.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';

class DashBoardEvents extends StatefulWidget {
  const DashBoardEvents({ Key key }) : super(key: key);

  @override
  _DashBoardEventsState createState() => _DashBoardEventsState();
}

class _DashBoardEventsState extends State<DashBoardEvents> {

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
                  Text("histórico", 
                    style: TextStyle(
                      fontSize: 16,
                      color: pink,
                      fontWeight: FontWeight.w500,
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
              Spacer(),
              setButton(text: "Contratar sem criar evento", uppercase: true),
            ],
          ),
        )
      );
    
  }
}