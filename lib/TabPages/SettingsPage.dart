import 'package:flutter/material.dart';
import 'package:oracle/Legals/end_user_agreement.dart';
import 'package:oracle/Services/auth.dart';
import 'package:oracle/Services/database.dart';
import 'package:oracle/Theme.dart';
import 'package:oracle/models/user.dart';
import 'package:oracle/shared/constants.dart';
import 'package:oracle/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:package_info/package_info.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final AuthService _auth = AuthService();

  bool notificationSettings;
  bool lightDarkMode;
  bool visibility;

  @override
  Widget build(BuildContext context) {

    String appName;
    String version;

    final user = Provider.of<User>(context);
    //final _themeChanger = Provider.of<ThemeChanger>(context);

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
    });

    return StreamBuilder<UserSettings>(
      stream: DatabaseService(uid: user.uid).userSettings,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserSettings userSettings = snapshot.data;

          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /*Row(
                    children: [
                      Text('Notifications'),
                      Switch(
                        value: notificationSettings ?? userSettings.notifications,
                        onChanged: (val) async {
                          setState(() async {
                            notificationSettings = val;
                            await DatabaseService(uid: userSettings.uid).updateUserSettings('settings_notifications', notificationSettings);
                            //Needs to update the notification settings so it doesn't send them to the user or does depending on the setting
                          }
                          );
                        },
                      ),
                    ],
                  ),*/
                  /*Row(
                    children: [
                      Text('Dark Mode'),
                      Switch(
                        value: lightDarkMode ?? userSettings.lightDarkMode,
                        onChanged: (val) async {
                          setState(() async {
                            lightDarkMode = val;
                            //update Theme
                            await DatabaseService(uid: userSettings.uid).updateUserSettings('settings_light_dark_mode', lightDarkMode);
                            //_themeChanger.setTheme(val ? ThemeData.dark() : ThemeData.light());
                          }
                          );
                        },
                      ),
                    ],
                  ),*/
                  /*Row(
                    children: [
                      Text('Visibility'),
                      Switch(
                        value: visibility ?? userSettings.visibility,
                        onChanged: (val) async {
                          setState(() async {
                            visibility = val;
                            await DatabaseService(uid: userSettings.uid).updateUserSettings('settings_visibility', visibility);
                            //Doesn't Need to do anything just need to make sure this is checked when searching
                          }
                          );
                        },
                      ),
                    ],
                  ),*/
                  Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                          shape: buttonShape,
                          color: buttonColor,
                          textColor: buttonTextColor,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EndUserAgreement()));
                          },
                          child: Text('End User Agreement'),
                        ),
                      ),
                      SizedBox(width: 10,),
                      /*Expanded(
                        child: RaisedButton(
                          shape: buttonShape,
                          color: buttonColor,
                          textColor: buttonTextColor,
                          onPressed: () {
                            showAboutDialog(
                                context: context,
                                applicationName: 'Click and Connect',
                                applicationLegalese: 'This is a test for the Help and Support'
                            );
                            //Would like a better way of displaying this
                          },
                          child: Text('Help and Support'),
                        ),
                      ),*/
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                          shape: buttonShape,
                          color: buttonColor,
                          textColor: buttonTextColor,
                          onPressed: () async {
                            await _auth.signOut();
                          },
                          child: Text('Sign out'),
                        ),
                      ),
                      SizedBox(width: 10,),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                          shape: buttonShape,
                          color: Colors.red,
                          textColor: buttonTextColor,
                          onPressed: () async {
                            await _auth.deleteAccount();
                          },
                          child: Text('Delete Account'),
                        ),
                      ),
                      SizedBox(width: 10,),
                    ],
                  ),
                  Center(child: Text('$appName version:$version')),
                ],
              ),
            ),
          );
        } else {
          return Loading();
        }
      }
    );
  }
}
