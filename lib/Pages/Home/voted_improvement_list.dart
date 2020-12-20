import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:oracle/Pages/Home/voted_improvement_tile.dart';
import 'package:oracle/shared/loading.dart';
import 'package:provider/provider.dart';
import '../../models/improvement.dart';
import 'improvement_tile.dart';

class VotedImprovementList extends StatefulWidget {
  @override
  _VotedImprovementListState createState() => _VotedImprovementListState();
}

class _VotedImprovementListState extends State<VotedImprovementList> {
  @override
  Widget build(BuildContext context) {

    final improvements = Provider.of<List<VotedImprovement>>(context);

    return improvements == null ? Loading() : ListView.builder(
        itemCount: improvements.length,
        itemBuilder: (context, index) {
          //getImage();
          return VotedImprovementTile(improvement: improvements[index]);
        },
    );
  }
}
