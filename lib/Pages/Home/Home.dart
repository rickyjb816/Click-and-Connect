import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oracle/Pages/Home/LikesPage.dart';
import 'package:oracle/Pages/Home/Messages.dart';
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

  final User user;

  Home({this.user});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 2;
  List<String> titles = ['Profile', 'Home', 'Networking', 'Improvements', 'Settings'];



  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);
    //print(user.likes);
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(value: DatabaseService(uid: widget.user.uid).user),
        //StreamProvider<List<Improvement>>.value(value: DatabaseService(uid: widget.user.uid, account: widget.user).improvementsList),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(titles[_currentIndex]),
          centerTitle: true,
          backgroundColor: mainColor,
          actions: [
            /*FlatButton(
              textColor: Colors.white,
              child: Icon(Icons.message),
              onPressed: () {
                var route = ModalRoute.of(context).settings.name;
                Navigator.push(context, MaterialPageRoute(builder: (context) => Messages(), settings: RouteSettings(name: route)));
              },
            )*/
          ],
        ),
        body: callPage(_currentIndex, user),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            selectedItemColor: mainColor,
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

  Widget callPage(int index, User user){
    switch(index)
    {
      case 0:{ //Profile Page
        return ProfilePage(userUid: widget.user.uid,);
      }
      case 1:{ //Home Page
        return HomePage();
      }
      case 2:{ //Networking Page
        return NetworkingPage(user: widget.user);
      }
      case 3:{ //Improvement Page
        return ImprovementsPage(user: widget.user);
      }
      case 4:{ //Settings Page
        return SettingsPage();
      }
    }
  }
}


