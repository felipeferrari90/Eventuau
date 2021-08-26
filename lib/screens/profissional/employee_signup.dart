import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:flutter/material.dart';

class EmployeeSignupScreen extends StatefulWidget {
  static const routeName = 'employee/signup';
  const EmployeeSignupScreen({Key key}) : super(key: key);

  @override
  _EmployeeSignupScreenState createState() => _EmployeeSignupScreenState();
}

class _EmployeeSignupScreenState extends State<EmployeeSignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EventUauAppBar(
        title: 'Seja um Parceiro',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ParagraphText(
                'Olá! Ficamos felizes em saber que você quer fazer parte do nosso time.'),
            ParagraphText(
                'Vimos que você ainda não tem foto, toque no avatar abaixo e escolha uma que mostre bem o seu rosto:'),
            Stack(
              children: [
                CircleAvatar(
                  radius: 75,
                  backgroundColor: Theme.of(context).accentColor,
                  child: Text(
                    'FF',
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(fontSize: 48),
                  ),
                ),
                Positioned(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: IconButton(
                        splashRadius: 1,
                        color: Theme.of(context).primaryColor,
                        icon: Icon(Icons.edit),
                        onPressed: () {}),
                  ),
                  right: 0,
                )
              ],
            ),
            SizedBox(
              height: 18,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                EditableRow('Felipe Ferreira'),
                EditableRow('24 Anos'),
                EditableRow('Liberdade - SP')
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
