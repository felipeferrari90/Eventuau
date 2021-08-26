import 'package:event_uau/components/buttons.dart';
import 'package:event_uau/screens/profissional/employee_signup.dart';
import 'package:flutter/material.dart';

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

  void _onSubmit() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();
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
                  onSelected: (value) => Navigator.pushNamed(context, value),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text('DEVELOPER MENU FOR QUICK SCREEN ROUTING'),
                      enabled: false,
                    ),
                    PopupMenuItem(
                      child: Text('Go to ${EmployeeSignupScreen.routeName}'),
                      value: EmployeeSignupScreen.routeName,
                    )
                  ],
                )),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                Widget>[
              Padding(
                padding: EdgeInsets.only(left: 40),
                child: Image.asset("assets/images/logo-roxo.png", height: 200),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Event",
                        style: Theme.of(context).textTheme.headline1.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: 36),
                        textAlign: TextAlign.center),
                    Text("uau",
                        style: Theme.of(context).textTheme.headline3.copyWith(
                            color: Theme.of(context).accentColor, fontSize: 52),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
              Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 8, bottom: 1),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => _passwordFocusNode.requestFocus(),
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
              setButton(
                text: "Entrar",
                function: _onSubmit,
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
