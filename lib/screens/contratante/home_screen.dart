import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/providers/auth.dart';
import 'package:event_uau/providers/employee_wallet_data.dart';
import 'package:event_uau/screens/history_chat_screen.dart';
import 'package:event_uau/screens/notifications_screen.dart';
import 'package:event_uau/screens/profissional/wallet/employee_wallet.dart';
import 'package:event_uau/screens/wallet_screen.dart';

import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard_events_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  static const routeName = "/events";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    Provider.of<EmployeeWalletData>(context, listen: false).getWalletData();
    super.initState();
  }

  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  List _screens = [
    DashBoardScreenEvents(),
    EmployeeWallet(),
    HistoryChatScreen(),
    NotificationScreen(),
  ];

  List<String> _titles = [
    'Meus Eventos',
    'Carteira',
    'Conversas',
    'Notificacões'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 1
          ? null
          : EventUauAppBar(title: _titles[_currentIndex]),
      backgroundColor: colorBg,
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
            icon: Icon(Icons.calendar_today),
            label: "Eventos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: "Carteira",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.chat_bubble_outline),
          //   label: "Conversas",
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.notifications),
          //   label: "Notificacoes",
          // ),
        ],
        onTap: _updateIndex,
      ),
    );
  }
}
