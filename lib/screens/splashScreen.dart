import 'package:flutter/material.dart';
import '../api/github.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  final GithubApi _githubApi;

  SplashScreen(this._githubApi);

  SplashScreenState createState() => SplashScreenState(_githubApi);
}

class SplashScreenState extends State<SplashScreen> {
  final GithubApi _githubApi;

  SplashScreenState(this._githubApi);

  initState() {
    super.initState();
    _init();
  }

  Future _init() async {
    await _githubApi.init();
    Navigator.pushReplacementNamed(context, 'login');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
