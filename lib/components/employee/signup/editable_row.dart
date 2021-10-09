import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditableRow extends StatefulWidget {
  const EditableRow({
    this.editableText,
    this.uneditableText = "",
    @required this.onSubmit,
    Key key,
  }) : super(key: key);

  final String editableText;
  final String uneditableText;
  final Function onSubmit;

  @override
  _EditableRowState createState() => _EditableRowState();
}

class _EditableRowState extends State<EditableRow> {
  bool _isEditing = false;
  bool _isDate = false;

  GlobalKey<FormState> _formKey = new GlobalKey();

  @override
  void initState() {
    _isDate = RegExp(r"\d{2}\/\d{2}\/\d{4}").hasMatch(widget.editableText);

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
              ? ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: 105,
                      maxWidth: MediaQuery.of(context).size.width * 0.8),
                  child: IntrinsicWidth(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        validator: (value) =>
                            value.isEmpty ? 'Campo Obrigatório' : null,
                        maxLines: 2,
                        minLines: 1,
                        onSaved: (String value) => widget.onSubmit(value),
                        maxLength: _isDate ? 10 : null,
                        inputFormatters: _isDate
                            ? [
                                FilteringTextInputFormatter.digitsOnly,
                                DataInputFormatter()
                              ]
                            : [],
                        keyboardType: _isDate
                            ? TextInputType.datetime
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
                  ),
                )
              : ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8),
                  child: Text(
                    "${widget.editableText} ${widget.uneditableText}",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1.copyWith(
                          fontSize: 18,
                        ),
                  ),
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
                if (_isEditing) {
                  if (!_formKey.currentState.validate()) return;

                  _formKey.currentState.save();
                }
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
