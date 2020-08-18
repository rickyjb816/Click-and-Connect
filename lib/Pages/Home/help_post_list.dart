import 'package:flutter/material.dart';
import 'package:oracle/models/help_posts.dart';
import 'package:oracle/models/home_posts.dart';
import 'package:provider/provider.dart';
import '../../models/improvement.dart';
import 'help_post_tile.dart';
import 'home_post_tile.dart';
import 'improvement_tile.dart';

class HelpPostList extends StatefulWidget {
  @override
  _HelpPostListState createState() => _HelpPostListState();
}

class _HelpPostListState extends State<HelpPostList> {
  @override
  Widget build(BuildContext context) {

    final helpPosts = Provider.of<List<HelpPost>>(context);

    return ListView.builder(
      itemCount: helpPosts.length,
      itemBuilder: (context, index) {
        return HelpPostTile(helpPost: helpPosts[index]);
      },
    );
  }
}