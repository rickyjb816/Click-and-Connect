import 'package:flutter/material.dart';
import 'package:oracle/models/user.dart';

class MessenagerTile extends StatelessWidget {

  final User user;

  MessenagerTile({this.user});

  @override
  Widget build(BuildContext context) {
    return user == null ? CircularProgressIndicator() : Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(user.profileImage),
            ),
            title: Text(user.fullName),
            //subtitle: Text(homePost.description),
          ),
        )
    );
  }
}
