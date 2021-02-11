import 'dart:convert';
import 'package:collegem8/Models/user.dart';
import 'package:collegem8/Models/config.dart';
import 'package:collegem8/Models/webService.dart';
import 'package:http/http.dart' as http;

class Login {
  final String username;
  final String password;

  Login({this.username, this.password});

  Future<User> authenticate() async {
    String _body = this.toJsonString();
    final response = await WebService.webPost(Config.loginUrl, _body);

    if (response.statusCode == 200) {
      return User.parseUser(response.body);
    }
    throw Exception("Login Failed");
  }

  Map<String, dynamic> toJsonMap() => {
        'username': username,
        'password': password,
      };

  String toJsonString() {
    return jsonEncode(this.toJsonMap());
  }
}
