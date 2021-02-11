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
  String _birthDateStr;

  final alphanumericPattern = RegExp(r'^[a-zA-Z0-9]+$');
  final alphanumericSpacePattern = RegExp(r'^[a-zA-Z0-9 ]+$');
  final passwordPattern = new RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{4,}$');
  final emailPattern = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  int _createAccountButtonState = 0;
  Text _screenText = new Text("Create Account");

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
        } else if (!alphanumericSpacePattern.hasMatch(value)) {
          return "First name must not contain special characters.";
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
        } else if (!alphanumericSpacePattern.hasMatch(value)) {
          return "Last name must not contain special characters.";
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
        } else if (!alphanumericSpacePattern.hasMatch(value)) {
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
        } else if (!alphanumericSpacePattern.hasMatch(value)) {
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
    return DateTimeField(
      decoration: InputDecoration(labelText: "Birth Date"),
      format: format,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
      },
      validator: (DateTime date) {
        DateTime today = DateTime.now();
        if (date == null) {
          return "You must choose a date.";
        } else if (date.day == today.day &&
            date.month == today.month &&
            date.year == today.year) {
          return "You must choose a date.";
        } else if (today.year - 13 < date.year) {
          // Scuffed age check TODO update with month logic
          return "You are too young to use this site.";
        }
        return null;
      },
      onSaved: (date) {
        _birthDateStr = date.toIso8601String();
      },
    );
  }

  ElevatedButton _buildCreateAccountButton() {
    return ElevatedButton(
      child: setUpButtonChild(),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save(); // Save textbox values into the class.
          attemptCreateAccount();
        }
      },
    );
  }

  Widget setUpButtonChild() {
    if (_createAccountButtonState == 0) {
      return new Text(
        "Create Account",
        style: TextStyle(color: Colors.white, fontSize: 16),
      );
    } else if (_createAccountButtonState == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  void attemptCreateAccount() {
    User user = new User(
        username: _username,
        firstName: _firstName,
        lastName: _lastName,
        schoolName: _schoolName,
        programName: _programName,
        emailaddress: _emailAddress,
        birthDate: _birthDateStr,
        password: _password);
    Future<User> createdAccount = user.createUser();
    createdAccount.then((value) {
      _createAccountButtonState = 2;
      setState(() {});
    }).catchError((err) {
      Text txtAccountCreatedFailed = new Text(
        err.toString(),
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      );
      // Change text on screen
      _createAccountButtonState = 0;
      _screenText = txtAccountCreatedFailed;
      setState(() {});
    });
    _createAccountButtonState = 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Create Account")),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _screenText,
                _buildUsername(),
                _buildPassword(),
                _buildPasswordConfirm(),
                _buildEmailAddress(),
                _buildFirstName(),
                _buildLastName(),
                _buildBirthDate(),
                _buildSchoolName(),
                _buildProgramName(),
                _buildCreateAccountButton()
              ]),
        ),
      ),
    );
  }
}
