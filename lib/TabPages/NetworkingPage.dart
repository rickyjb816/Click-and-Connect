import 'package:flutter/material.dart';
import 'package:oracle/Pages/Home/LikesPage.dart';
import 'package:oracle/Services/database.dart';
import 'package:oracle/models/user.dart';
import 'package:oracle/shared/SwipeCard.dart';
import 'package:provider/provider.dart';

class NetworkingPage extends StatefulWidget {

  final User user;

  NetworkingPage({this.user});

  @override
  _NetworkingPageState createState() => _NetworkingPageState();
}

class _NetworkingPageState extends State<NetworkingPage> {


  int swipeCardIndex = 0;
  List<SwipeCardUser> swipeCardUser;
  User u;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    u = user;

    return StreamBuilder<List<SwipeCardUser>>(
      stream: DatabaseService(uid: user.uid, account: user).swipeCardUserProfile,
      builder: (context, snapshot) {
        swipeCardUser = snapshot.data;
        return Container(
            color: Colors.white,
            child: (Flex(
              direction: Axis.vertical,
              children:[
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.topRight,
                    child: FlatButton(
                      textColor: Colors.black,
                      child: Text("Likes"),
                      onPressed: () {
                        var route = ModalRoute.of(context).settings.name;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LikesPage(user: user), settings: RouteSettings(name: route)));
                      },
                    ),
                  ),
                ),
                Flexible(
                  flex: 10,
                  child: Center(
                      child: swipeCardUser.length <= 0 ? Text ("No More Users") : SwipeCard(user: swipeCardUser[0], operatingUser: user, nextCard: increaseIndex,)
                  ),
                ),
              ],
            )
            )
        );
      }
    );
  }

  void increaseIndex() {
    setState(() {
      //swipeCardIndex++;
      print(swipeCardUser.length);
      for(int i = 0; i < swipeCardUser.length; i++) {
          print(swipeCardUser[i].uid);
        }
    });
  }
}
