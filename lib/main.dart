import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oracle/shared/constants.dart';
import 'package:oracle/wrapper.dart';
import 'package:provider/provider.dart';

import 'Pages/splash_screen.dart';
import 'Services/auth.dart';
import 'models/user.dart';




void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_){
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
        child: MaterialApp (
          theme: ThemeData(
            dividerTheme: DividerThemeData(
              thickness: 1,
              indent: 10,
              endIndent: 10,
              color: Colors.black,
              space: 40
            ),
            buttonTheme: ButtonThemeData(
              buttonColor: mainColor,
              shape: buttonShape,
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
      )
    );
  }
}



