import 'package:brasil_fields/brasil_fields.dart';
import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/components/buttons.dart';
import 'package:event_uau/components/input_form_eventual.dart';
import 'package:event_uau/models/contratante_model.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';




class SignUpScreen extends StatefulWidget {
  const SignUpScreen({ Key? key }) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {



  bool _contractChecked = false;

  final GlobalKey<FormState> _formKeySignUp = new GlobalKey<FormState>();

  final FocusNode _nameFocusNode = new FocusNode();
  final FocusNode _cpfFocusNode = new FocusNode();
  final FocusNode _emailFocusNode = new FocusNode();
  final FocusNode _phoneFocusNode = new FocusNode();
  final FocusNode _birthDateFocusNode = new FocusNode();
 
  final FocusNode _passwordFocusNode = new FocusNode();
  final FocusNode _confirPasswordFocusNode = new FocusNode();

  TextEditingController _passwordController = new TextEditingController();

  ContratanteModel contratanteModel = new ContratanteModel();

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _cpfFocusNode.dispose();
    _birthDateFocusNode.dispose();
    _phoneFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirPasswordFocusNode.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKeySignUp.currentState!.validate() & !_contractChecked ) {
      return;
    }
    _formKeySignUp.currentState!.save();
    print(contratanteModel);
  }
   
  

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: setAppBar(context,title: "Cadastre-se"),
        backgroundColor: colorBg,
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form( 
              key: _formKeySignUp,
              child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(labelText: 'Nome Completo'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => _nameFocusNode.requestFocus(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Campo Obrigatório";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        contratanteModel.nome = value;
                      },
                    ),
                    TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'CPF'),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CpfInputFormatter()
                      ],
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => _cpfFocusNode.requestFocus(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Campo Obrigatório";
                        }
                      },
                      onSaved: (value) {
                        contratanteModel.cpf = value as String;
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
                        if (value!.isEmpty) {
                          return "Campo Obrigatório";
                        }

                        return null;
                      },
                      onSaved: (value) {
                        contratanteModel.dataNascimento = DateFormat.yMd("pt_BR").parse(value as String);
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
                        if (value!.isEmpty) {
                          return "Campo Obrigatório";
                        }

                        return null;
                      },
                      onSaved: (value) {
                        contratanteModel.telefone = value;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'E-mail'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          _passwordFocusNode.requestFocus(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Campo Obrigatório";
                        }
                        if (!value.contains('@')) {
                          return "Email inválido";
                        }

                        return null;
                      },
                      onSaved: (value) {
                        contratanteModel.email = value;
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
                        if (value!.isEmpty) {
                          return "Campo Obrigatório";
                        }
                        if (value.length < 6) {
                          return "A senha precisa conter no mínimo 6 dígitos";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        contratanteModel.senha = value;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Confirme a Senha'),
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
                            value: _contractChecked,
                            checkColor: colorBg,
                            activeColor: primaryColor,
                            onChanged: (bool? value) {
                              setState(() {
                                _contractChecked = value as bool;
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
                  ]
                )
             ),
          ),
      )
    ); 
  }
}

