import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';

Widget setButton(
        {String text,
        Function function,
        bool outline = false,
        bool uppercase = false,
        IconData icon,
        EdgeInsets margin}) =>
    Container(
        margin: margin ?? EdgeInsets.only(top: 20.0),
        width: double.infinity,
        child: RaisedButton(
            onPressed: function ?? () {},
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: outline
                  ? BorderSide(width: 1, color: primaryColor)
                  : BorderSide.none,
            ),
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon != null
                        ? Icon(
                            icon,
                            size: 16,
                            color: outline ? primaryColor : colorBg,
                          )
                        : Text(""),
                    SizedBox(
                      width: icon != null ? 4 : 0,
                    ),
                    Text(uppercase ? text.toUpperCase() : text,
                        style: TextStyle(
                          color: outline ? primaryColor : gray,
                          fontSize: 16,
                        )),
                  ],
                )),
            color: outline ? colorBg : primaryColor));

Widget setButtonText(
        {String text,
        Function function,
        bool underline = false,
        bool uppercase = false,
        Color color,
        IconData icon}) =>
    FlatButton(
      onPressed: function ?? () {},
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null
                  ? Icon(
                      icon,
                      color: color,
                      size: 16,
                    )
                  : Text(""),
              SizedBox(
                width: icon != null ? 4 : 0,
              ),
              Text(uppercase ? text.toUpperCase() : text,
                  style: TextStyle(
                    decoration: underline
                        ? TextDecoration.underline
                        : TextDecoration.none,
                    fontSize: 16,
                    color: color,
                  )),
            ],
          )),
    );
