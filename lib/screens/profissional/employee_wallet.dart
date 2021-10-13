import 'package:flutter/material.dart';

class EmployeeWallet extends StatelessWidget {
  const EmployeeWallet({Key key}) : super(key: key);

  static const routeName = '/employee/wallet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Carteira'),
      ),
    );
  }
}
