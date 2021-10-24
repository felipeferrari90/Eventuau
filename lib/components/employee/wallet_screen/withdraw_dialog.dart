import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:event_uau/providers/employee_wallet_data.dart';
import 'package:event_uau/utils/number.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class WithdrawDialog extends StatefulWidget {
  const WithdrawDialog({Key key}) : super(key: key);

  @override
  _WithdrawDialogState createState() => _WithdrawDialogState();
}

class _WithdrawDialogState extends State<WithdrawDialog> {
  TextEditingController _valueText = new TextEditingController();
  bool loading = false;
  EmployeeWalletData _walletData;

  @override
  void didChangeDependencies() {
    _walletData = Provider.of<EmployeeWalletData>(context, listen: false);
    super.didChangeDependencies();
  }

  String validateWithdrawValue() {
    if (_valueText.text.isEmpty) return null;

    final valueAsDouble = asDouble(_valueText.text);

    if (valueAsDouble > _walletData.avaliableBalance) {
      return 'Saldo insuficiente';
    }
    if (valueAsDouble <= 0.0) return 'Campo inválido';

    return null;
  }

  void _onSubmit() async {
    setState(() {
      loading = true;
    });

    final valueAsDouble = asDouble(_valueText.text);
    await _walletData.withdraw(valueAsDouble);

    setState(() {
      loading = false;
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Saque efetuado com sucesso!')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(16),
      titlePadding: EdgeInsets.only(top: 16, left: 16, right: 16),
      title: Text(
        'Novo saque',
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      children: [
        Text(
          'Para:',
          style: TextStyle(fontSize: 16),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            _walletData.selectedBankAccount.toString(),
            style: TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 2,
              child: TextField(
                onChanged: (_) => setState(() {
                  print(_valueText.text);
                }),
                controller: _valueText,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  RealInputFormatter(centavos: true)
                ],
                decoration: InputDecoration(
                    errorText: validateWithdrawValue(),
                    prefix: Text(
                      'R\$',
                      style: TextStyle(color: Colors.black),
                    ),
                    contentPadding: EdgeInsets.all(8),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.redAccent, width: 1)),
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.redAccent, width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1)),
                    focusColor: Theme.of(context).primaryColor,
                    label: Text(
                      'Valor',
                      style: TextStyle(fontSize: 14),
                    )),
              ),
            ),
            Flexible(
              child: RaisedButton(
                visualDensity: VisualDensity.compact,
                onPressed:
                    _valueText.text.isEmpty || loading ? null : _onSubmit,
                child: !loading
                    ? Text(
                        'Sacar ',
                        style: TextStyle(fontSize: 14),
                      )
                    : SizedBox(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                        ),
                        height: 16,
                        width: 16,
                      ),
              ),
              flex: 1,
            )
          ],
        )
      ],
    );
  }
}
