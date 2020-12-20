import 'package:flutter/material.dart';
import 'package:oracle/Services/database.dart';
import 'package:oracle/models/user.dart';
import 'package:oracle/shared/constants.dart';
import 'package:provider/provider.dart';

class LikesTile extends StatelessWidget {

  final User like;
  final String operatingUserUid;

  LikesTile({this.like, this.operatingUserUid});

  //Make this use media query
  double size = 200;

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    print(like.likes);
    return SizedBox(
      height: size,
      width: size,
      child: Padding(
        padding: EdgeInsets.only(top: 8),
        child: Card(
          color: mainColor,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Stack(
                children:[
                  Image.network(
                    like.profileImage,
                    fit: BoxFit.cover,
                    width: size,
                    height: size,
                    loadingBuilder: (context, child, progress) {
                      return progress == null ? child : CircularProgressIndicator();
                    }),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size/3,
                          child: FlatButton(
                            shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            child: Icon(Icons.add),
                            onPressed: () async {
                              await DatabaseService().addToSeenToUser(like.uid, user.uid);
                              await DatabaseService().removeFromLikedUser(user, like.uid);
                              },
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(width: 15,),
                        SizedBox(
                          width: size/3,
                          child: FlatButton(
                            shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            child: Icon(Icons.add),
                            onPressed: () async {
                              await DatabaseService().addLikeToUser(user.uid, like.uid);
                              await DatabaseService().addToSeenToUser(like.uid, user.uid);
                              await DatabaseService().checkForMatchUser(like, user.uid);
                            },
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  )
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
