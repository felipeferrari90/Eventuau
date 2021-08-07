import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/components/buttons.dart';
import 'package:event_uau/components/card_event.dart';
import 'package:event_uau/screens/history_chat_screen.dart';
import 'package:event_uau/screens/notifications_screen.dart';
import 'package:event_uau/screens/wallet_screen.dart';

import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';

import 'dashboard_events_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;
  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
    });
  }
  
  List _screens = [ DashBoardScreenEvents(), WalletScreen(), HistoryChatScreen(), NotificationScreen(),];

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: setAppBar(context, username: "Felipe Ferreira Marques" ),
        backgroundColor: colorBg,
        drawer: Drawer(     
        ),
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex ,
          backgroundColor: secundaryColor,
          selectedLabelStyle: TextStyle(fontSize: 12 , color: primaryColor),
          unselectedItemColor: Colors.black26,
          unselectedFontSize: 12,
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          iconSize: 24,
          elevation: 12,
          selectedItemColor: primaryColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_view_day),
              title: Text("Eventos")
            ),
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


