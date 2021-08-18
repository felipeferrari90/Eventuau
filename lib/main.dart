import 'package:flutter/material.dart';
import './screens/contract_screen.dart';
import './screens/profissional/employee_myevents_screen.dart';
import './screens/profissional/employee_events_choice_screen.dart';
import './screens/profissional/employee_home_screen.dart';
import './screens/profissional/employee_login_screen.dart';
import './screens/contratante/employee_management_screen.dart';
import './screens/contratante/employee_screen_description.dart';
import './screens/profissional/employee_signup.dart';
import './screens/contratante/employees_screen.dart';
import './screens/contratante/event_new_screen.dart';
import './screens/profissional/employee_event_screen_description.dart';
import './screens/contratante/event_screen_description.dart';
import './screens/contratante/home_screen.dart';
import './screens/init_screen.dart';
import './screens/login_screen.dart';
import './screens/contratante/signup_screen.dart';
import './utils/colors.dart';

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
          iconTheme: IconThemeData(size: 48),
          dividerTheme: DividerThemeData(
            color: Colors.black,
            indent: 0,
            endIndent: 0,
            space: 32,
          ),
          buttonTheme: ButtonThemeData(minWidth: 22.0),
          fontFamily: "Roboto",
          textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 24, color: primaryColor, fontWeight: FontWeight.bold),
            headline2: TextStyle(fontSize: 15, color: primaryColor),
            headline3: TextStyle(
                fontSize: 32, color: Colors.black, fontWeight: FontWeight.bold),
            headline4: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.w300,
                height: 1.2),
            headline5: TextStyle(fontSize: 16, color: primaryColor),
            bodyText1: TextStyle(fontSize: 8, color: primaryColor),
            button: TextStyle(fontSize: 16, color: gray),
          ),
          inputDecorationTheme: InputDecorationTheme(
            alignLabelWithHint: false,
            labelStyle: TextStyle(
                color: primaryColor, fontWeight: FontWeight.w300, fontSize: 18),
            contentPadding: EdgeInsets.symmetric(vertical: 10),
          )),
      routes: {
        "/": (context) => InitScreen(),

        /*ROTAS DO FLUXO APP CONTRATANTE*/
        "/login": (context) => LoginScreen(),
        "/signup": (context) => SignUpScreen(),
        "/events": (context) => HomeScreen(),
        "/event/new": (context) => EventNewScreen(),
        "/event/id": (context) => EventScreenDescription(),
        '/employees': (context) => EmployeeChoiceScreen(),
        '/employees/id': (context) => EmployeeScreenDescription(),
        "/employee/management": (context) => EmployeesManagement(),
        "/employee/events": (context) => HomeScreen(),
        "/contract/id": (context) => ContractScreen(),

        /*ROTAS DO FLUXO APP FUNCIONARIO*/
        "/employee/login": (context) => LoginEmployeeScreen(),
        "/employee/new": (context) => SignUpEmployeeScreen(),
        "/employee/home": (context) => HomeScreenEmployee(),
        "/employee/id": (context) => ContractScreen(),
        "/employee/events/choice": (context) => EmployeeEventChoiceScreen(),
        "/employee/event/id": (context) => EmployeeEventScreenDescription(),
      },
    );
  }
}
