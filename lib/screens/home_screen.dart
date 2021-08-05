import 'package:event_uau/components/buttons.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[   
            Spacer(),       
            Image.asset("assets/images/imagescreenlogin.png"),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric( vertical: 16),
              child: Text("lorem ipsum".toUpperCase(),
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center
              ),
            ), 
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text("Descricao em uma frase sobre o app",
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,                         
              ),
            ),
            Spacer(),        
            setButton(text: "Entrar",
              function: (){
                Navigator.pushNamed(context, "/login");
              }
            ),
            setButton(text: "Criar conta",
              outline: true,
               function: (){
                Navigator.pushNamed(context, "/signup");
              }
            ),
            setButtonText(
              text: "seja um proffisional", 
              underline: true, 
              uppercase: true, 
              color: accentPink,
              function: () {
                Navigator.pushNamed(context, "/employee/login");
              }
            ),
            Spacer(),
          ]
        ),
      )
    ); 
  }
}