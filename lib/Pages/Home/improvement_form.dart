import 'package:flutter/material.dart';
import 'package:oracle/Services/database.dart';
import 'package:oracle/shared/constants.dart';
import 'package:oracle/models/improvement.dart';
import 'package:oracle/shared/loading.dart';

class ImprovementForm extends StatefulWidget {
  @override
  _ImprovementFormState createState() => _ImprovementFormState();


  final String improvementUID;
  ImprovementForm({this.improvementUID});
}

class _ImprovementFormState extends State<ImprovementForm> {

  final _formKey = GlobalKey<FormState>();

  //Form Values
  String _userUid; //User's UID for other data
  String _title;//Improvement Title
  String _description;//Improvement Description
  int _upVote;//Improvement Up Vote Counter
  int _downVote;//Improvement Down Vote Counter

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Improvement>(
      stream: DatabaseService(uid: widget.improvementUID).improvement,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          Improvement improvement = snapshot.data;

          _upVote = improvement.upVote;
          _downVote = improvement.downVote;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(_title ?? improvement.title,
                    style: TextStyle(fontSize: 18.0)
                ),
                SizedBox(height: 20.0),
                Text(_description ?? improvement.description,
                    style: TextStyle(fontSize: 18.0)
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.green,
                  onPressed: () async {
                    await DatabaseService(uid: widget.improvementUID).updateVote('up_votes', 1, 'up_vote_users', improvement.userUid);
                  },
                  child: Text('Up Vote: $_upVote'),
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.red,
                  onPressed: () async {
                    await DatabaseService(uid: widget.improvementUID).updateVote('down_votes', 1, 'down_vote_users', improvement.userUid);
                  },
                  child: Text('Down Vote: $_downVote'),
                )
              ],
            ),
          );
        }
        else{
          return Loading();
        }
      }
    );
  }
}
