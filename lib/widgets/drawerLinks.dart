import 'package:flutter/material.dart';
import '../api/github.dart';

class DrawerLinks extends StatelessWidget {
  final GithubApi _githubApi;

  DrawerLinks(this._githubApi);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, 'home');
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.search),
          title: Text('Repositories'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, 'repos');
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.search),
          title: Text('Repositories V2'),
        ),
        Divider(),
        ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              _githubApi.logout().then((_) {
                Navigator.pushReplacementNamed(context, 'login');
              });
            })
      ],
    );
  }
}
