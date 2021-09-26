import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditableRow extends StatefulWidget {
  const EditableRow({
    this.editableText,
    this.uneditableText = "",
    this.onTextChanged,
    @required this.onSubmit,
    Key key,
  }) : super(key: key);

  final String editableText;
  final String uneditableText;
  final Function onTextChanged;
  final Function onSubmit;

  @override
  _EditableRowState createState() => _EditableRowState();
}

class _EditableRowState extends State<EditableRow> {
  bool _isEditing = false;
  bool _isNumeric = false;

  GlobalKey<FormState> _formKey = new GlobalKey();

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
              ? ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: 30,
                      maxWidth: MediaQuery.of(context).size.width * 0.8),
                child: IntrinsicWidth(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        
                        maxLines: 2,
                        minLines: 1,
                        onSaved: (value) => widget.onSubmit != null
                            ? widget.onSubmit(value)
                            : () {
                                throw Exception(
                                    'On saved was called on null, please provide a non null value to it.');
                              },
                        onChanged: widget.onTextChanged ?? null,
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
                ),
                )
              : ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8),
                  child: Text(
                    "${widget.editableText} ${widget.uneditableText}",                  
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(
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
                _isEditing = !_isEditing;
                if (!_isEditing) _formKey.currentState.save();
              });
            },
            borderRadius: BorderRadius.circular(100),
          ),
        ],
      ),
    );
  }
}
