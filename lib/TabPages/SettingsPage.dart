import 'package:flutter/material.dart';
import 'package:oracle/Services/auth.dart';
import 'package:oracle/Services/database.dart';
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
                  Row(
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
                  ),
                  Row(
                    children: [
                      Text('Light Mode'),
                      Switch(
                        value: lightDarkMode ?? userSettings.lightDarkMode,
                        onChanged: (val) async {
                          setState(() async {
                            lightDarkMode = val;
                            //update Theme
                            await DatabaseService(uid: userSettings.uid).updateUserSettings('settings_light_dark_mode', lightDarkMode);
                          }
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
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
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                          shape: buttonShape,
                          color: buttonColor,
                          textColor: buttonTextColor,
                          onPressed: () {
                            showAboutDialog(
                              context: context,
                              applicationName: 'Click and Connect',
                              applicationLegalese: 'This is a test for the legal information'
                            );
                            //Would like a better way of displaying this
                          },
                          child: Text('Legal Information'),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
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
                      ),
                    ],
                  ),

                  RaisedButton(
                    shape: buttonShape,
                    color: buttonColor,
                    textColor: buttonTextColor,
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    child: Text('Sign out'),
                  ),
                  RaisedButton(
                    shape: buttonShape,
                    color: Colors.red,
                    textColor: buttonTextColor,
                    onPressed: () async {
                      await _auth.deleteAccount();
                    },
                    child: Text('Delete Account'),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      await DatabaseService(uid: userSettings.uid).updateUserPoints(10);
                    },
                    child: Text('Increase Points -- Debug'),
                  ),
                  Text('$appName version:$version'),
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
