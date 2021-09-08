import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/screens/profissional/employee_myevents_screen.dart';
import 'package:event_uau/screens/profissional/employee_events_choice_screen.dart';
import 'package:event_uau/screens/notifications_screen.dart';
import 'package:event_uau/screens/profissional/employee_profile_screen.dart';
import 'package:event_uau/screens/wallet_screen.dart';

import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';

import '../history_chat_screen.dart';

class HomeScreenEmployee extends StatefulWidget {
  const HomeScreenEmployee({Key key}) : super(key: key);

  static const routeName = "/employee/home";

  @override
  _HomeScreenEmployeeState createState() => _HomeScreenEmployeeState();
}

class _HomeScreenEmployeeState extends State<HomeScreenEmployee> {
  int _currentIndex = 0;
  List _screens = [
    EmployeeProfileScreen(),
    EmployeeEventScreen(),
    WalletScreen(),
    HistoryChatScreen(),
    NotificationScreen()
  ];

  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EventUauAppBar(username: "Felipe Ferreira Marques"),
      backgroundColor: colorBg,
      drawer: Drawer(),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: secundaryColor,
        selectedLabelStyle: TextStyle(fontSize: 12, color: primaryColor),
        unselectedItemColor: Colors.black26,
        unselectedFontSize: 12,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        iconSize: 24,
        elevation: 12,
        selectedItemColor: primaryColor,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text("Valores")),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), title: Text("Eventos")),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            title: Text(" Carteira"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            title: Text("Conversas"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text("Notificacoes"),
          ),
        ],
        onTap: _updateIndex,
      ),
    );
  }
}
