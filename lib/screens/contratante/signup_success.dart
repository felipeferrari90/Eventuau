import '../../screens/profissional/employee_home_screen.dart';
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
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              height: 12,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(EmployeeHomeScreen.routeName);
              },
              child: Text('Voltar ao Home'),
            )
          ],
        ),
      ),
    );
  }
}
