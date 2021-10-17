import 'package:flutter/material.dart';

class AddBankScreen extends StatefulWidget {
  const AddBankScreen({Key key}) : super(key: key);

  static const routeName = 'employee/wallet/add_bank_details';

  @override
  _AddBankScreenState createState() => _AddBankScreenState();
}

class _AddBankScreenState extends State<AddBankScreen> {
  List<DropdownMenuItem> bankList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novos dados bancários'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [DropdownButtonFormField(items: [])],
          ),
        ),
      ),
    );
  }
}
