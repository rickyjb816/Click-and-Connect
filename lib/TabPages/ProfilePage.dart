import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oracle/Pages/Home/help_post_list.dart';
import 'package:oracle/Pages/Home/home_post_list.dart';
import 'package:oracle/Pages/Home/profile_links_tile.dart';
import 'package:oracle/Services/database.dart';
import 'package:oracle/models/help_posts.dart';
import 'package:oracle/models/home_posts.dart';
import 'package:oracle/models/user.dart';
import 'package:oracle/shared/loading.dart';
import 'package:polygon_clipper/polygon_border.dart';
import 'package:polygon_clipper/polygon_clipper.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String _fullName;//Full name
  String _email;//Email
  int _points;//Points
  String _location;//Location
  String _businessName;//Business Name
  String _jobTitle;//Job Title
  String _profileImage; //Profile Image

  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<Object>(
      stream: DatabaseService(uid: user.uid).user,
      builder: (context, snapshot) {
        if(snapshot.hasData) {

          User user = snapshot.data;
          _fullName = user.fullName;
          _email = user.email;
          _points = user.points;
          _location = user.location;
          _businessName = user.businessName;
          _jobTitle = user.jobTitle;
          _profileImage = user.profileImage;

          return SingleChildScrollView(
            child: Container(
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 40),
                        CircleAvatar(
                          radius: 85,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: NetworkImage(_profileImage),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.control_point), //Need to change to Trophy
                                Text('Points: $_points'),
                              ],
                            ),
                            SizedBox(width: 25,),
                            Row(
                              children: [
                                Icon(Icons.account_balance),
                                Text('Business: $_businessName', maxLines: 1, softWrap: false, overflow: TextOverflow.clip), //Text Can be too long and doesn't wrap
                              ],
                            )
                          ],
                        ),
                        Divider(),
                        Text('Job Title: $_jobTitle'),
                        Divider(),
                        Text('Location: $_location'),
                        Divider(),
                        _skills(skills: user.skills),
                        Divider(),
                        _currentObjectives(currentObjectives: user.currentObjectives.replaceAll("\\n", "\n")),
                        Divider(),
                        _tabs(),
                        Container(
                          height: 1500,
                          child: PageView(
                            physics: ClampingScrollPhysics(),
                            controller: _pageController,
                            onPageChanged: (int page) {
                              setState(() {
                                _currentPage = page;
                              });
                            },

                            children: <Widget>[
                              _informationTab(user: user),
                              _postsTab(),
                              _helpPostsTab(userUid: user.uid,)
                            ],
                          ),
                        ),
                      ]
                  ),
                )
            ),
          );
        }else{
          return Loading();
        }
      });
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: OutlineButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(0))),
              onPressed: () {
                _currentPage = 2;
                _pageController.jumpToPage(_currentPage);
              },
              borderSide: BorderSide(color: _currentPage == 2 ? Colors.black : Colors.grey),
              color: _currentPage == 2 ? Colors.white30 : Colors.grey,
              child: Icon(Icons.help_outline, color: _currentPage == 2 ? Colors.black : Colors.grey,),
            ),
          ),
        ),
      ],
    );
  }
}

class _skills extends StatelessWidget {

  final List<String> skills;

  _skills({this.skills});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: skills.length,
        itemBuilder: (context, index) {
          //getImage();
          return Row(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                //margin: EdgeInsets.only(right: 4),
                decoration: ShapeDecoration(
                  shape: PolygonBorder(
                    rotate: 90,
                    sides: 6,
                    borderRadius: 8,
                    border: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                child: Text(skills[index]),
              )
            ],
          );
        },
      ),
    );
  }
}

class _currentObjectives extends StatelessWidget {

  final String currentObjectives;

  _currentObjectives({this.currentObjectives});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Text('Current Objectives: $currentObjectives', textAlign: TextAlign.left,)
      ),
    );
  }
}

class _informationTab extends StatelessWidget {

  final User user;

  _informationTab({this.user});

