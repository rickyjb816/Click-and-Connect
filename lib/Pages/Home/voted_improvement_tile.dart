import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:oracle/Services/database.dart';
import 'package:oracle/models/improvement.dart';
import 'package:oracle/models/user.dart';
import 'package:oracle/shared/constants.dart';
import 'package:oracle/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'improvement_form.dart';

class VotedImprovementTile extends StatelessWidget {

  final VotedImprovement improvement;

  VotedImprovementTile({this.improvement});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: DatabaseService(uid: improvement.userUid).user,
      builder: (context, snapshot) {

        User user = snapshot.data;
        final account = Provider.of<User>(context);
        double width = MediaQuery.of(context).size.width/1.5;

        return user == null ? CircularProgressIndicator() : Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 20.0,
                    backgroundImage: Image.network(user.profileImage ?? '', loadingBuilder: (context, child, progress) {
                      return progress == null ? child : CircularProgressIndicator();
                    },).image,
                  ),
                  title: Text(improvement.title),
                  subtitle: Text(improvement.description),
                  onTap: () => openBottomSheet(context),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        width: width,
                        height: 25,
                        child: Stack(
                          children:[
                            LinearProgressIndicator(
                              value: _getUpVotePercentage().toDouble(),
                              backgroundColor: Colors.green[100],
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                              minHeight: 25,
                            ),
                            Center(child: Text('Yes: ' + _getUpVotePercentageString())),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        width: width,
                        height: 25,
                        child: Stack(
                          children:[
                            LinearProgressIndicator(
                              value: _getDownVotePercentage().toDouble(),
                              backgroundColor: Colors.red[100],
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                              minHeight: 25,
                            ),
                            Center(child: Text('No: ' + _getDownVotePercentageString())),
                          ],
                        ),
                      ),
                    )
                    /*RaisedButton(
                      //onPressed: () async {await DatabaseService(uid: improvement.uid).updateVote('up_votes', 1, 'up_vote_users', account.uid);},
                      color: Colors.green,
                      child: Text('For: ${improvement.upVote}'),
                    ),
                    RaisedButton(
                      onPressed: () async {await DatabaseService(uid: improvement.uid).updateVote('down_votes', 1, 'down_vote_users', account.uid);},
                      color: Colors.red,
                      child: Text('Against: ${improvement.downVote}'),
                    ),
                    RaisedButton(
                      onPressed: () {},
                      color: Colors.yellow,
                      child: Text(_getPercentage().toString()),
                    )*/
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

  String _getUpVotePercentageString() {
    double percentage = ((improvement.upVote/(improvement.upVote+improvement.downVote))*100);
    return percentage.isNaN ? '0%' : '${percentage.floor()}%';
  }

  String _getDownVotePercentageString() {
    double percentage = ((improvement.downVote/(improvement.upVote+improvement.downVote))*100);
    return percentage.isNaN ? '0%' : '${percentage.floor()}%';
  }

  double _getUpVotePercentage() {
    double percentage = ((improvement.upVote/(improvement.upVote+improvement.downVote)));
    return percentage;
  }

  double _getDownVotePercentage() {
    double percentage = ((improvement.downVote/(improvement.upVote+improvement.downVote)));
    return percentage;
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
