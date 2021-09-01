import 'package:flutter/material.dart';

class EditableRow extends StatelessWidget {
  const EditableRow(
    this.text, {
    Key key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text,
              textAlign: TextAlign.end,
              style:
                  Theme.of(context).textTheme.headline1.copyWith(fontSize: 18)),
          SizedBox(
            width: 10,
          ),
          InkWell(
            child: Icon(
              Icons.edit,
              size: 24,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {},
            borderRadius: BorderRadius.circular(100),
          ),
        ],
      ),
    );
  }
}
