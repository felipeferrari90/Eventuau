import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/components/card_event_dismissible.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';

class EmployeeEventChoiceScreen extends StatefulWidget {
  const EmployeeEventChoiceScreen({ Key key }) : super(key: key);

  @override
  _EmployeeEventChoiceScreenState createState() => _EmployeeEventChoiceScreenState();
}

class _EmployeeEventChoiceScreenState extends State<EmployeeEventChoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar(context),
      body: Container(
        color: colorBg,
          padding: EdgeInsets.all(16),
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only( bottom: 10),
              child: Text("comece a curtir eventos para ser contratado.",
                style: TextStyle(
                  fontSize: 24,
                  color: primaryColor,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 24),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                child: Text("Deslize o card do evento á direita para curtir ou a esquerda para rejeitar a proposta, ", style: TextStyle( fontSize: 16, fontWeight: FontWeight.w300, color: Color.fromRGBO(0, 0, 0, 0.7))),
            ),   
            SizedBox(height: 24),
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
                          setCardEventDismissible(context), 
                      ]
                    ),
                  ),
                )
              ),
            ],
          ),
        )
    );
  }
}