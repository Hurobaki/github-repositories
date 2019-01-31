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
      backgroundColor: Colors.white,
      drawer: DrawerScreen(_githubApi),
      appBar: new AppBar(
        title: new Text("Github API"),
      ),
      body: Container(
          color: Colors.transparent,
          margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                height: 75.0,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${_githubApi.username} information',
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      )
                    ]),
              ),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                children: <Widget>[
                  Card(
                    color: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: InkWell(
                        onTap: () {
                          print('tap');
                        },
                        child: Container(
                            color: Colors.transparent,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  margin:
                                      EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                                  child: Text(
                                    'Repositories',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ),
                                Center(
                                    child: Text(
                                  '25',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.0),
                                ))
                              ],
                            ))),
                  ),
                  Card(
                    color: Colors.greenAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: InkWell(
                      child: Container(
                          color: Colors.transparent,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                margin:
                                    EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                                child: Text(
                                  'Forks',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                              Center(
                                  child: Text(
                                '4',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0),
                              ))
                            ],
                          )),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
