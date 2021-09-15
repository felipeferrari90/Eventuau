import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './profissional/employee_home_screen.dart';
import './profissional/employee_profile_screen.dart';
import './profissional/employee_signup/employee_signup.dart';

import '../providers/auth.dart';

import '../utils/colors.dart';
import '../components/buttons.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({Key key}) : super(key: key);

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordFocusNode = FocusNode();

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  bool _hasError = false;
  bool _isLoading = false;
  Timer _errorMessageTimer;

  Future<void> _onSubmit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    try {
      setState(() {
        _isLoading = true;
      });

      await Provider.of<Auth>(context, listen: false)
          .login(_authData['email'], _authData['password']);
    } catch (e) {
      setState(() => _hasError = true);

      if (_errorMessageTimer?.isActive == true) _errorMessageTimer.cancel();

      _errorMessageTimer = new Timer(
          Duration(seconds: 5), () => setState(() => _hasError = false));
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: deviceSize.height,
        width: deviceSize.width,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Stack(children: [
            Positioned(
                top: 10,
                left: 0,
                child: PopupMenuButton(
                  onSelected: (value) =>
                      Navigator.pushReplacementNamed(context, value as String),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text('DEVELOPER MENU FOR QUICK SCREEN ROUTING'),
                      enabled: false,
                    ),
                    PopupMenuItem(
                      child: Text('Go to ${EmployeeSignupScreen.routeName}'),
                      value: EmployeeSignupScreen.routeName,
                    ),
                    PopupMenuItem(
                      child: Text('Go to ${EmployeeProfileScreen.routeName}'),
                      value: EmployeeProfileScreen.routeName,
                    ),
                    PopupMenuItem(
                      child: Text('Go to ${EmployeeHomeScreen.routeName}'),
                      value: EmployeeHomeScreen.routeName,
                    )
                  ],
                )),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 40),
                    child:
                        Image.asset("assets/images/logo-roxo.png", height: 200),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      mainAxisAlignment: MainAxisAlignment.center,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text("Event",
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                .copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 36),
                            textAlign: TextAlign.center),
                        Text("uau",
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                .copyWith(color: accentColor, fontSize: 52),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  Column(children: <Widget>[
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      height: _hasError ? 40 : 0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.redAccent,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.warning,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Text(
                            'Ocorreu um erro, por favor tente novamente.',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8, bottom: 1),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            _passwordFocusNode.requestFocus(),
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Email Inválido';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData['email'] = value;
                        },
                        decoration: InputDecoration(
                          labelText: "E-mail",
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8, bottom: 1),
                      child: TextFormField(
                        focusNode: _passwordFocusNode,
                        onFieldSubmitted: (_) => _onSubmit(),
                        autocorrect: false,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Campo Obrigatório';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData['password'] = value;
                        },
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: "Senha",
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: _isLoading
                        ? Container(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                            ),
                          )
                        : Text("Entrar"),
                    onPressed: _onSubmit,
                  ),
                  setButton(
                      text: "Criar conta",
                      outline: true,
                      function: () {
                        Navigator.pushNamed(context, "/signup");
                      }),
                ]),
          ]),
        ),
      ),
    ));
  }
}
