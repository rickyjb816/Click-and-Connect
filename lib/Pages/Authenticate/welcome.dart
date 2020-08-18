import 'package:flutter/material.dart';
import 'package:oracle/Pages/Authenticate/signIn.dart';
import 'package:oracle/Pages/Authenticate/signUp.dart';

class welcome extends StatefulWidget {
  @override
  _welcomeState createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {

  bool showSignIn = true;

  @override
  Widget build(BuildContext context) {
    return showSignIn ? LoginPage(toggleView: toggleView) : SignUp(toggleView: toggleView);
  }


  void navigateToSignIn(){
    Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage(), fullscreenDialog: true));
  }

  void navigateToSignUp(){
    Navigator.push(context,MaterialPageRoute(builder: (context) => SignUp(), fullscreenDialog: true));
  }

  void toggleView(){
    setState(() => showSignIn = !showSignIn);
  }
}
