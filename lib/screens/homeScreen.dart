import 'package:flutter/material.dart';
import '../api/github.dart';
import 'drawerScreen.dart';

import 'dart:async';

class HomeScreen extends StatefulWidget {
  final GithubApi _githubApi;

  HomeScreen(this._githubApi);

  HomeState createState() => HomeState(_githubApi);
}

class HomeState extends State<HomeScreen> {
  final GithubApi _githubApi;

  HomeState(this._githubApi);

  initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: DrawerScreen(_githubApi),
      appBar: new AppBar(
        title: new Text("Github API"),
      ),
      body: Column(
        children: <Widget>[Text('Application description here')],
      ),
    );
  }
}
