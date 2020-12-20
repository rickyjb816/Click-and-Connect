import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oracle/Services/database.dart';
import 'package:oracle/TabPages/ProfilePage.dart';
import 'package:oracle/models/user.dart';
import 'package:provider/provider.dart';

class SwipeCard extends StatelessWidget {

  final SwipeCardUser user;
  final User operatingUser;
  final Function nextCard;

  SwipeCard({this.user, this.operatingUser, this.nextCard});

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width/1;
    double height = MediaQuery.of(context).size.height/2;
    User mainUser = Provider.of<User>(context);

    return Scaffold(
      body: Container(
        color: Colors.white60,
        constraints: BoxConstraints.expand(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Column(
              children: [
                GestureDetector(
                  onHorizontalDragEnd: (details) async {
                    if (details.primaryVelocity > 0) {
                      // Page forwards
                      print('Move page forwards');
                      await DatabaseService().addLikeToUser(operatingUser.uid, user.uid);
                      await DatabaseService().addToSeenToUser(user.uid, operatingUser.uid);
                      await DatabaseService().checkForMatchSwipeCard(user, operatingUser.uid);
                      nextCard();
                    } else if (details.primaryVelocity < 0) {
                      // Page backwards
                      print('Move page backwards');
                      await DatabaseService().addToSeenToUser(user.uid, operatingUser.uid);
                      await DatabaseService().removeFromLikedUser(mainUser, user.uid);
                      nextCard();
                    }
                  },
                    onTap: () {
                      var route = ModalRoute.of(context).settings.name;
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(userUid: user.uid), settings: RouteSettings(name: route)));
                      },
                    child: Image.network(user.profilePicture, height: height, width: width, fit: BoxFit.fill,)),
                Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('${user.name}', style: TextStyle(fontSize: 20,),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('${user.businessName}', style: TextStyle(fontSize: 20)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: SizedBox(
                          width: 300,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            //crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                  child: RaisedButton(
                                    color: Colors.red,
                                    onPressed: () async {
                                      await DatabaseService().addToSeenToUser(user.uid, operatingUser.uid);
                                      await DatabaseService().removeFromLikedUser(mainUser, user.uid);
                                      nextCard();
                                      },
                                  )
                              ),
                              SizedBox(width: 50,),
                              Expanded(
                                  child: RaisedButton(
                                      color: Colors.green,
                                      onPressed: () async {
                                        await DatabaseService().addLikeToUser(operatingUser.uid, user.uid);
                                        await DatabaseService().addToSeenToUser(user.uid, operatingUser.uid);
                                        await DatabaseService().checkForMatchSwipeCard(user, operatingUser.uid);
                                        nextCard();
                                      }
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
