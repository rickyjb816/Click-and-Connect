import 'package:flutter/material.dart';
import 'package:oracle/Services/database.dart';
import 'package:oracle/models/home_posts.dart';
import 'package:oracle/models/improvement.dart';
import 'package:oracle/models/user.dart';

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

        return Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Card(
              margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(user.profileImage),
                ),
                title: Text(homePost.title),
                subtitle: Text(homePost.description),
              ),
            )
        );
      }
    );
  }
}