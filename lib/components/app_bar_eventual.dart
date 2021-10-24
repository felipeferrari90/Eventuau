import 'package:event_uau/providers/auth.dart';
import 'package:event_uau/screens/profissional/employee_home_screen.dart';
import 'package:event_uau/screens/profissional/employee_signup/employee_signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/colors.dart';

class EventUauAppBar extends StatefulWidget with PreferredSizeWidget {
  const EventUauAppBar({Key key, this.title}) : super(key: key);

  final String title;  

  @override
  _EventUauAppBarState createState() => _EventUauAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _EventUauAppBarState extends State<EventUauAppBar> {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<Auth>(context).user;
    return AppBar(
      title: Text(
        widget.title ?? "",
      ),            
      elevation: 0,
      actions: <Widget>[        
         TextButton(
          onPressed: () => !user.isPartner
                    ? Navigator.of(context)
                        .pushNamed(EmployeeSignupScreen.routeName)
                    : Navigator.of(context)
                        .pushReplacementNamed(EmployeeHomeScreen.routeName),
                child: Text(
                  !user.isPartner ? 'Seja um Parceiro!' : 'Área do Parceiro',
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
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            } else
              Navigator.pushNamed(context, value as String);
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text('Sair'),
              value: '/',
            ),
          ],
          icon: CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            child: Text(
                  user.initials,
              style: TextStyle(color: Colors.black),
            ),
              ),
            )
      ],
      iconTheme: IconThemeData(color: primaryColor, size: 16),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
