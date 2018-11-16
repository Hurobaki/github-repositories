import 'package:flutter/material.dart';
import '../api/github.dart';
import '../model/repo.dart';
import '../model/user.dart';
import '../screens/drawerScreen.dart';

import 'dart:async';

class RepositoriesScreen extends StatefulWidget {
  final GithubApi _githubApi;

  RepositoriesScreen(this._githubApi);

  RepositoriesScreenState createState() => RepositoriesScreenState(_githubApi);
}

class RepositoriesScreenState extends State<RepositoriesScreen> {
  final GithubApi _githubApi;
  int _count = 0;
  List<RepoModel> reposList = [];
  UserModel userModel;
  bool loading = true;

  RepositoriesScreenState(this._githubApi);

  initState() {
    super.initState();
    getUserData(_githubApi.username);
  }

  void getUserData(String username) async {
    var repos = await _githubApi.getRepos(username);
    print(repos[0]);
    if (repos != null) {
      setState(() {
        reposList = repos;
        loading = false;
      });
    } else {
      // handle error fetch repos
    }

    var user = await _githubApi.getUser(username);
    if (user != null) {
      setState(() {
        userModel = user;
      });
    } else {
      // handle error fetch user
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerScreen(_githubApi),
        appBar: AppBar(
          title: Text('Repositories'),
        ),
        body: RefreshIndicator(
            onRefresh: _handleRefresh, child: _waitDisplaying()));
  }

  Widget _waitDisplaying() {
    return loading
        ? (Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          )))
        : (ListView.builder(
            itemCount: reposList.length,
            itemBuilder: _buildBody,
          ));
  }

  Widget _buildBody(BuildContext context, int index) {
    final RepoModel repo = reposList[index];

    var repoContent = Column(
      children: <Widget>[
        ListTile(
          isThreeLine: false,
          leading: CircleAvatar(
            child: Image.network(
              'https://assets-cdn.github.com/images/modules/logos_page/Octocat.png',
              width: 20.0,
              height: 20.0,
            ),
          ),
          title: Text(repo.name),
        ),
        Divider(),
      ],
    );

    return GestureDetector(
      child: repoContent,
      onTap: () {
        _navigateToRepo(repo);
      },
    );
  }

  Future<Null> _handleRefresh() async {
    return null;
  }

  _navigateToRepo(RepoModel repo) {
    Navigator.pushNamed(context, '/repos/${repo.owner.login}/${repo.name}');
  }
}
