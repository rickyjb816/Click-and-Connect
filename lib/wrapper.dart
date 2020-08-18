import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Pages/Authenticate/welcome.dart';
import 'Pages/Home/Home.dart';
import 'models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //Return either Home or Authenticate Widget based on if user is signed in
    final user = Provider.of<User>(context);

    return user == null ? welcome() : Home();
  }
}
