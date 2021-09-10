import 'package:flutter/material.dart';

class EventCardEmployee extends StatelessWidget {
  const EventCardEmployee({
    this.trailing,
    Key key,
  }) : super(key: key);

  final trailing;

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
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(
              'https://spinoff.com.br/wp-content/uploads/2020/09/borat_uAQBQff-1200x720.jpg'),
        ),
        title: Text('Pedro Lemes, 24'),
        subtitle: Row(
          children: [
            Text(
              'Garçom',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              '4.89/5',
              style: TextStyle(color: Theme.of(context).primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
