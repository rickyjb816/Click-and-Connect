import 'package:flutter/material.dart';
import 'package:oracle/Services/database.dart';
import 'package:oracle/shared/constants.dart';


class HelpCreationForm extends StatefulWidget {

  final String userUID;
  HelpCreationForm({this.userUID});

  @override
  _HelpCreationFormState createState() => _HelpCreationFormState();
}

class _HelpCreationFormState extends State<HelpCreationForm> {

  final _formKey = GlobalKey<FormState>();

  //Form Values
  String _title = '';//Improvement Title
  String _description = '';//Improvement Description

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //await DatabaseService().addNewImprovement(widget.userUID, "Test Title", "Test Description");
    //Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text("Write a Help Post"),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: 'Title'),
            validator: (val) => val.isEmpty ? 'Please Enter a Title' : null,
            onChanged: (val) => setState(() => _title = val),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: 'Description'),
            validator: (val) => val.isEmpty ? 'Please Enter a Description' : null,
            onChanged: (val) => setState(() => _description = val),
          ),
          SizedBox(height: 20.0),
          RaisedButton(
            onPressed: () async {
              final formState = _formKey.currentState;
              if(formState.validate()){
                await DatabaseService().addNewHelpPost(widget.userUID, _title, _description);
                Navigator.pop(context);
              }
            },
            child: Text('Add Improvement'),
          ),
        ],
      ),
    );
  }
}
