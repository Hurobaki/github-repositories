import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import '../api/github.dart';

import 'dart:async';

class LoginScreen extends StatefulWidget {
  final GithubApi _githubApi;

  LoginScreen(this._githubApi);

  LoginScreenState createState() => LoginScreenState(_githubApi);
}

class LoginScreenState extends State<LoginScreen> {
  final GithubApi _githubApi;
  final _formKey = GlobalKey<FormState>();

  static String _username = "";
  static String _password = "";

  final TextEditingController _usernameController =
      TextEditingController(text: _username);

  final TextEditingController _passwordController =
      TextEditingController(text: _password);

  LoginScreenState(this._githubApi);

  Future<void> _touchIDPop() async {
    var localAuth = LocalAuthentication();
    bool didAuthenticate = await localAuth.authenticateWithBiometrics(
        localizedReason: 'Please authenticate to show account balance');
  }

  initState() {
    super.initState();

    if (_githubApi.loggedIn) {
      setState(() {
        _usernameController.text = _githubApi.username;
        _passwordController.text = _githubApi.password;
        _handleSubmit();
      });
    }
  }

  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSubmit() async {
    var loggedIn = await _githubApi.login(
        _usernameController.text, _passwordController.text);
    if (loggedIn) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      print('Bad creds');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Github Login'),
        ),
        body: Container(
          margin: EdgeInsets.all(30.0),
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 50.0),
                  child: Image.asset(
                    'assets/github.png',
                    width: 100.0,
                    height: 100.0,
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                        controller: _usernameController,
                        autofocus: true,
                        decoration: InputDecoration(
                            hintText: 'Username',
                            suffixIcon: Icon(Icons.account_circle)))),
                Container(
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Password', suffixIcon: Icon(Icons.vpn_key)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: RaisedButton(
                    splashColor: Colors.greenAccent,
                    color: Colors.blue,
                    child: Text('Submit'),
                    onPressed: () {
                      _handleSubmit();
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
