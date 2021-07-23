import 'package:event_uau/screens/employees_screen.dart';
import 'package:event_uau/screens/event_new_screen.dart';
import 'package:event_uau/screens/events_screen.dart';
import 'package:event_uau/screens/home_screen.dart';
import 'package:event_uau/screens/login_screen.dart';
import 'package:event_uau/screens/signup_screen.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(EventUau());
}

class EventUau extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EventUAU',
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        dividerColor: primaryColor,
        primaryColor: primaryColor,
        accentColor: accentColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        iconTheme: IconThemeData(color: primaryColor, size: 48) ,
        fontFamily: "Roboto",
        textTheme: TextTheme(          
          headline1: TextStyle( fontSize: 24 , color: primaryColor , fontWeight: FontWeight.bold ),
          headline2: TextStyle( fontSize: 15 , color: primaryColor ),
          headline3: TextStyle( fontSize: 32 , color: Colors.black ,fontWeight:  FontWeight.bold ),
          headline4: TextStyle( fontSize: 24 , color: Colors.black , fontWeight: FontWeight.w300, height: 1.2),
          headline5: TextStyle( fontSize: 16 , color: primaryColor),
          bodyText1: TextStyle( fontSize: 8 , color: primaryColor ),   
          button:  TextStyle( fontSize: 16 , color: gray),     
        )
      ),
      routes: {
        "/" : (context) => HomeScreen(),
        "/login" : (context) => LoginScreen(),
        "/signup" : (context) => SignUpScreen(),
        "/events" : (context) => DashBoardEvents(),
        "/event/new" : (context) => EventNewScreen(),
        '/employees' : (context) => EmployeeScreen(),
      },
    );
  }
}

