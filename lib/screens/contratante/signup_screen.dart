import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/components/buttons.dart';
import 'package:event_uau/components/input_form_eventual.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({ Key key }) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool contractChecked = false;
  
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
                setInputForm(context, labeltext: "CPF", keyboardType: TextInputType.number ),
                setInputForm(context, labeltext: "e-mail", keyboardType: TextInputType.emailAddress ),
                setInputForm(context, labeltext: "telefone de contato", keyboardType: TextInputType.phone ),
                setInputForm(context, labeltext: "data de nascimento", keyboardType: TextInputType.datetime ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32), 
                  child: Row(
                    children: [
                      Checkbox(
                        value: contractChecked, 
                        checkColor: colorBg,
                        activeColor: primaryColor,          
                        onChanged: (bool value) {
                          setState(() {
                            contractChecked = value;
                          }); 
                        } 
                      ), 
                      Text("Eu concordo com os termos de uso e\npoliticas de privacidade da Eventual",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w300,
                          fontSize: 16
                        ),  
                      ) 
                    ],
                  ),   
                ),             
                setButton(text: "Cadastrar",
                function: (){
                   Navigator.pushNamed(context, '/employees');
                })
              ]
            )
          ),
      )
    ); 
  }
}