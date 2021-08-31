import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/components/buttons.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';

class LoginEmployeeScreen extends StatefulWidget {
  const LoginEmployeeScreen({ Key? key }) : super(key: key);

  @override
  _LoginEmployeeScreenState createState() => _LoginEmployeeScreenState();
}

class _LoginEmployeeScreenState extends State<LoginEmployeeScreen> {

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: setAppBar(context, title: "SEJA UM PROFISSIONAL"),
          backgroundColor: colorBg,
          body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[       
              Image.asset("assets/images/barbecue.png"), 
              Padding(
                padding: EdgeInsets.only(left: 8 , bottom: 1),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(                      
                    alignLabelWithHint: false, 
                    isDense: true,
                    labelText: "E-mail de cadastro",
                    labelStyle: TextStyle(
                       color: primaryColor,
                       fontWeight: FontWeight.w300
                    ), 
                    hintText: "Ex: seunome@gmail.com",
                    hintStyle: TextStyle(
                       color: Color.fromRGBO(0, 0, 0, 0.3),
                       fontSize: 24
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 10),  
                               
                  ),
                ),
              ),        
              Padding(
                padding: EdgeInsets.only(left: 8 , bottom: 1),
                child: TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(                      
                    alignLabelWithHint: false, 
                    isDense: true,
                    labelText: "Senha",
                    labelStyle: TextStyle(
                       color: primaryColor,
                       fontWeight: FontWeight.w300
                    ), 
                    hintText: "Ex: Felipe123",
                    hintStyle: TextStyle(
                       color: Color.fromRGBO(0, 0, 0, 0.3),
                       fontSize: 24
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 10),            
                  ),
                ),
              ),
              setButton(text: "entrar", 
                uppercase: true,
                function: (){
                   Navigator.pushNamed(context, "/employee/events");
                }
              ),
              setButton(text: "esqueci minha senha", 
                outline: true,
                uppercase: true,
                function: (){}
              ),
              setButtonText(
                text:"criar conta",  
                color: accentPink,
                underline: true,
                function: (){
                  Navigator.pushNamed(context, "/employee/home");
                } 
              )             
            ]
          ),
        ),
      )
    );
  } 
}