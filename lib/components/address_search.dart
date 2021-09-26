import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class AddressSearch extends StatefulWidget {
  const AddressSearch({Key key, this.initialValue}) : super(key: key);

  final String initialValue;

  @override
  _AddressSearchState createState() => _AddressSearchState();
}

class _AddressSearchState extends State<AddressSearch> {
  TextEditingController queryController;
  bool _isLoading = false;
  Map<String, String> addressData;

  Future<void> getAddressFromCEP(String cep) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final res = await http.get('https://viacep.com.br/ws/$cep/json/');

      if (res.statusCode != 200) throw res;

      setState(() => addressData = jsonDecode(res.body));
    } catch (e) {
      print(e);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    queryController = new TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Adicionar endereço'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.done,
                color: Colors.green,
              ),
            )
          ],
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CepInputFormatter(ponto: false)
                              ],
                              decoration: InputDecoration(labelText: 'CEP'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ));
  }
}
