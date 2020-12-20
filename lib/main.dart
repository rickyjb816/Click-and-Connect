import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oracle/shared/constants.dart';
import 'package:oracle/shared/loading.dart';
import 'package:oracle/wrapper.dart';
import 'package:provider/provider.dart';

import 'Pages/splash_screen.dart';
import 'Services/auth.dart';
import 'models/user.dart' as U;




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(name: 'Click And Connect',
      options: const FirebaseOptions(
          appId: '1:6655908590:android:15428f909da160b4c271ff',
          apiKey: 'AIzaSyCXe-y1DHNfSUGRF0Xh-lxgIrwfs7iVCIc',
          messagingSenderId: '6655908590',
          projectId: 'the-oracle-112b2'
      ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_){
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp (
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
                home: Scaffold(
                  body: Center(child: Text(snapshot.error.toString())),
                )
            );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<U.User>.value(
            value: AuthService().user,
            child: MaterialApp (
              theme: ThemeData(
                dividerTheme: DividerThemeData(
                    thickness: 3,
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
              home: Wrapper()
            ),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp (
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
            home: Scaffold(
              body: Center(child: Text("Loading")),
            )
        );
      },
    );
  }
}



