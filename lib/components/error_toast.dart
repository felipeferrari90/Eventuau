import 'package:flutter/material.dart';

class ErrorToast extends StatelessWidget {
  const ErrorToast({Key key, @required bool hasError, @required String text})
      : _hasError = hasError,
        _text = text,
        super(key: key);

  final bool _hasError;
  final String _text;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(

      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: _hasError ? 40 : 0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.redAccent,
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            child: const Icon(
              Icons.warning,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            _text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
