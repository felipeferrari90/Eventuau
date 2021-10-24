import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';

import '../../../providers/auth.dart';
import '../../../providers/employee_wallet_data.dart';
import './employee_wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddCreditCard extends StatefulWidget {
  const AddCreditCard({Key key}) : super(key: key);

  static const routeName = 'employee/wallet/add_credit_card';

  @override
  _AddCreditCardState createState() => _AddCreditCardState();
}

class _AddCreditCardState extends State<AddCreditCard> {
  GlobalKey<FormState> _formKey = new GlobalKey();
  Map<String, String> _formValues = {
    'cvv': null,
    'number': null,
    'validade': null,
    'name': null,
    'cpf': null,
  };

  @override
  void initState() {
    final userInfo = Provider.of<Auth>(context, listen: false).user;

    _formValues['name'] = userInfo.name;
    _formValues['cpf'] = userInfo.cpf;
    super.initState();
  }

  void _onSubmit() {
    if (!_formKey.currentState.validate()) return;

    _formKey.currentState.save();

    Provider.of<EmployeeWalletData>(context, listen: false).cardDataFromForm =
        _formValues;

    Navigator.of(context).popUntil((route) => route.settings.name == '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context)
              .popUntil((route) => route.settings.name == '/'),
          icon: Icon(Icons.arrow_back),
          color: Theme.of(context).primaryColor,
        ),
        title: Text('Novo cartão'),
        actions: [
          IconButton(
            onPressed: _onSubmit,
            icon: Icon(
              Icons.done,
              color: Colors.green,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  onSaved: (value) => _formValues['name'] = value,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Campo Obrigatório";
                    }

                    final hasSpace = value.contains(" ");

                    if (!hasSpace) {
                      return "É necessário nome e sobrenome";
                    }

                    if (hasSpace && value.split(" ").length < 2) {
                      return "É necessário nome e sobrenome";
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Nome',
                  ),
                  initialValue: _formValues['name'] ?? '',
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Campo Obrigatório';

                    if (value.length < 14) return 'CPF Inválido';

                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'CPF',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter()
                  ],
                  initialValue: _formValues['cpf'] ?? '',
                  onSaved: (value) => _formValues['cpf'] = value,
                ),
                TextFormField(
                  onSaved: (value) => _formValues['number'] = value,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Campo Obrigatório';

                    if (value.length < 19) return 'Numero de Cartão Inválido';

                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Numero do Cartão',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CartaoBancarioInputFormatter()
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        onSaved: (value) {
                          _formValues['validade'] = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo Obrigatório';
                          }

                          if (value.length < 5) return 'Data Inválida';

                          var _values = value.split('/');
                          var _date = DateTime(int.parse('20${_values[1]}'),
                              int.parse(_values[0]));

                          if (_date.isBefore(DateTime.now()))
                            return 'Data Inválida';

                          return null;
                        },
                        decoration: InputDecoration(
                            counterText: "",
                            labelText: 'Data de Validade',
                            helperText: 'MM/AA'),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          ValidadeCartaoInputFormatter()
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        onSaved: (value) => _formValues['cvv'] = value,
                        maxLength: 3,
                        decoration: InputDecoration(
                            counterText: "",
                            labelText: 'CVV',
                            helperText: 'Numeros atrás do seu cartão'),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo Obrigatório';
                          }

                          if (value.length < 3) return 'CVV Inválido';

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
      ),
    );
  }
}
