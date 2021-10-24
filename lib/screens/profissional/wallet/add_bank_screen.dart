import 'dart:convert';

import '../../../providers/auth.dart';
import '../../../providers/employee_wallet_data.dart';
import './employee_wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddBankScreen extends StatefulWidget {
  const AddBankScreen({Key key}) : super(key: key);

  static const routeName = 'employee/wallet/add_bank_details';

  @override
  _AddBankScreenState createState() => _AddBankScreenState();
}

class _AddBankScreenState extends State<AddBankScreen> {
  Future bankFuture;
  GlobalKey<FormState> _formKey = new GlobalKey();
  Map<String, String> _formValues = {
    'agencia': null,
    'bankNumber': null,
    'conta': null,
    'name': null,
    'cpf': null
  };

  @override
  void initState() {
    bankFuture = http.get(
        'https://raw.githubusercontent.com/guibranco/BancosBrasileiros/master/data/bancos.json');
    final userInfo = Provider.of<Auth>(context, listen: false).user;

    _formValues['name'] = userInfo.name;
    _formValues['cpf'] = userInfo.cpf;
    super.initState();
  }

  void _onSubmit() {
    if (!_formKey.currentState.validate()) return;

    _formKey.currentState.save();

    Provider.of<EmployeeWalletData>(context, listen: false).bankDataFromForm =
        _formValues;

    Navigator.of(context)
        .popUntil((route) => route.settings.name == EmployeeWallet.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).popUntil(
              (route) => route.settings.name == EmployeeWallet.routeName),
          icon: Icon(Icons.arrow_back),
          color: Theme.of(context).primaryColor,
        ),
        title: Text('Novos dados bancários'),
        actions: [
          IconButton(
              onPressed: _onSubmit,
              icon: Icon(
                Icons.done,
                color: Colors.green,
              ))
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              BankSelection(
                formValues: _formValues,
                bankFuture: bankFuture,
              ),
              TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
                style: TextStyle(color: Colors.grey[500]),
                initialValue: _formValues['name'] ?? '',
              ),
              TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'CPF',
                ),
                style: TextStyle(color: Colors.grey[500]),
                initialValue: _formValues['cpf'] ?? '',
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: TextFormField(
                      onSaved: (value) {
                        _formValues['agencia'] = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo Obrigatório';
                        }

                        return null;
                      },
                      maxLength: 4,
                      decoration: InputDecoration(
                          counterText: "",
                          labelText: 'Agencia',
                          helperText: 'Agência sem dígito'),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Flexible(
                    flex: 1,
                    child: TextFormField(
                      onSaved: (value) => _formValues['conta'] = value,
                      decoration: InputDecoration(
                          labelText: 'Conta', helperText: 'Somente numeros'),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo Obrigatório';
                        }

                        return null;
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BankSelection extends StatelessWidget {
  const BankSelection({
    Key key,
    @required this.bankFuture,
    @required Map<String, dynamic> formValues,
  })  : _formValues = formValues,
        super(key: key);

  final Map<String, dynamic> _formValues;
  final Future bankFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: bankFuture,
      initialData: [],
      builder: (context, snapshot) {
        final List bankData =
            snapshot.connectionState == ConnectionState.done &&
                    snapshot.data.statusCode == 200
                ? json.decode(snapshot.data.body)
                : [];
        return DropdownButtonFormField(
            isExpanded: true,
            validator: (value) =>
                value == null || value.isEmpty ? 'Campo Obrigatório' : null,
            onSaved: (value) => _formValues['bankNumber'] = value,
            onChanged: (value) => _formValues['bankNumber'] = value,
            value: bankData.length > 0
                ? '${bankData[0]['COMPE']} - ${bankData[0]['ShortName']}'
                : null,
            items: bankData.length > 0
                ? bankData.map((e) {
                    final text = '${e['COMPE']} - ${e['ShortName']}';
                    return DropdownMenuItem(value: text, child: Text(text));
                  }).toList()
                : []);
      },
    );
  }
}