  double titleFontSize = 20;
  double textFontSize = 18;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //About You
          Text('About You', style: TextStyle(decoration: TextDecoration.underline, fontSize: titleFontSize)),
          Text('Age: ' + _getYears(user.age), style: TextStyle(fontSize: textFontSize)),
          Text('Gender: ${user.gender}', style: TextStyle(fontSize: textFontSize)),
          SizedBox(height: 20,),

          //What Do you Consider yourself to be?
          Text('What Do you Consider yourself to be?', style: TextStyle(decoration: TextDecoration.underline, fontSize: titleFontSize)),
          ListView.builder(
            shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: user.titles.length,
              itemBuilder: (context, index) {
                return Text(String.fromCharCode(0x2022) + ' ' + user.titles[index], style: TextStyle(fontSize: textFontSize));
            }
            ),
          SizedBox(height: 20),

          //What Are you Looking For?
          Text('What Are you Looking For?', style: TextStyle(decoration: TextDecoration.underline, fontSize: titleFontSize)),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: user.lookingFor.length,
              itemBuilder: (context, index) {
                return Text(String.fromCharCode(0x2022) + ' ' + user.lookingFor[index], style: TextStyle(fontSize: textFontSize));
              }
          ),
          SizedBox(height: 20),

          //How Many Years Experience do you have?
          Text('How Many Years Experience do you have?', style: TextStyle(decoration: TextDecoration.underline, fontSize: titleFontSize)),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: user.experience.length,
              itemBuilder: (context, index) {
                return Text(String.fromCharCode(0x2022) + ' ' + user.experience[index].area + ' - ' + _getYears(user.experience[index].years) + ' years', style: TextStyle(fontSize: textFontSize));
              }
          ),
          SizedBox(height: 20),

          //What's Your Highest Qualification?
          Text("What's Your Highest Qualification?", style: TextStyle(decoration: TextDecoration.underline, fontSize: titleFontSize)),
          Text("Highest Qualification: ${user.qaulification.type}", style: TextStyle(fontSize: textFontSize)),
          Text("Area of Qualification ${user.qaulification.subjectArea}", style: TextStyle(fontSize: textFontSize)),
          SizedBox(height: 20),

          //What are your interests?
          Text("What are your interests?", style: TextStyle(decoration: TextDecoration.underline, fontSize: titleFontSize)),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: user.interests.length,
              itemBuilder: (context, index) {
                return Text(String.fromCharCode(0x2022) + ' ' + user.interests[index], style: TextStyle(fontSize: textFontSize));
              }
          ),
          SizedBox(height: 20),

          //What are you looking to improve?
          Text("What are you looking to improve?", style: TextStyle(decoration: TextDecoration.underline, fontSize: titleFontSize)),
          Text(user.improvements.replaceAll("\\n", "\n"), style: TextStyle(fontSize: textFontSize)),

          Divider(),
          _profileLinks(profileLinks: user.profileLinks,),
        ],
      ),
    );
  }

  String _getYears(Timestamp date) {
    final start = date.toDate();
    final todaysDate = DateTime.now();
    final difference = todaysDate.difference(start);
    return (difference.inDays/365).floor().toString();
  }
}

class _profileLinks extends StatelessWidget {

  final List<ProfileLinks> profileLinks;

  _profileLinks({this.profileLinks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: profileLinks.length,
        itemBuilder: (context, index) {
          return ProfileLinksTile(platform: profileLinks[index].platform, url: profileLinks[index].url);
        }
     );
  }
}


class _postsTab extends StatelessWidget {

  final userUid;

  _postsTab({this.userUid});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<HomePost>>.value(
        value: DatabaseService(uid: userUid).homePostListFromUser,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: HomePostList(),
        )
    );
  }
}

class _helpPostsTab extends StatelessWidget {

  final userUid;

  _helpPostsTab({this.userUid});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<HelpPost>>.value(
      value: DatabaseService(uid: userUid).helpPostListFromUser,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: HelpPostList(),
        )
    );
  }
}







