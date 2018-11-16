import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import '../api/github.dart';

import '../screens/homeScreen.dart';
import '../screens/loginScreen.dart';
import '../screens/repositoriesScreen.dart';
import '../screens/repositoryDetailScreen.dart';

typedef Widget HandlerFunc(BuildContext context, Map<String, dynamic> params);

HandlerFunc homeHandler(GithubApi githubApi) {
  return (BuildContext context, Map<String, dynamic> params) =>
      HomeScreen(githubApi);
}

HandlerFunc loginHandler(GithubApi githubApi) {
  return (BuildContext context, Map<String, dynamic> params) =>
      LoginScreen(githubApi);
}

HandlerFunc reposHandler(GithubApi githubApi) {
  return (BuildContext context, Map<String, dynamic> params) =>
      RepositoriesScreen(githubApi);
}

HandlerFunc repoDetailHandler(GithubApi githubApi) {
  return (BuildContext context, Map<String, dynamic> params) =>
      RepositoryDetailScreen(githubApi, params['owner'][0], params['repo'][0]);
}

void configureRouter(Router router, GithubApi githubApi) {
  router.define('/home', handler: Handler(handlerFunc: homeHandler(githubApi)));

  router.define('/login',
      handler: Handler(handlerFunc: loginHandler(githubApi)));

  router.define('/repos',
      handler: Handler(handlerFunc: reposHandler(githubApi)));

  router.define('/repos/:owner/:repo',
      handler: Handler(handlerFunc: repoDetailHandler(githubApi)));
}
