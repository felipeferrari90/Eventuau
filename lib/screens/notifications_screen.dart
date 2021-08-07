import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({ Key key }) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(  
             child: SingleChildScrollView(
               child: Column(
                 children: [
                    setCardNotification(context),
                    setCardNotification(context),
                    setCardNotification(context),
                    setCardNotification(context),
                    setCardNotification(context),
                    setCardNotification(context),
                 ],
               ),
             ),
         
       );
      
  }

      
}


setCardNotification(BuildContext context, {Function f}) =>
InkWell(
  child: Card(
    child:ListTile(
      title: Text("você acaba de ter sua presença confirmada no evento churrasco em brasilandia - inicio hoje as 23:00 com termino as 4 horas do dia seguinte", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      leading: Icon(Icons.calendar_today, size: 32 , color: primaryColor,),
    )
  )
);
  