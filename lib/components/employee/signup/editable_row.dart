import 'package:flutter/material.dart';

class EditableRow extends StatefulWidget {
  const EditableRow(
    this.text, {
    Key key,
  }) : super(key: key);

  final String text;

  @override
  _EditableRowState createState() => _EditableRowState();
}

class _EditableRowState extends State<EditableRow> {
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _isEditing
              ? IntrinsicWidth(
                  child: TextFormField(
                    autofocus: true,
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(fontSize: 18),
                    initialValue: widget.text,
                    textCapitalization: TextCapitalization.words,
                    autocorrect: false,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                  ),
                )
              : Text(
                  widget.text,
                  textAlign: TextAlign.end,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 18),
                ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            child: Icon(
              _isEditing ? Icons.check : Icons.edit,
              size: 24,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
            borderRadius: BorderRadius.circular(100),
          ),
        ],
      ),
    );
  }
}
