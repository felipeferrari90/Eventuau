import 'package:flutter/material.dart';
import '../utils/colors.dart';

class EventUauAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  const EventUauAppBar({Key key, this.title, this.username}) : super(key: key);

  final String title;
  final String username;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title ?? "",
      ),
      toolbarHeight: 70,
      elevation: 0,
      actions: <Widget>[
        username != null
            ? GestureDetector(
                child: Container(
                    margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: userLogged),
                    child: Center(
                        child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        username != null
                            ? username
                                .split(" ")
                                .sublist(0, 2)
                                .map((e) {
                                  return e[0];
                                })
                                .join()
                                .toUpperCase()
                            : "",
                        style: TextStyle(fontSize: 18.0, color: primaryColor),
                      ),
                    ))),
              )
            : Padding(
                padding: EdgeInsets.all(16),
                child:
                    Text("fazer login", style: TextStyle(color: primaryColor)),
              )
      ],
      iconTheme: IconThemeData(color: primaryColor, size: 16),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
