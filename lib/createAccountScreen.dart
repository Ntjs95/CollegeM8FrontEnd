import 'package:collegem8/Models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  String _username;
  String _password;
  String _passwordConfirm;
  String _firstName;
  String _lastName;
  String _schoolName;
  String _programName;
  String _emailAddress;
  String _birthDate;

  final alphanumericPattern = RegExp(r'^[a-zA-Z0-9]+$');
  final alphaPattern = RegExp(r'^[a-zA-Z]+$');
  final passwordPattern = new RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  final emailPattern = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  Widget _buildUsername() {
    return TextFormField(
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(labelText: "Username"),
      validator: (String value) {
        if (value.isEmpty) {
          return "Username is required.";
        } else if (!alphanumericPattern.hasMatch(value) ||
            value.length <= 4 ||
            value.length > 20) {
          return "Username must be between 5-20 letters/numbers";
        }
        return null;
      },
      onSaved: (String value) {
        _username = value;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      controller: _passwordController,
      autocorrect: false,
      enableSuggestions: false,
      obscureText: true,
      decoration: InputDecoration(labelText: "Password"),
      validator: (String value) {
        if (value.isEmpty) {
          return "Password is required.";
        } else if (value.length <= 4 || value.length > 20) {
          return "Password must be between 5-20 length.";
        } else if (!passwordPattern.hasMatch(value)) {
          return "Password must have 1 uppercase letter, 1 lowercase letter, 1 number, AND 1 special character.";
        }
        return null;
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  Widget _buildPasswordConfirm() {
    return TextFormField(
      autocorrect: false,
      enableSuggestions: false,
      obscureText: true,
      decoration: InputDecoration(labelText: "Confirm Password"),
      validator: (String value) {
        if (_passwordController.text != value) {
          return "Passwords must match.";
        }
        return null;
      },
      onSaved: (String value) {
        _passwordConfirm = value;
      },
    );
  }

  Widget _buildFirstName() {
    return TextFormField(
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(labelText: "First Name"),
      validator: (String value) {
        if (value.isEmpty) {
          return "First name is required.";
        } else if (value.length >= 32) {
          return "First name must be less than 32 letters.";
        } else if (!alphaPattern.hasMatch(value)) {
          return "First name must only contain letters";
        }
        return null;
      },
      onSaved: (String value) {
        _firstName = value;
      },
    );
  }

  Widget _buildLastName() {
    return TextFormField(
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(labelText: "Last Name"),
      validator: (String value) {
        if (value.isEmpty) {
          return "Last name is required.";
        } else if (value.length >= 32) {
          return "Last name must be less than 32 letters.";
        } else if (!alphaPattern.hasMatch(value)) {
          return "Last name must only contain letters";
        }
        return null;
      },
      onSaved: (String value) {
        _lastName = value;
      },
    );
  }

  Widget _buildSchoolName() {
    return TextFormField(
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(labelText: "School Name"),
      validator: (String value) {
        if (value.isEmpty) {
          return "School name is required.";
        } else if (value.length >= 50) {
          return "School name must be less than 50 letters.";
        } else if (!alphanumericPattern.hasMatch(value)) {
          return "School name must only contain letters/numbers";
        }
        return null;
      },
      onSaved: (String value) {
        _schoolName = value;
      },
    );
  }

  Widget _buildProgramName() {
    return TextFormField(
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(labelText: "Program Name"),
      validator: (String value) {
        if (value.isEmpty) {
          return "Program name is required.";
        } else if (value.length >= 50) {
          return "Program name must be less than 50 letters.";
        } else if (!alphanumericPattern.hasMatch(value)) {
          return "Program name must only contain letters/numbers";
        }
        return null;
      },
      onSaved: (String value) {
        _programName = value;
      },
    );
  }

  Widget _buildEmailAddress() {
    return TextFormField(
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(labelText: "Email Address"),
      validator: (String value) {
        if (value.isEmpty) {
          return "Email address is required.";
        } else if (value.length >= 50) {
          return "Email address must be less than 50 letters.";
        } else if (!emailPattern.hasMatch(value)) {
          return "Email address must be a valid email address.";
        }
        return null;
      },
      onSaved: (String value) {
        _emailAddress = value;
      },
    );
  }

  Widget _buildBirthDate() {
    final format = DateFormat("yyyy-MM-dd");
    return Column(children: <Widget>[
      Text('Basic date field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Account")),
      body: Container(
        margin: EdgeInsets.all(240),
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Enter widgets here
              ]),
        ),
      ),
    );
  }
}
