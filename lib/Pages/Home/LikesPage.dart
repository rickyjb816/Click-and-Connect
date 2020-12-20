import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:oracle/Services/database.dart';
import 'package:oracle/models/user.dart';
import 'package:oracle/shared/loading.dart';
import 'package:provider/provider.dart';

import 'LikesTile.dart';

class LikesPage extends StatefulWidget {

  final User user;

  LikesPage({this.user});

  @override
  _LikesPageState createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage> {
  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    return StreamBuilder<Object>(
      stream: DatabaseService(uid: widget.user.uid, account: widget.user).userWhoLiked,
      builder: (context, snapshot) {

        List<User> likes = snapshot.data;
        print(user.likes);
        return Scaffold(
          appBar: AppBar(title: Text('Likes'), centerTitle: true,),
            body: likes == null || user == null ? Loading() : StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        itemCount: likes.length,
        itemBuilder: (BuildContext context, int index) {
          return LikesTile(like: likes[index], operatingUserUid: user.uid,);
          },
        staggeredTileBuilder: (int index) => StaggeredTile.fit(1)
        ));
      }
      );
  }
}
