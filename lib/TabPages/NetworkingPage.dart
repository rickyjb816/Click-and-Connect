import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oracle/models/user.dart';
import 'package:provider/provider.dart';

class NetworkingPage extends StatefulWidget {
  @override
  _NetworkingPageState createState() => _NetworkingPageState();
}

class _NetworkingPageState extends State<NetworkingPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
            child: Text('Networking')
        )
    );
  }
}
