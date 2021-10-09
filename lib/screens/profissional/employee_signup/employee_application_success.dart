import 'package:flutter/material.dart';
import '../../../screens/profissional/employee_home_screen.dart';

class EmployeeApplicationSuccess extends StatelessWidget {
  const EmployeeApplicationSuccess({Key key}) : super(key: key);

  static const routeName = '/employee/signup/applicationsuccess';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Seu cadastro foi aprovado!',
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Agora você pode receber propostas.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 12,
            ),
            RaisedButton(
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed(EmployeeHomeScreen.routeName),
              child: Text(
                'Continuar para Área do Parceiro',
                // style: TextStyle(decoration: TextDecoration.underline),
              ),
            )
          ],
        ),
      ),
    );
  }
}
