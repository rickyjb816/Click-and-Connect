import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oracle/Services/database.dart';
import 'package:oracle/models/home_posts.dart';
import 'package:oracle/models/improvement.dart';
import 'package:oracle/models/user.dart';
import 'package:oracle/shared/constants.dart';
import 'package:oracle/shared/loading.dart';

import 'improvement_form.dart';

class HomePostTile extends StatelessWidget {

  final HomePost homePost;

  HomePostTile({this.homePost});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: DatabaseService(uid: homePost.userUid).user,
      builder: (context, snapshot) {

        User user = snapshot.data;

        return StreamBuilder<DocumentSnapshot>(
          stream: DatabaseService(uid: homePost.uid).homeLikeStream(user.uid),
          builder: (context, snapshot) {

            bool didLike = snapshot.data.exists;

            return user == null ? CircularProgressIndicator() : Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Card(
                  margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 25.0,
                          backgroundImage: NetworkImage(user.profileImage),
                        ),
                        title: Text(user.fullName, textScaleFactor: 0.75, style: TextStyle(color: mainColor)),
                        subtitle: Text(homePost.description, textScaleFactor: 1.25, style: TextStyle(color: Colors.black),),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FlatButton(
                            color: mainColor,
                            child: Text(didLike ? 'Liked' : 'Like'),
                            onPressed: () async {
                              if(didLike) {
                                await DatabaseService(uid: homePost.uid).removeLikeToHomePost(user.uid);
                                }
                              else {
                                await DatabaseService(uid: homePost.uid).addLikeToHomePost(user.uid);
                                }

                              },
                          ),
                          FlatButton(
                            color: mainColor,
                            child: Text('Comment'),
                            onPressed: () {},
                          )
                        ],
                      )
                    ],
                  ),
                )
            );
          }
        );
      }
    );
  }
}