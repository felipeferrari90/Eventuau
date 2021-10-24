import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../components/employee/event_card.dart';
import '../../providers/employee_events.dart';
import '../../providers/auth.dart';

import 'wallet/employee_wallet.dart';

import '../profile_screen.dart';

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({Key key}) : super(key: key);

  static const routeName = '/employee/home';
  @override
  _EmployeeHomeScreenState createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
  List<String> _tabs = ['Em aberto', 'Finalizados'];
  Future<void> _fetchDataRef;

  @override
  void initState() {
    print('initstate');
    _fetchDataRef = Provider.of<EmployeeEvents>(context, listen: false)
        .fetchEmployeeEvents();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant EmployeeHomeScreen oldWidget) {        
      _fetchDataRef = Provider.of<EmployeeEvents>(context, listen: false)
          .fetchEmployeeEvents();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final _events = Provider.of<EmployeeEvents>(context).events;
    final userInitials = Provider.of<Auth>(context).user.initials;
    return DefaultTabController(      
      initialIndex: 0,
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("/");
              },
              child: Text(
                'Sair da Área do Parceiro',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            PopupMenuButton(
              onSelected: (value) {
                if (value == '/') {
                  Provider.of<Auth>(context, listen: false).signout();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                } else
                  Navigator.pushNamed(context, value as String);
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text('Meu Perfil'),
                  value: ProfileScreen.routeName,
                ),
                PopupMenuItem(
                  child: Text('Minha carteira'),
                  value: EmployeeWallet.routeName,
                ),                
                PopupMenuItem(
                  child: Text('Sair'),
                  value: '/',
                ),
              ],
              icon: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                child: Text(
                  userInitials,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
          ],
          title: Text(
            'Meus Eventos',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(

              isScrollable: false,
              labelColor: Theme.of(context).primaryColor,
              
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              tabs:
                  _tabs.map((e) => TabWithUnreadIndicator(label: e)).toList()),
        ),
        body: FutureBuilder(
            future: _fetchDataRef,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return TabBarView(
                  children: _tabs
                      .map(
                        (_) => RefreshIndicator(
                          color: Theme.of(context).accentColor,
                          onRefresh: Provider.of<EmployeeEvents>(context,
                                  listen: false)
                              .fetchEmployeeEvents,
                          child: _events.length <= 0
                              ? ListView(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(20.0),
                                  children: [
                                    Center(
                                      child: Text(
                                        'Nenhum evento aqui ainda.',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        'Arraste para baixo para atualizar',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    )
                                  ],
                                )
                              : ListView.builder(
                                  itemBuilder: (context, index) =>
                                      EventCard(id: _events[index].id),
                                  itemCount: _events.length,
                                ),
                        ),
                      )
                      .toList());
            }),
      ),
    );
  }
}

class TabWithUnreadIndicator extends StatelessWidget {
  const TabWithUnreadIndicator(
      {Key key, @required this.label, this.amountUnread})
      : super(key: key);

  final String label;
  final int amountUnread;

  @override
  Widget build(BuildContext context) {
    return Tab(

      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(label),
        if (amountUnread != null)
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            padding: EdgeInsets.all(6),
            margin: EdgeInsets.only(left: 6),
            child: Text(
              amountUnread.toString(),
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          )
      ]),
    );
  }
}
