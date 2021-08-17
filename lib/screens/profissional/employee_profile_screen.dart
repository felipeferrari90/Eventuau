import 'package:event_uau/components/input_form_eventual.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmployeeProfileScreen extends StatefulWidget {
  const EmployeeProfileScreen({ Key key }) : super(key: key);

  @override
  _EmployeeProfileScreenState createState() => _EmployeeProfileScreenState();
}

class _EmployeeProfileScreenState extends State<EmployeeProfileScreen> {

  bool _invisivel = false;

  @override
  Widget build(BuildContext context) {
    return Container(
       padding: EdgeInsets.all(16),
       child: SingleChildScrollView(
         child: Column(
           children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                child: Text("escolha suas preferencias de trabalho", style: TextStyle( fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black)),
              ),
              SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                child: Text("elas serão exibidas para as eventos que podem te contratada, voce pode edita-las aqui quando quiser", style: TextStyle( fontSize: 16, fontWeight: FontWeight.w300, color: Color.fromRGBO(0, 0, 0, 0.7))),
              ),   
              SizedBox(height: 24),
              setInputForm(context, labeltext: "valor cobrado a hora: " , keyboardType: TextInputType.number ),
              SwitchListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text("ficar invisivel"),
                value: _invisivel,
                activeColor: primaryColor,
                inactiveTrackColor: colorBg,
                onChanged: (bool value){
                  setState(() {
                    _invisivel = value;
                  });
                },
              ), 
              SizedBox(height: 24),
           ],)
       ),
    );
  }
}