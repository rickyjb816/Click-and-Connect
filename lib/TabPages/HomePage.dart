import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oracle/Pages/Home/HelpPostCreation.dart';
import 'package:oracle/Pages/Home/HomePostCreation.dart';
import 'package:oracle/Pages/Home/help_post_list.dart';
import 'package:oracle/Pages/Home/home_post_list.dart';
import 'package:oracle/Services/database.dart';
import 'package:oracle/models/help_posts.dart';
import 'package:oracle/models/home_posts.dart';
import 'package:oracle/models/user.dart';
import 'package:oracle/shared/constants.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final int _numPages = 2;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return MultiProvider(
      providers:[
        StreamProvider<List<HomePost>>.value(value: DatabaseService().homePostList),
        StreamProvider<List<HelpPost>>.value(value: DatabaseService().helpPostList),
      ],
      child: Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton(backgroundColor: mainColor,
              onPressed: () {
                showModalBottomSheet(context: context, builder: (context) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 60.0),
                    child: _currentPage == 0 ? HomeCreationForm(userUID: user.uid) : HelpCreationForm(userUID: user.uid),
                  );
                });
              },
              child: Icon(Icons.add),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  _tabs(),
                  Container(
                    height: 600.0,
                    child: PageView(
                      physics: ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },

                      children: <Widget>[
                        HomePostList(),
                        HelpPostList()
                      ],
                    ),
                  ),
                ],
              ),
            ),

        )
    );
  }

  Widget _tabs() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: OutlineButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(0))),
              onPressed: () {
                _currentPage = 0;
                _pageController.jumpToPage(_currentPage);
              },
              borderSide: BorderSide(color: _currentPage == 0 ? Colors.black : Colors.grey),
              color: _currentPage == 0 ? Colors.white30 : Colors.grey,
              child: Icon(Icons.info_outline, color: _currentPage == 0 ? Colors.black : Colors.grey),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: OutlineButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(0))),
              borderSide: BorderSide(color: _currentPage == 1 ? Colors.black : Colors.grey),
              onPressed: () {
                _currentPage = 1;
                _pageController.jumpToPage(_currentPage);
              },
              color: _currentPage == 1 ? Colors.white30 : Colors.grey,
              child: Icon(Icons.error_outline, color: _currentPage == 1 ? Colors.black : Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
