import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';

Widget setButton({String text, Function function, bool outline = false, bool uppercase = false}) =>
    Container(
      margin: EdgeInsets.only( top: 20.0),
      width: double.infinity,
        child: RaisedButton(      
          onPressed: function?? (){},
          elevation: 0, 
          shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(15.0),
             side: outline? BorderSide(
               width: 1,
               color: primaryColor
             ) : BorderSide.none,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric( vertical: 16.0),
            child: Text(uppercase? text.toUpperCase(): text,
              style: TextStyle(
              color: outline? primaryColor: gray,
              fontSize: 16,
              )
            ) ,
          ),
          color: outline? colorBg : primaryColor
      ) 
    );  
 
Widget setButtonText({String text, Function function, bool underline = false, bool uppercase = false, Color color}) =>
  FlatButton(
    onPressed: function?? (){}, 
    child: Padding(
    padding: EdgeInsets.symmetric( vertical: 20.0),
    child: Text(
      uppercase? text.toUpperCase(): text,
      style: TextStyle(
        decoration: underline? TextDecoration.underline : TextDecoration.none,
          fontSize: 16,
          color: color,
      )
    ),
  ),
);
  

