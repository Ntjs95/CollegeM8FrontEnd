import 'package:collegem8/Models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'models/login.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  String _username;
  String _password;
  Text _screenText = new Text("Sign in...");
  int _buttonSignInState = 0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildUsername() {
    return TextFormField(
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(labelText: "Username"),
      validator: (String value) {
        if (value.isEmpty) {
          return "Username is required.";
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
      autocorrect: false,
      enableSuggestions: false,
      obscureText: true,
      decoration: InputDecoration(labelText: "Password"),
      validator: (String value) {
        if (value.isEmpty) {
          return "Password is required.";
        }
        return null;
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  ElevatedButton _buildSignInButton() {
    return ElevatedButton(
      child: setUpButtonChild(),
      onPressed: () {
        attemptSignIn();
      },
    );
  }

  void attemptSignIn() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save textbox values into the class.
      // if is valid...
      Login login = new Login(username: _username, password: _password);
      Future<User> user = login.authenticate();
      user.then((value) {
        _buttonSignInState = 2;
        setState(() {});
      }).catchError((err) {
        Text txtLoginFailed = new Text(
          "Username/password incorrect",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        );
        _screenText = txtLoginFailed;
        _buttonSignInState = 0;
        setState(() {});
      });
      _buttonSignInState = 1;
      setState(() {});
    }
  }

  Widget setUpButtonChild() {
    if (_buttonSignInState == 0) {
      return new Text(
        "Sign In",
        style: TextStyle(color: Colors.white, fontSize: 16),
      );
    } else if (_buttonSignInState == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign In")),
      body: Container(
        margin: EdgeInsets.all(240),
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _screenText,
                _buildUsername(),
                _buildPassword(),
                SizedBox(height: 100),
                _buildSignInButton()
              ]),
        ),
      ),
    );
  }
}
