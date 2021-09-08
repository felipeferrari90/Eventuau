import 'package:flutter/material.dart';

class ParagraphText extends StatelessWidget {
  const ParagraphText(this.text, {Key key}) : super(key: key);

  final text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 18),
      ),
    );
  }
}
