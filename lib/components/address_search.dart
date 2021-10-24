import 'dart:convert';
import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../models/address_model.dart';

class AddressSearch extends StatefulWidget {
  const AddressSearch({Key key, this.initialValue}) : super(key: key);

  final AddressModel initialValue;

  @override
  _AddressSearchState createState() => _AddressSearchState();
}

class _AddressSearchState extends State<AddressSearch> {
  GlobalKey<FormState> _formKey = new GlobalKey();
  TextEditingController cepController;
  bool _isLoading = false;
  AddressModel addressData;

  @override
  void initState() {
    if (widget.initialValue != null) {
      setState(() {
        cepController =
            new TextEditingController(text: widget.initialValue.cep);
        addressData = widget.initialValue;
      });
    } else
      cepController = new TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    cepController.dispose();
    super.dispose();
  }

  Future<void> getAddressFromCEP() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final res = await http
          .get('https://viacep.com.br/ws/${cepController.text}/json/');

      if (res.statusCode != 200) throw res;

      final responseBody = jsonDecode(res.body);

      setState(() {
        addressData = new AddressModel.create(
          cep: responseBody['cep'],
          rua: responseBody['logradouro'],
          bairro: responseBody['bairro'],
          cidade: responseBody['localidade'],
          estado: responseBody['uf'],
        );
      });
    } catch (e) {
      print(e);
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _openLink(String url) async =>
      await canLaunch(url) ? await launch(url) : false;

  void _onSubmit() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    Navigator.of(context).pop(addressData);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: TextFormField(
                      autofocus: true,
                      onChanged: (_) => setState(() => addressData = null),
                      controller: cepController,
                      textInputAction: TextInputAction.search,
                      onEditingComplete: getAddressFromCEP,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CepInputFormatter(ponto: false)
                      ],
                      decoration: InputDecoration(
                        labelText: 'CEP',
                        suffix: Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: SizedBox(
                              child: _isLoading
                                  ? CircularProgressIndicator(
                                      strokeWidth: 2,
                                    )
                                  : IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(Icons.search),
                                      onPressed: _isLoading
                                          ? () {}
                                          : getAddressFromCEP,
                                    ),
                              height: 24,
                              width: 24),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    child: Text(
                      'Não sabe seu CEP?',
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(decoration: TextDecoration.underline),
                    ),
                    onTap: () => _openLink(
                        'https://buscacepinter.correios.com.br/app/localidade_logradouro/index.php'),
                  )
                ],
              ),
              if (addressData != null) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: TextFormField(
                        enabled: false,
                        onSaved: (value) => addressData.rua = value,
                        initialValue: addressData.rua,
                        decoration: InputDecoration(
                          labelText: 'Rua',
                        ),
                      ),
                      flex: 2,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Flexible(
                      child: TextFormField(
                        onSaved: (value) => addressData.numero = value,
                        initialValue: addressData.numero ?? '',
                        validator: (value) =>
                            value.isEmpty ? 'Campo Obrigatório' : null,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          labelText: 'Numero',
                        ),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: TextFormField(
                        onSaved: (value) => addressData.complemento = value,
                        initialValue: addressData.complemento ?? '',
                        decoration: InputDecoration(
                          labelText: 'Complemento',
                        ),
                      ),
                      flex: 2,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Flexible(
                      child: TextFormField(
                        enabled: false,
                        onSaved: (value) => addressData.bairro = value,
                        initialValue: addressData.bairro ?? '',
                        decoration: InputDecoration(
                          labelText: 'Bairro',
                        ),
                      ),
                      flex: 3,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: TextFormField(
                        enabled: false,
                        onSaved: (value) => addressData.cidade = value,
                        initialValue: addressData.cidade ?? '',
                        decoration: InputDecoration(
                          labelText: 'Cidade',
                        ),
                      ),
                      flex: 2,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Flexible(
                      child: TextFormField(
                        onSaved: (value) => addressData.estado = value,
                        initialValue: addressData.estado ?? '',
                        enabled: false,
                        maxLength: 2,
                        decoration: InputDecoration(
                          labelText: 'UF',
                        ),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'Cancelar',
                          style: TextStyle(color: Colors.black87),
                        )),
                    TextButton(
                      onPressed: () => _isLoading ? null : _onSubmit(),
                      child: Text(
                        'Confirmar Endereço',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
