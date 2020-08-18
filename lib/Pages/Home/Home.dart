import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oracle/TabPages/HomePage.dart';
import 'package:oracle/TabPages/ImprovementsPage.dart';
import 'package:oracle/TabPages/NetworkingPage.dart';
import 'package:oracle/TabPages/ProfilePage.dart';
import 'package:oracle/TabPages/SettingsPage.dart';
import 'package:oracle/models/user.dart';
import 'package:oracle/shared/constants.dart';
import '../../Services/database.dart';
import 'package:provider/provider.dart';
import '../../models/improvement.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 2;
  List<String> titles = ['Profile', 'Home', 'Networking', 'Improvements', 'Settings'];



  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Improvement>>.value(
      value: DatabaseService().improvementsList,
      child: Scaffold(
        appBar: AppBar(
          title: Text(titles[_currentIndex]),
          backgroundColor: mainColor,
        ),
        body: callPage(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('Profile'),
                backgroundColor: Colors.white
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Home'),
                  backgroundColor: Colors.white
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.alternate_email),
                  title: Text('Networking'),
                  backgroundColor: Colors.white
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.lightbulb_outline),
                  title: Text('Improvements'),
                  backgroundColor: Colors.white
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  title: Text('Settings'),
                  backgroundColor: Colors.white,
              )
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
          },
        ),
      ),
    );
  }

  Widget callPage(int index){
    switch(index)
    {
      case 0:{ //Profile Page
        return ProfilePage();
      }
      case 1:{ //Home Page
        return HomePage();
      }
      case 2:{ //Networking Page
        return NetworkingPage();
      }
      case 3:{ //Improvement Page
        return ImprovementsPage();
      }
      case 4:{ //Settings Page
        return SettingsPage();
      }
    }
  }
}


