import 'package:flutter/material.dart';
import 'package:oracle/Services/database.dart';
import 'package:oracle/models/help_posts.dart';
import 'package:oracle/models/home_posts.dart';
import 'package:oracle/models/improvement.dart';
import 'package:oracle/models/user.dart';
import 'package:oracle/shared/loading.dart';

import 'improvement_form.dart';

class HelpPostTile extends StatelessWidget {

  final HelpPost helpPost;

  HelpPostTile({this.helpPost});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: DatabaseService(uid: helpPost.userUid).user,
        builder: (context, snapshot) {

          User user = snapshot.data;

          return user == null ? CircularProgressIndicator() : Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Card(
                margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(user.profileImage),
                  ),
                  title: Text(helpPost.title),
                  subtitle: Text(helpPost.description),
                ),
              )
          );
        }
    );
  }
}