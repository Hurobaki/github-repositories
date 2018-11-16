import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../widgets/drawerLinks.dart';
import '../api/github.dart';
import '../model/user.dart';

import 'dart:async';
import 'dart:io';

class DrawerScreen extends StatefulWidget {
  final GithubApi _githubApi;

  DrawerScreen(this._githubApi);

  DrawerScreenState createState() => DrawerScreenState(_githubApi);
}

class DrawerScreenState extends State<DrawerScreen> {
  final GithubApi _githubApi;

  DrawerScreenState(this._githubApi);

  String accountName = "";
  String accountEmail = "";
  String accountAvatar = "https://via.placeholder.com/150";

  _getCurrentUser() async {
    UserModel currentUser = await _githubApi.getUser(_githubApi.username);
    if (currentUser != null) {
      setState(() {
        accountAvatar = currentUser.avatarUrl;
        accountName = currentUser.login;
        accountEmail = currentUser.email;
      });
    }
  }

  initState() {
    super.initState();
    _getCurrentUser();
  }

  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  accountName: Text(accountName),
                  accountEmail: Text(accountEmail),
                  currentAccountPicture: CachedNetworkImage(
                    imageUrl: accountAvatar,
                    placeholder: CircularProgressIndicator(),
                    errorWidget: Icon(Icons.error),
                  ),
                ),
              ),
              Container(child: DrawerLinks(_githubApi)),
            ],
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                margin: EdgeInsets.only(bottom: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10.0),
                      child: Icon(FontAwesomeIcons.twitter),
                    ),
                    Container(
                      child: IconButton(
                          icon: Icon(FontAwesomeIcons.github),
                          onPressed: () {
                            print('pressed');
                          }),
                    )
                  ],
                )))
      ],
    ));
  }
}
