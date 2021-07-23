import 'package:event_uau/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

setInputForm(BuildContext context,
             {String labeltext, 
             TextInputType keyboardType = TextInputType.name,
             }) =>
  Padding(
    padding: EdgeInsets.only(left: 8 , bottom: 1),
      child: TextFormField(
        obscureText: keyboardType == TextInputType.visiblePassword ? true : false  ,
        keyboardType: keyboardType ,
        decoration: InputDecoration(                      
        alignLabelWithHint: false, 
        isDense: true,
        labelText: labeltext?? "",
        labelStyle: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.w300
        ), 
        contentPadding: EdgeInsets.symmetric(vertical: 10),                         
        ),
      ),
  );        
    