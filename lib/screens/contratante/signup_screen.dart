import 'package:brasil_fields/brasil_fields.dart';
import '../../components/app_bar_eventual.dart';
import '../../components/buttons.dart';
import '../../components/error_toast.dart';

import './signup_success.dart';
import 'package:event_uau/models/signup_model.dart';
import 'package:event_uau/providers/auth.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../utils/dateValidation.dart' as dateValidator;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  static const routeName = "/signup";

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
  bool hasError = false;

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

  void _onSubmit() async {
    if (!_formKey.currentState.validate() || !contractChecked) {
      if (!contractChecked)
        setState(() {
          hasError = true;
        });

      return;
    }

    setState(() {
      hasError = false;
    });

    _formKey.currentState.save();

    var signupFields = SignupModel(
      birthDate: _formValues['birthDate'],
      cpf: _formValues['name'],
      password: _formValues['password'],
      email: _formValues['email'],
      name: _formValues['name'],
      phone: _formValues['phone'],
    );

    try {
      await Provider.of<Auth>(context, listen: false).signup(signupFields);

      Navigator.of(context).pushReplacementNamed(SignupSuccess.routeName);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erro ao cadastrar usuário')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: EventUauAppBar(),
      backgroundColor: colorBg,
      body: Container(
        height: (mediaQuery.size.height -
            mediaQuery.padding.top -
            EventUauAppBar().preferredSize.height),
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

                        final hasSpace = value.contains(" ");

                        if (!hasSpace) {
                          return "É necessário nome e sobrenome";
                        }

                        if (hasSpace && value.split(" ").length < 2) {
                          return "É necessário nome e sobrenome";
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

                        if (!dateValidator.isDateTypeAndBeforeNow(value)) {
                          return "Data Inválida";
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
                        if (value.isEmpty) {
                          return "Campo Obrigatório";
                        }
                        if (value != _passwordController.text) {
                          return "As duas senhas não coincidem";
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ErrorToast(
                      hasError: hasError,
                      text: 'Voce deve aceitar os termos e condições',
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
                                if (value == true) hasError = false;
                              });
                            }),
                        Text(
                          "Eu concordo com os termos de uso e\npoliticas de privacidade da EventUAU",
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w300,
                              fontSize: 16),
                        ),
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
