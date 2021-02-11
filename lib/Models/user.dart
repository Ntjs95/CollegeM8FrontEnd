import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  static const String _userUrl =
      "https://collegem820210207221016.azurewebsites.net/api/User";
  final String userId;
  final String username;
  final String firstName;
  final String lastName;
  final String schoolName;
  final String programName;
  final String emailaddress;
  final String birthDate;

  User(
      {this.userId,
      this.username,
      this.firstName,
      this.lastName,
      this.schoolName,
      this.programName,
      this.emailaddress,
      this.birthDate});

  Map<String, dynamic> toJsonMap() => {
        'userId': userId,
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'schoolName': schoolName,
        'programName': programName,
        'emailAddress': emailaddress,
        'birthDate': birthDate,
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
}
