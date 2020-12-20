import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oracle/Services/database.dart';
import 'package:provider/provider.dart';
import 'Pages/Authenticate/welcome.dart';
import 'Pages/Home/Home.dart';
import 'models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //Return either Home or Authenticate Widget based on if user is signed in
    final user = Provider.of<User>(context);
    //createSecondApp();
    return user == null ? welcome() : Home(user: user);
  }

  /*Future<void> createSecondApp() async {
    await Firebase.initializeApp(
        name: 'Click And Collect',
        options: const FirebaseOptions(
            appId: '1:6655908590:android:15428f909da160b4c271ff',
            apiKey: 'AIzaSyCXe-y1DHNfSUGRF0Xh-lxgIrwfs7iVCIc',
            messagingSenderId: '6655908590',
            projectId: 'the-oracle-112b2'
        )
    );*/

    /*      name: 'Click And Collect',
      options: const FirebaseOptions(
          appId: '1:6655908590:android:15428f909da160b4c271ff',
          apiKey: 'AIzaSyCXe-y1DHNfSUGRF0Xh-lxgIrwfs7iVCIc',
          messagingSenderId: '6655908590',
          projectId: 'the-oracle-112b2')*/
}

