import 'package:event_uau/screens/init_screen.dart';
import 'package:flutter/material.dart';

class SignupSuccess extends StatelessWidget {
  const SignupSuccess({Key key}) : super(key: key);

  static const routeName = 'signup/sucess';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Usuário cadastrado com sucesso!',
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              height: 6,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text('Voltar ao Home'),
            )
          ],
        ),
      ),
    );
  }
}
