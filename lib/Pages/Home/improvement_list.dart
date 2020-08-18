import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/improvement.dart';
import 'improvement_tile.dart';

class ImprovementList extends StatefulWidget {
  @override
  _ImprovementListState createState() => _ImprovementListState();
}

class _ImprovementListState extends State<ImprovementList> {
  @override
  Widget build(BuildContext context) {

    final improvements = Provider.of<List<Improvement>>(context);

    return ListView.builder(
        itemCount: improvements.length,
        itemBuilder: (context, index) {
          //getImage();
          return ImprovementTile(improvement: improvements[index]);
        },
    );
  }
}
