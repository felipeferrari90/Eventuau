import 'dart:io';

import 'package:event_uau/service/upload_service.dart';
import 'package:flutter/material.dart';

class EventCardEmployee extends StatelessWidget {
  const EventCardEmployee({
    this.trailing,
    this.name,
    this.age,
    this.job,
    this.id,
    Key key,
  }) : super(key: key);

  final trailing;
  final String name;
  final String age;
  final String job;
  final int id;

  Widget renderTrailing() {
    if (trailing is Widget) return trailing;

    if (trailing is String)
      return Text(
        trailing.toString(),
        style: TextStyle(fontSize: 20),
      );

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: ListTile(
        visualDensity: VisualDensity.compact,
        trailing: renderTrailing(),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        tileColor: Color.fromRGBO(0, 0, 0, 0.05),
        leading: FutureBuilder(
          builder: (context, snapshot) =>
              snapshot.connectionState != ConnectionState.waiting &&
                      snapshot.hasData == false
                  ? Icon(
          Icons.person,
          color: Theme.of(context).primaryColor,
          size: 42,
        )
                  : CircleAvatar(backgroundImage: MemoryImage(snapshot.data)),
          future: fetchProfilePicture(id),
        ),
        title: Text('$name ${age ?? ''}'),
        subtitle: Row(
          children: [
            Text(
              job,
              style: TextStyle(color: Colors.black),
            ),
            // SizedBox(
            //   width: 8,
            // ),
            // Text(
            //   '4.89/5',
            //   style: TextStyle(color: Theme.of(context).primaryColor),
            // )
          ],
        ),
      ),
    );
  }
}
