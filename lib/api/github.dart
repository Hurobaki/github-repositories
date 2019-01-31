import 'package:http/http.dart' as http;
import 'package:flutter_keychain/flutter_keychain.dart';
import '../model/user.dart';
import '../model/repo.dart';

import 'dart:convert';
import 'dart:async';

class GithubApi {
  static final String _urlApi = "https://api.github.com";

  static const String AUTH_URL = 'https://api.github.com/authorizations';

  static const String KEY_USERNAME = 'KEY_USERNAME';
  static const String KEY_PASSWORD = 'KEY_PASSWORD';
  static const String KEY_OAUTH_TOKEN = 'KEY_AUTH_TOKEN';
  static const String KEY_TTL = 'KEY_TTL';

  static const String CLIENT_ID = 'fe77458c2d3ad52adc14';
  static const String CLIENT_SECRET =
      '793d26867640e406f609d7753890ff3a6a03458b';

  String get username => _username;
  String get password => _password;
  String get token => _token;
  bool get loggedIn => _loggedIn;
  bool get initialized => _initialized;
  bool get ttlExpired => _ttlExpired;

  bool _loggedIn;
  bool _initialized;
  bool _ttlExpired;
  String _username;
  String _password;
  String _token;

  bool calculateTTLExpiration(DateTime ttl) {
    var difference = DateTime.now().difference(ttl);
    return difference.inHours > 11;
  }

  Future init() async {
    String username = await FlutterKeychain.get(key: KEY_USERNAME);
    String password = await FlutterKeychain.get(key: KEY_PASSWORD);
    String oauthToken = await FlutterKeychain.get(key: KEY_OAUTH_TOKEN);
    String ttl = await FlutterKeychain.get(key: KEY_TTL);

    if (ttl != null) {
      DateTime ttl = DateTime.parse(await FlutterKeychain.get(key: KEY_TTL));
      _ttlExpired = calculateTTLExpiration(ttl);
    }

    if (username == null || oauthToken == null) {
      await logout();
      _loggedIn = false;
    } else {
      _loggedIn = true;
      _username = username;
      _password = password;
      _token = oauthToken;
    }
    _initialized = true;
  }

  Future<UserModel> getUser(String username) async {
    var url = '$_urlApi/users/$username?access_token=$_token';
    Map<String, dynamic> decodedJSON = await _getJson(url);
    return UserModel.fromJson(decodedJSON);
  }

  Future<bool> login(String username, String password) async {
    var basicToken = _getEncodedAuthorization(username, password);
    final requestHeader = {'Authorization': 'Basic $basicToken'};

    final requestBody = json.encode({
      'client_id': CLIENT_ID,
      'client_secret': CLIENT_SECRET,
      'scopes': ['user', 'repo', 'notifications']
    });

    final loginResponse = await http.Client()
        .post('$AUTH_URL', headers: requestHeader, body: requestBody)
        .whenComplete(http.Client().close);

    if (loginResponse.statusCode == 201) {
      final bodyJson = json.decode(loginResponse.body);
      await _setCredentials(username, password, bodyJson['token']);
      _loggedIn = true;
    } else {
      _loggedIn = false;
    }

    return _loggedIn;
  }

  Future<List<RepoModel>> getRepos(String username) async {
    var url = '$_urlApi/users/$username/repos?access_token=$_token';
    var reposJSON = await _getJson(url);
    List<RepoModel> reposList = List<RepoModel>();
    for (var repo in reposJSON) {
      reposList.add(RepoModel.fromJson(repo));
    }
    return reposList;
  }

  Future<void> _setCredentials(
      String username, String password, String oauthToken) async {
    if (username == null || oauthToken == null) {
      await FlutterKeychain.clear();
    } else {
      await FlutterKeychain.put(key: KEY_USERNAME, value: username);
      await FlutterKeychain.put(key: KEY_PASSWORD, value: password);
      await FlutterKeychain.put(key: KEY_OAUTH_TOKEN, value: oauthToken);
      await FlutterKeychain.put(
          key: KEY_TTL, value: DateTime.now().toIso8601String());
    }

    _username = username;
    _password = password;
    _token = oauthToken;
  }

  Future logout() async {
    await _setCredentials(null, null, null);
    _loggedIn = false;
  }

  _getEncodedAuthorization(String username, String password) {
    final authorizationBytes = utf8.encode('$username:$password');
    return base64.encode(authorizationBytes);
  }

  Future _getJson(String url) async {
    try {
      final uri = Uri.parse(url);
      final httpResponse =
          await http.Client().get(uri).whenComplete(http.Client().close);
      if (httpResponse.statusCode != 200) {
        throw Exception('Error fetching data');
      }
      return (json.decode(httpResponse.body));
    } on Exception catch (e) {
      print('$e');
      throw (e);
    }
  }

  String toString() =>
      'GithubAPI(loggedIn = $_loggedIn, username = $_username)';
}
