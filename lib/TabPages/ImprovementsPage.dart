import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oracle/Pages/Home/improvement_creation_form.dart';
import 'package:oracle/main.dart';
import 'package:oracle/models/user.dart';
import 'package:oracle/shared/constants.dart';
import 'package:oracle/shared/loading.dart';
import 'package:provider/provider.dart';
import '../Services/database.dart';
import '../Pages/Home/improvement_list.dart';
import 'package:oracle/models/improvement.dart';

class ImprovementsPage extends StatefulWidget {
  @override
  _ImprovementsPageState createState() => _ImprovementsPageState();
}

class _ImprovementsPageState extends State<ImprovementsPage> {


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<List<Improvement>>(
      stream: DatabaseService().improvementsList,
      builder: (context, snapshot) {
        return snapshot.connectionState != ConnectionState.active ? Loading() : Scaffold(
          backgroundColor: Colors.white,
          body: ImprovementList(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: mainColor,
            onPressed: () {
              showModalBottomSheet(context: context, builder: (context) {
                return Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 60.0),
                  child: ImprovementCreationForm(userUID: user.uid),
                );
              });
            },
            child: Icon(Icons.add),
          ),
        );
      }
    );
  }
}
