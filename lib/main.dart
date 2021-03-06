import 'dart:io';
import 'package:event_uau/providers/event.dart';
import 'package:event_uau/screens/profissional/wallet/add_credit.card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './providers/employee_events.dart';
import 'providers/employee_wallet_data.dart';

import './screens/contract_screen.dart';
import './screens/contratante/signup_success.dart';
import './screens/event_detail_screen.dart';
import './screens/profissional/employee_home_screen.dart';
import './screens/contratante/employee_management_screen.dart';
import './screens/contratante/employee_screen_description.dart';
import 'screens/profissional/employee_signup/employee_signup.dart';
import './screens/contratante/employees_screen.dart';
import './screens/contratante/event_new_screen.dart';
import './screens/contratante/event_screen_description.dart';
import './screens/contratante/home_screen.dart';
import './screens/init_screen.dart';
import './screens/contratante/signup_screen.dart';
import './screens/profissional/employee_signup/employee_add_documents.dart';
import './screens/profissional/employee_signup/employee_application_success.dart';
import './screens/profissional/employee_signup/employee_application_pending.dart';
import './screens/profissional/wallet/add_bank_screen.dart';
import './screens/profissional/wallet/employee_wallet.dart';
import './screens/profile_screen.dart';
import './utils/colors.dart';

import 'package:intl/date_symbol_data_local.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  initializeDateFormatting('pt_BR', null);
  runApp(EventUau());
}

class EventUau extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProxyProvider<Auth, EmployeeEvents>(
          create: (_) => EmployeeEvents(null),
          update: (context, value, previous) {
            return EmployeeEvents(value.token);
          },
        ),
        ChangeNotifierProxyProvider<Auth, EmployeeWalletData>(
          create: (_) => EmployeeWalletData(null),
          update: (context, value, previous) {
            return EmployeeWalletData(value.token);
          },
        ),
        ChangeNotifierProvider(create: (context) => Event())
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'EventUAU',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            progressIndicatorTheme: ProgressIndicatorThemeData(
              color: secundaryColor,
            ),
            appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              shadowColor: Colors.transparent,
              elevation: 0,
              color: Theme.of(context).scaffoldBackgroundColor,
              iconTheme: IconThemeData(color: primaryColor, size: 16),
            ),
            dividerColor: primaryColor,
            primaryColor: primaryColor,
            accentColor: secundaryColor,
            secondaryHeaderColor: secundaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            iconTheme: IconThemeData(size: 48),
            dividerTheme: DividerThemeData(
              color: Colors.black,
              indent: 0,
              endIndent: 0,
              space: 32,
            ),
            buttonTheme: Theme.of(context).buttonTheme.copyWith(
                buttonColor: primaryColor,
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
            fontFamily: "Roboto",
            primaryTextTheme: Theme.of(context).primaryTextTheme.copyWith(
                  headline6: TextStyle(
                      fontSize: 18,
                      color: primaryColor,
                      fontWeight: FontWeight.bold),
                ),
            textTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 24,
                  color: primaryColor,
                  fontWeight: FontWeight.bold),
              headline2: TextStyle(fontSize: 15, color: primaryColor),
              headline3: TextStyle(
                  fontSize: 32,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              headline4: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  height: 1.2),
              headline5: TextStyle(fontSize: 16, color: primaryColor),
              bodyText1: TextStyle(fontSize: 8, color: primaryColor),
              button: TextStyle(fontSize: 16, color: Colors.white),
            ),
            inputDecorationTheme: InputDecorationTheme(
              isDense: true,
              alignLabelWithHint: false,
              labelStyle: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 18),
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
          home: auth.isAuth ? HomeScreen() : InitScreen(),
          routes: auth.isAuth
              ? {
                  /*ROTAS DO FLUXO APP CONTRATANTE*/
                  SignUpScreen.routeName: (context) => SignUpScreen(),
                  HomeScreen.routeName: (context) => HomeScreen(),
                  SignupSuccess.routeName: (context) => SignupSuccess(),
                  "/event/new": (context) => EventNewScreen(),
                  '/employees/id': (context) => EmployeeScreenDescription(),
                  "/employee/management": (context) => EmployeesManagement(),
                  "/employee/events": (context) => HomeScreen(),
                  "/contract/id": (context) => ContractScreen(),
                  AddCreditCard.routeName: (context) => AddCreditCard(),
                  EmployeeChoiceScreen.routeName: (context) =>
                      EmployeeChoiceScreen(),

                  /*ROTAS DO FLUXO APP FUNCIONARIO*/
                  EmployeeSignupScreen.routeName: (context) =>
                      EmployeeSignupScreen(),
                  EmployeeAddDocuments.routeName: (context) =>
                      EmployeeAddDocuments(),
                  EmployeeApplicationPending.routeName: (context) =>
                      EmployeeApplicationPending(),
                  EmployeeApplicationSuccess.routeName: (context) =>
                      EmployeeApplicationSuccess(),
                  ProfileScreen.routeName: (context) => ProfileScreen(),
                  EmployeeHomeScreen.routeName: (context) =>
                      EmployeeHomeScreen(),
                  EventDetailScreen.routeName: (context) => EventDetailScreen(),
                  "/employee/id": (context) => ContractScreen(),
                  EmployeeWallet.routeName: (context) => EmployeeWallet(),
                  AddBankScreen.routeName: (context) => AddBankScreen(),
                }
              : {
                  SignUpScreen.routeName: (context) => SignUpScreen(),
                  SignupSuccess.routeName: (context) => SignupSuccess(),
                },
          onUnknownRoute: (route) => MaterialPageRoute(
              builder: (ctx) => auth.isAuth ? HomeScreen() : InitScreen()),
          onGenerateRoute: auth.isAuth
              ? null
              : (_) => MaterialPageRoute(builder: (ctx) => InitScreen()),
        ),
      ),
    );
  }
}

// DEVELOPMENT CERTIFICATE WORKAROUND DO NOT COMMIT THIS TO PRODUCTION
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
