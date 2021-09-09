import '../../../components/employee/signup/paragraph_text.dart';

import 'package:flutter/material.dart';

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
            ParagraphText('Agora você pode receber propostas.'),
            ElevatedButton(
              onPressed: () {},
              child: Text('Ir para o Meu Perfil'),
            )
          ],
        ),
      ),
    );
  }
}
