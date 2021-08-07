
import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';

class HistoryChatScreen extends StatefulWidget {
  const HistoryChatScreen({ Key key }) : super(key: key);

  @override
  _HistoryChatScreenState createState() => _HistoryChatScreenState();
}

class _HistoryChatScreenState extends State<HistoryChatScreen> {
  @override
  Widget build(BuildContext context) {
       return Container(
         padding: EdgeInsets.symmetric(vertical:16),
         color: colorBg,
         child: Container(  
             child: SingleChildScrollView(
               child: Column(
                 children: [
                    setCardChat(context),
                    setCardChat(context),
                    setCardChat(context),
                    setCardChat(context),
                    setCardChat(context),
                    setCardChat(context),
                    setCardChat(context),
                 ],
               ),
             ),
         )
       ); 
  }

      
}


setCardChat(BuildContext context, {Function f}) =>
InkWell(
  child: Card(
    child:ListTile(
      title: Text("Pedro Lemes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
      leading: Icon(Icons.chat_bubble_outline, size: 32 , color: primaryColor,),
      trailing: CircleAvatar(
        backgroundColor: primaryColor,
        radius: 15,
        child: Text("2"),
        )
      ), 
  )
);
  