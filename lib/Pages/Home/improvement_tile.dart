import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:oracle/Services/database.dart';
import 'package:oracle/models/improvement.dart';
import 'package:oracle/models/user.dart';

import 'improvement_form.dart';

class ImprovementTile extends StatelessWidget {

  final Improvement improvement;

  ImprovementTile({this.improvement});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: DatabaseService(uid: improvement.userUid).user,
      builder: (context, snapshot) {

        User user = snapshot.data;

        return Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(user.profileImage),
                  ),
                  title: Text(improvement.title),
                  subtitle: Text(improvement.description),
                  onTap: () => openBottomSheet(context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      onPressed: () async {await DatabaseService(uid: improvement.uid).updateVote('up_votes', 1, 'up_vote_users', improvement.userUid);},
                      color: Colors.green,
                      child: Text('For: ${improvement.upVote}'),
                    ),
                    RaisedButton(
                      onPressed: () async {await DatabaseService(uid: improvement.uid).updateVote('down_votes', 1, 'down_vote_users', improvement.userUid);},
                      color: Colors.red,
                      child: Text('Against: ${improvement.downVote}'),
                    ),
                    RaisedButton(
                      onPressed: () {},
                      color: Colors.yellow,
                      child: Text(_getPercentage().toString()),
                    )
                  ],
                ),

              ],
            ),
          )
        );
      }
    );
  }

  _getPercentage() {
    double percentage = ((improvement.upVote/(improvement.upVote+improvement.downVote))*100);
    return percentage.isNaN ? '0%' : '${percentage.floor()}%';
  }

  void openBottomSheet(BuildContext context) {
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
        child: ImprovementForm(improvementUID: improvement.uid),
      );
    });
  }
}
