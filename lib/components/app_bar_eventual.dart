import 'package:event_uau/providers/auth.dart';
import 'package:event_uau/screens/profissional/employee_home_screen.dart';
import 'package:event_uau/screens/profissional/employee_signup/employee_signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/colors.dart';

class EventUauAppBar extends StatefulWidget with PreferredSizeWidget {
  const EventUauAppBar({Key key, this.title, this.username}) : super(key: key);

  final String title;
  final String username;

  @override
  _EventUauAppBarState createState() => _EventUauAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _EventUauAppBarState extends State<EventUauAppBar> {
  @override
  Widget build(BuildContext context) {
    final bool _isPartner = Provider.of<Auth>(context).user.isPartner;
    return AppBar(
      title: Text(
        widget.title ?? "",
      ),
      toolbarHeight: 70,
      elevation: 0,
      actions: <Widget>[
        widget.username != null
            ? TextButton(
                onPressed: () => !_isPartner
                    ? Navigator.of(context)
                        .pushNamed(EmployeeSignupScreen.routeName)
                    : Navigator.of(context)
                        .pushReplacementNamed(EmployeeHomeScreen.routeName),
                child: Text(
                  !_isPartner ? 'Seja um Parceiro!' : 'Área do Parceiro',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                      color: Theme.of(context).primaryColor),
                ),
              )
            : null,
        widget.username != null
            ? GestureDetector(
                child: CircleAvatar(
                backgroundColor: userLogged,
                child: Container(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    widget.username != null
                        ? widget.username
                            .split(" ")
                            .sublist(0, 2)
                            .map((e) {
                              return e[0];
                            })
                            .join()
                            .toUpperCase()
                        : "NO",
                    style: TextStyle(fontSize: 20.0, color: primaryColor),
                  ),
                ),
              ))
            : Padding(
                padding: EdgeInsets.all(16),
                child:
                    Text("fazer login", style: TextStyle(color: primaryColor)),
              ),
      ],
      iconTheme: IconThemeData(color: primaryColor, size: 16),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
