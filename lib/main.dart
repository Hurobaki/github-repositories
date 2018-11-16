import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'routes/routes.dart';
import 'api/github.dart';

import 'screens/splashScreen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Router router = new Router();
  final GithubApi githubApi = GithubApi();

  MyApp() {
    configureRouter(router, githubApi);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Raleway',
          textTheme: Theme.of(context).textTheme.copyWith(
//                body1: new TextStyle(color: Colors.red),
                body2: TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold), // new
              ),
          primaryColor: Colors.blue,
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(githubApi),
        onGenerateRoute: router.generator);
  }
}
