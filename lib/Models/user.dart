import 'dart:convert';
import 'package:collegem8/Models/webService.dart';
import 'package:http/http.dart' as http;
import 'package:collegem8/Models/config.dart';

class User {
  final String userId;
  final String username;
  final String firstName;
  final String lastName;
  final String schoolName;
  final String programName;
  final String emailaddress;
  final String birthDate;
  final String password;

  User(
      {this.userId,
      this.username,
      this.firstName,
      this.lastName,
      this.schoolName,
      this.programName,
      this.emailaddress,
      this.birthDate,
      this.password});

  Map<String, dynamic> toJsonMap() => {
        'userId': userId,
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'schoolName': schoolName,
        'programName': programName,
        'emailAddress': emailaddress,
        'birthDate': birthDate,
        'password': password,
      };

  String toJsonString() {
    return jsonEncode(this.toJsonMap());
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userId: json['userId'] as String,
        username: json["username"] as String,
        firstName: json["firstName"] as String,
        lastName: json["lastName"] as String,
        schoolName: json["schoolName"] as String,
        programName: json["programName"] as String,
        emailaddress: json["emailAddress"] as String,
        birthDate: json["birthDate"] as String);
  }

  static User parseUser(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return User.fromJson(parsed);
  }

  Future<User> createUser() async {
    final response =
        await WebService.webPost(Config.userUrl, this.toJsonString());
    if (response.statusCode == 200) {
      return User.parseUser(response.body);
    } else if (response.statusCode == 400) {
      throw Exception(
          response.body); // 400 Gives a description as to why it failed
    } else {
      throw Exception("Account creation failed.");
    }
  }
}
