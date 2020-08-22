import 'package:flutter/material.dart';
import 'package:oracle/models/home_posts.dart';
import 'package:oracle/shared/loading.dart';
import 'package:provider/provider.dart';
import '../../models/improvement.dart';
import 'home_post_tile.dart';
import 'improvement_tile.dart';

class HomePostList extends StatefulWidget {
  @override
  _HomePostListState createState() => _HomePostListState();
}

class _HomePostListState extends State<HomePostList> {
  @override
  Widget build(BuildContext context) {

    final homePosts = Provider.of<List<HomePost>>(context);

    return homePosts == null ? Loading() : ListView.builder(
      itemCount: homePosts.length,
      itemBuilder: (context, index) {
        return HomePostTile(homePost: homePosts[index]);
      },
    );
  }
}