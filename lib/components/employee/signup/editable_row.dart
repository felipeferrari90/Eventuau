import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditableRow extends StatefulWidget {
  const EditableRow({
    this.editableText,
    this.uneditableText = "",
    Key key,
  }) : super(key: key);

  final String editableText;
  final String uneditableText;

  @override
  _EditableRowState createState() => _EditableRowState();
}

class _EditableRowState extends State<EditableRow> {
  bool _isEditing = false;
  bool _isNumeric = false;

  @override
  void initState() {
    try {
      var editableInt = int.tryParse(widget.editableText);
      _isNumeric = !editableInt.isNaN;
    } catch (e) {
      _isNumeric = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _isEditing
              ? IntrinsicWidth(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minWidth: 30,
                        maxWidth: MediaQuery.of(context).size.width * 0.8),
                    child: TextFormField(
                      maxLength: _isNumeric ? 2 : null,
                      inputFormatters: _isNumeric
                          ? [FilteringTextInputFormatter.digitsOnly]
                          : [],
                      keyboardType: _isNumeric
                          ? TextInputType.number
                          : TextInputType.name,
                      autofocus: true,
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(fontSize: 18),
                      initialValue: widget.editableText,
                      textCapitalization: TextCapitalization.words,
                      autocorrect: false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                    ),
                  ),
                )
              : Text(
                  "${widget.editableText} ${widget.uneditableText}",
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
