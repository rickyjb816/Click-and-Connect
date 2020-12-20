import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oracle/Pages/Home/improvement_creation_form.dart';
import 'package:oracle/Pages/Home/voted_improvement_list.dart';
import 'package:oracle/main.dart';
import 'package:oracle/models/user.dart';
import 'package:oracle/shared/constants.dart';
import 'package:oracle/shared/loading.dart';
import 'package:provider/provider.dart';
import '../Services/database.dart';
import '../Pages/Home/improvement_list.dart';
import 'package:oracle/models/improvement.dart';

class ImprovementsPage extends StatefulWidget {

  final User user;

  ImprovementsPage({this.user});

  @override
  _ImprovementsPageState createState() => _ImprovementsPageState();
}

class _ImprovementsPageState extends State<ImprovementsPage> {

  final int _numPages = 2;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return MultiProvider(
      providers: [
        StreamProvider<List<Improvement>>.value(value: DatabaseService(account: user).improvementsList),
        StreamProvider<List<VotedImprovement>>.value(value: DatabaseService(account: user).improvementsVotedList),
      ],
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              _tabs(),
              Container(
                height: MediaQuery.of(context).size.height-188,
                child: PageView(
                  physics: ClampingScrollPhysics(), //ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: <Widget>[
                    ImprovementList(),
                    VotedImprovementList()
                  ],
                ),
              ),
            ],
          ),

          floatingActionButton: FloatingActionButton(
            backgroundColor: mainColor,
            onPressed: () {
              showModalBottomSheet(context: context, builder: (context) {
                return Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 60.0),
                  child: ImprovementCreationForm(userUID: widget.user.uid),
                );
              });
            },
            child: Icon(Icons.add),
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

