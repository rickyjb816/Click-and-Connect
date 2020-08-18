import 'package:flutter/material.dart';
import 'dart:async';
import 'package:oracle/Pages/Authenticate/welcome.dart';
import 'package:shimmer/shimmer.dart';

import '../wrapper.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();

    _mockCheckForSession().then(
        (status){
          if(status){
            _navigateToHome();
          }
        }
    );
  }

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(seconds: 1), (){});
    return true;
  }

  void _navigateToHome(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => Wrapper())
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset('assets/images/Click and Collect Logo.JPG')
            ],
          )
        )
      )
    );
  }
}
