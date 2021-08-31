import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';

Widget setButton({String text = "",  Function()? onPressed, bool outline = false, bool uppercase = false, IconData? icon}) =>
    Container(
      margin: EdgeInsets.only( top: 20.0),
      width: double.infinity,
        child: ElevatedButton(     
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
             onPrimary: outline? colorBg : primaryColor,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(15),
             )
          ),  
          child: Padding(
            padding: EdgeInsets.symmetric( vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 icon != null ? Icon(icon, size: 16, color: outline? primaryColor: colorBg,) : Text(""),
                 SizedBox( width: icon != null ? 4 : 0,),
                 Text(uppercase? text.toUpperCase(): text,
                  style: TextStyle(
                   color: outline? primaryColor: gray,
                  fontSize: 16,
                  )
                ) ,
              ],
            )
        ),
        
      ) 
    );  
 
Widget setButtonText({String text = "", Function()? onPressed, bool underline = false, bool uppercase = false, Color? color, IconData? icon}) =>
  TextButton(
    onPressed: onPressed, 
    child: Padding(
      padding: EdgeInsets.symmetric( vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon != null ? Icon(icon , color: color, size: 16,) : Text(""),
          SizedBox(width: icon != null ? 4: 0,),
          Text(
            uppercase? text.toUpperCase(): text,
            style: TextStyle(
              decoration: underline? TextDecoration.underline : TextDecoration.none,
              fontSize: 16,
              color: color,
            )
          ),
        ],
      )
    ),
);
  

