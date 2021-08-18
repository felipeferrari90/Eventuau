import 'package:brasil_fields/brasil_fields.dart';
import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/components/buttons.dart';
import 'package:event_uau/components/input_form_eventual.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = new GlobalKey();

  final FocusNode _nameFocusNode = new FocusNode();
  final FocusNode _birthDateFocusNode = new FocusNode();
  final FocusNode _phoneFocusNode = new FocusNode();
  final FocusNode _emailFocusNode = new FocusNode();
  final FocusNode _passwordFocusNode = new FocusNode();
  final FocusNode _confirPasswordFocusNode = new FocusNode();

  bool contractChecked = false;

  TextEditingController _passwordController = new TextEditingController();

  Map<String, dynamic> _formValues = {
    'name': null,
    'password': null,
    'cpf': null,
    'email': null,
    'phone': null,
    'birthDate': null
  };

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _birthDateFocusNode.dispose();
    _phoneFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirPasswordFocusNode.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    print(_formValues);
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = setAppBar(context, title: "Cadastre-se");
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: appBar,
      backgroundColor: colorBg,
      body: Container(
        height: (mediaQuery.size.height -
            mediaQuery.padding.top -
            appBar.preferredSize.height),
        width: mediaQuery.size.width,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              vertical: mediaQuery.size.width * 0.05,
              horizontal: mediaQuery.size.width * 0.1),
          child: Form(
            key: _formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'CPF'),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CpfInputFormatter()
                      ],
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => _nameFocusNode.requestFocus(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Campo Obrigatório";
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _formValues['cpf'] = value;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(labelText: 'Nome Completo'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          _birthDateFocusNode.requestFocus(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Campo Obrigatório";
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _formValues['name'] = value;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.datetime,
                      decoration:
                          InputDecoration(labelText: 'Data de Nascimento'),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        DataInputFormatter()
                      ],
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => _phoneFocusNode.requestFocus(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Campo Obrigatório";
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _formValues['birthDate'] = value;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration:
                          InputDecoration(labelText: 'Telefone de Contato'),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter()
                      ],
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => _emailFocusNode.requestFocus(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Campo Obrigatório";
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _formValues['phone'] = value;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'E-mail'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          _passwordFocusNode.requestFocus(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Campo Obrigatório";
                        }
                        if (!value.contains('@')) {
                          return "Email inválido";
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _formValues['email'] = value;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration:
                          InputDecoration(labelText: 'Escolha uma Senha'),
                      controller: _passwordController,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          _passwordFocusNode.requestFocus(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Campo Obrigatório";
                        }
                        if (value.length < 6) {
                          return "A senha precisa conter no mínimo 6 dígitos";
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _formValues['password'] = value;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration:
                          InputDecoration(labelText: 'Confirme a Senha'),
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _onSubmit(),
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return "As duas senhas não coincidem";
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: contractChecked,
                            checkColor: colorBg,
                            activeColor: primaryColor,
                            onChanged: (bool value) {
                              setState(() {
                                contractChecked = value;
                              });
                            }),
                        Text(
                          "Eu concordo com os termos de uso e\npoliticas de privacidade da EventUAU",
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w300,
                              fontSize: 16),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                setButton(
                  margin: EdgeInsets.all(0),
                  text: "Confirmar",
                  function: _onSubmit,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
