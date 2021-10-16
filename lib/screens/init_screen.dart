import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../utils/colors.dart';
import '../components/buttons.dart';
import '../components/error_toast.dart';


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
      print(e);
      setState(() => _hasError = true);

      if (_errorMessageTimer?.isActive == true) _errorMessageTimer.cancel();

      _errorMessageTimer = new Timer(
          Duration(seconds: 5), () => setState(() => _hasError = false));

      setState(() {
        _isLoading = false;
      });
    }
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
        backgroundColor: colorBg,
        body: SingleChildScrollView(
          child: Container(
            height: deviceSize.height,
            width: deviceSize.width,
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Stack(children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 40),
                        child: Image.asset("assets/images/logo-roxo.png",
                            height: 200),
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
                        ErrorToast(
                          hasError: _hasError,
                          text: 'Ocorreu um erro, por favor tente novamente.',
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
