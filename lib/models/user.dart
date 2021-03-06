import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oracle/models/improvement.dart';

class User{

  final String uid;
  final String fullName;//Full name
  final String email;//Email
  final int points;//Points
  final String location;//Location
  final String businessName;//Business Name
  final String jobTitle;//Job Title
  final String profileImage;
  final List<String> skills;
  final String currentObjectives;
  final Timestamp age;
  final String gender;
  final List<String> titles; //ie Mentor, investor, etc
  final List<String> lookingFor;
  final List<Experience> experience;  //How Many Years of experience in each area
  final Qualification qaulification;  //Highest Qualification
  final List<String> interests;  //Interests
  final String improvements;
  //Areas Of Improvements

  List<ProfileLinks> profileLinks;

  List<String> networkingSeenAccounts; //list of people this account has already seen - no need to show them again, also wipe after a week or something
  List<String> votes;
  List<String> likes;
  List<String> matches;

  //Main Skills (should only be 5)

  User({
    this.uid,
    this.fullName,
    this.email,
    this.points,
    this.location,
    this.businessName,
    this.jobTitle,
    this.profileImage,
    this.skills,
    this.currentObjectives,
    this.age,
    this.gender,
    this.titles,
    this.lookingFor,
    this.experience,
    this.qaulification,
    this.interests,
    this.improvements,
    this.profileLinks,
    this.networkingSeenAccounts,
    this.votes,
    this.likes,
    this.matches,
  });
}

class UserSettings {

  final String uid;
  final bool notifications;
  final bool lightDarkMode;
  final bool visibility;

  UserSettings({this.uid, this.notifications, this.lightDarkMode, this.visibility});
}

class ProfileLinks {
  final String platform;
  final String url;

  ProfileLinks({this.platform, this.url});
}

class Experience {
  final String area;
  final Timestamp years;

  Experience({this.area, this.years});
}

class Qualification {
  final String type;
  final String subjectArea;

  Qualification({this.type, this.subjectArea});
}

class SwipeCardUser {
  final String uid;
  final String name;
  final String profilePicture;
  final String businessName;
  List<String> likes;

  SwipeCardUser({this.uid, this.name, this.profilePicture, this.businessName, this.likes});
}