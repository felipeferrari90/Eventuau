

import 'package:flutter/material.dart';



 
Widget setButtonJobTypeSelection(context, {IconData icon, String title, String link, bool isSelected = false, Function functionOnTap }) => 
  GestureDetector(
        child:Container(
          decoration: BoxDecoration(
            border: isSelected ? Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 2.0, 
              )
            ): null,
          ),
          child: Column(
            children: <Widget>[
              isSelected ? Icon(icon) : Icon(icon, color: Color.fromRGBO(0, 0, 0, 0.5) ),
              Padding(padding: EdgeInsets.symmetric( vertical: 16),
                child: Text( title, 
                  style: isSelected ? Theme.of(context).textTheme.headline2 : TextStyle( fontSize: 15 , color: Color.fromRGBO(0, 0, 0, 0.5)),
                ),
              )    
            ],
          ),
        ),
        onTap: functionOnTap?? (){} ,   
  );

    