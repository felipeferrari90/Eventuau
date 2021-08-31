import 'package:event_uau/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

setInputForm(
  BuildContext context, {
  String labeltext,
  TextInputType keyboardType = TextInputType.name,
  String Function(String) validator,
  void Function(String) onSaved,
  List<TextInputFormatter> mascaras,
}) =>
    Padding(
      padding: EdgeInsets.only(left: 8, bottom: 1),
      child: TextFormField(
        inputFormatters: mascaras,
        obscureText:
            keyboardType == TextInputType.visiblePassword ? true : false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          alignLabelWithHint: false,
          isDense: true,
          labelText: labeltext ?? "",
          labelStyle:
              TextStyle(color: primaryColor, fontWeight: FontWeight.w300),
          contentPadding: EdgeInsets.symmetric(vertical: 10),
        ),
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return "digite alguma informação";
              }
            },
        onSaved: onSaved,
      ),
    );
