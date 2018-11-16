import 'package:flutter/material.dart';
import '../api/github.dart';

class RepositoryDetailScreen extends StatefulWidget {
  final GithubApi _githubApi;
  final String _ownerName;
  final String _repoName;

  RepositoryDetailScreen(this._githubApi, this._ownerName, this._repoName);

  RepositoryDetailScreenState createState() =>
      RepositoryDetailScreenState(_githubApi, _ownerName, _repoName);
}

class RepositoryDetailScreenState extends State<RepositoryDetailScreen> {
  final GithubApi _githubApi;
  final String _ownerName;
  final String _repoName;

  RepositoryDetailScreenState(this._githubApi, this._ownerName, this._repoName);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('$_repoName detail'),
        ),
        body: Text('Repo detail $_repoName'));
  }
}
