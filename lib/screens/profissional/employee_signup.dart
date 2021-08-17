import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/components/buttons.dart';
import 'package:event_uau/components/input_form_eventual.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';

class SignUpEmployeeScreen extends StatefulWidget {
  const SignUpEmployeeScreen({ Key key }) : super(key: key);

  @override
  _SignUpEmployeeScreenState createState() => _SignUpEmployeeScreenState();
}

class _SignUpEmployeeScreenState extends State<SignUpEmployeeScreen> {

  int _valueDropdownTypeEmployee = 0;
  bool _invisivel = false;

  @override
   Widget build(BuildContext context) {
      return Scaffold(
        appBar: setAppBar(context,title: "Cadastre-se"),
        backgroundColor: colorBg,
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                setInputForm(context, labeltext: "nome completo"),
                setInputForm(context, labeltext: "escolha uma senha", keyboardType: TextInputType.visiblePassword ),
                setInputForm(context, labeltext: "e-mail", keyboardType: TextInputType.emailAddress ),
                setInputForm(context, labeltext: "Rg", keyboardType: TextInputType.number ),
                setInputForm(context, labeltext: "CPF", keyboardType: TextInputType.number ),
                setInputForm(context, labeltext: "telefone de contato", keyboardType: TextInputType.phone ),
                setInputForm(context, labeltext: "data de nascimento", keyboardType: TextInputType.datetime ),
                setInputForm(context, labeltext: "endereco", keyboardType: TextInputType.datetime ),
          
                ListTile(
                  leading: Text("escolha seu serviço: ", style: TextStyle(fontSize: 16),),
                  title: DropdownButton(   
                    value:  _valueDropdownTypeEmployee,
                    dropdownColor: Color.fromRGBO(255, 255, 255, 1.0),
                    style: TextStyle(fontSize: 12 , color: primaryColor, fontWeight: FontWeight.w700),
                    focusColor: primaryColor,
                    itemHeight: 50,
                    items: [
                      DropdownMenuItem(
                        child: Text("GARÇOM" , style: TextStyle(fontSize: 12),),
                        value: 0,  
                      ),
                      DropdownMenuItem(
                        child: Text("ANIMADOR", style: TextStyle(fontSize: 12),),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text("BUFFET", style: TextStyle(fontSize: 12),),
                        value: 2,
                      ),
                      DropdownMenuItem(
                        child: Text("CHURRASCO", style: TextStyle(fontSize: 12),),
                        value: 3,
                      ),
                    ],
                    
                    onChanged: (int value){
                      setState(() {
                        _valueDropdownTypeEmployee = value;
                      });
                    }
                  ), 
                ),
               
                SizedBox( height: 24),
                setButton(text: "Cadastrar",
                function: (){
                   Navigator.pushNamed(context, '/employee/home');
                })
              ]
            )
          ),
      )
    );
  }
}