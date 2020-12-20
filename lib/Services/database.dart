import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:oracle/models/help_posts.dart';
import 'package:oracle/models/user.dart';
import 'package:uuid/uuid.dart';
import '../models/improvement.dart';
import '../Pages/Home/improvement_list.dart';
import '../models/home_posts.dart';

class DatabaseService {

  final String uid;
  final User account;

  DatabaseService({ this.uid, this.account});

  //Collection Reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('Users');
  final CollectionReference improvementsCollection = FirebaseFirestore.instance.collection('Improvements');
  final CollectionReference homePostsCollection = FirebaseFirestore.instance.collection('HomePosts');
  final CollectionReference helpPostsCollection = FirebaseFirestore.instance.collection('HelpPosts');


  Future updateUserData(String name, String email, String businessName,
      String jobTitle, String location, String profileImage) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'email': email,
      'business_name': businessName,
      'job_title': jobTitle,
      'points': 0,
      'location': location,
      'settings_notifications': true,
      'settings_light_dark_mode': true,
      'settings_visibility': true,
      'profile_image': profileImage,
      'age': Timestamp.fromDate(new DateTime.now()),
      'skills': FieldValue.arrayUnion([]),
      'current_objectives': "",
      'gender': "Other",
      'titles': FieldValue.arrayUnion([]),
      'looking_for': FieldValue.arrayUnion([]),
      'experience': FieldValue.arrayUnion([]),
      'qual_subject_area': "",
      'qual_type': "",
      'seen': FieldValue.arrayUnion([uid]),
      'likes': FieldValue.arrayUnion([]),
      'interests': FieldValue.arrayUnion([]),
      'improvements': "",
      'profile_links': FieldValue.arrayUnion([]),
      'user_uid': uid,
      'votes': FieldValue.arrayUnion(['non']),
      'matches': FieldValue.arrayUnion([]),
    });
  }

  Future updateUser(String jobTitle, String name, String location, String businessName, String currentObjectives, Qualification qualification, List<String> skills, List<String> lookingFor, List<String> titles, List<String> interests, String improvements, String gender, Timestamp age, bool hasImageChanged, File image, String imageName, List<ProfileLinks> profileLinks, List<Experience> experience) async {
    var url;
    var filePath;
    String imageDownloadURL;

    if(hasImageChanged) {
      final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://the-oracle-112b2.appspot.com/');

      UploadTask _uploadTask;


      filePath = 'images/${Uuid().v4()}.png';
      _uploadTask = _storage.ref().child(filePath).putFile(image);
      //_uploadTask.snapshotEvents.
      //var storageSnapshot = await _uploadTask.onComplete;
      //url = await storageSnapshot.ref.getDownloadURL();
      //_uploadTask.whenComplete(() async => {imageDownloadURL = await _storage.ref().child(filePath).getDownloadURL()});
      _uploadTask.snapshotEvents.listen((event) {
        print(event.state);
      });
      _uploadTask.then((TaskSnapshot taskSnapshot) async {
        print(taskSnapshot.state);
        imageDownloadURL = await taskSnapshot.ref.getDownloadURL();
        await userCollection.doc(uid).update({
          'profile_image': imageDownloadURL ?? imageName,
        });
      });
      //Reference ref = await _storage.ref().child(filePath);
      //String url = (await _uploadTask.).snapshot.ref.getDownloadURL();
      //imageDownloadURL = await ref.getDownloadURL();
      url = imageDownloadURL;
    }
    
    List<Map<String, String>> map = new List<Map<String, String>>();
    List<Map<String, dynamic>> map1 = new List<Map<String, dynamic>>();

    for(int i = 0; i < profileLinks.length; i++) {
      map.add({'platform' : profileLinks[i].platform, 'url' : profileLinks[i].url});
    }

    for(int i = 0; i < experience.length; i++) {
      map1.add({'area' : experience[i].area, 'years' : experience[i].years});
    }
    
    return await userCollection.doc(uid).update({
      'job_title': jobTitle,
      'name': name,
      'location': location,
      'business_name': businessName,
      'current_objectives': currentObjectives,
      'qual_subject_area': qualification.subjectArea,
      'qual_type': qualification.type,
      'skills': FieldValue.arrayUnion(skills),
      'looking_for': FieldValue.arrayUnion(lookingFor),
      'titles': FieldValue.arrayUnion(titles),
      'interests': FieldValue.arrayUnion(interests),
      'improvements': improvements,
      'gender': gender,
      'age': age,
      'profile_image': imageDownloadURL ?? imageName,
      'profile_links': FieldValue.arrayUnion(map),
      'experience': FieldValue.arrayUnion(map1),
    });
  }

  Future updateUserSettings(String field, bool val) async {
    return await userCollection.doc(uid).update({
      field: val,
    });
  }

  //Updates Users points
  Future updateUserPoints(int increase) async {
    return await userCollection.document(uid).updateData({
      'points': FieldValue.increment(increase)
    });
  }

  Future deleteUserData() async {
    return userCollection.document(uid).delete();
  }

  Future<String> getImage(String profileImage) async {
    FirebaseStorage firebaseStorage = FirebaseStorage(
        storageBucket: 'gs://the-oracle-112b2.appspot.com');
    String Test = firebaseStorage.ref()
        .child(profileImage)
        .getDownloadURL().toString();
    return Test;
  }

  //Updates Improvement Vote
  Future updateVote(String nameField, int value, String voteField, String userUID) async {
    //Need this to only work based on if a user has voted or not, otherwise don't let them vote again

    String votingFieldName = "";
    if(nameField == "up_votes"){
      votingFieldName = "up_voters";
    }
    else if(nameField == "down_votes"){
      votingFieldName = "down_voters";
    }
    await userCollection.doc(userUID).update({
      'votes': FieldValue.arrayUnion([uid]),
    });
    return await improvementsCollection.doc(uid).update({
      nameField: FieldValue.increment(value),
      votingFieldName: FieldValue.arrayUnion([userUID]),
    });
  }

  Future addNewImprovement(String userUid, String title,
      String description) async {

    return await improvementsCollection.doc().set({
      'user_uid': userUid,
      'title': title,
      'description': description,
      'up_votes': 0,
      'down_votes': 0,
      'up_voters': FieldValue.arrayUnion([]),
      'down_voters': FieldValue.arrayUnion([]),
      'creation_date': Timestamp.now(),
      //Add two lists for who has up voted and down voted
    });
  }

  Future addNewHomePost(String userUid, String title,
      String description) async {

    return await homePostsCollection.doc().set({
      'user_uid': userUid,
      'title': title,
      'description': description,
      'creation_date': Timestamp.now(),
      //Add two lists for who has up voted and down voted
    });
  }

  Future addNewHelpPost(String userUid, String title,
      String description) async {

    return await helpPostsCollection.doc().set({
      'user_uid': userUid,
      'title': title,
      'description': description,
      'creation_date': Timestamp.now(),
      //Add two lists for who has up voted and down voted
    });
  }

  Future addLikeToHomePost(String useruid) async {
    return await homePostsCollection.doc(uid).collection('likes').doc(useruid).set({});
  }

  Future removeLikeToHomePost(String useruid) async {
    return await homePostsCollection.doc(uid).collection('likes').doc(useruid).delete();
  }

  Stream<DocumentSnapshot> homeLikeStream(String useruid) {
    final ref = homePostsCollection.doc(uid).collection('likes').doc(useruid);

    return ref.snapshots();
  }

  Future addLikeToHelpPost(String useruid) async {
    return await helpPostsCollection.doc(uid).collection('likes').doc(useruid).set({});
  }

  Future removeLikeToHelpPost(String useruid) async {
    return await helpPostsCollection.doc(uid).collection('likes').doc(useruid).delete();
  }

  Stream<DocumentSnapshot> helpLikeStream(String useruid) {
    final ref = helpPostsCollection.doc(uid).collection('likes').doc(useruid);

    return ref.snapshots();
  }

  Future addLikeToUser(String likedUserUid, String UserUid) async {
    return await userCollection.document(UserUid).updateData({
      'likes': FieldValue.arrayUnion([likedUserUid]),
    });
  }

  Future addToSeenToUser(String seenUserUid, String UserUid) async {
    return await userCollection.document(UserUid).updateData({
      'seen': FieldValue.arrayUnion([seenUserUid]),
    });
  }

  //User Settings from snapshot
  UserSettings _userSettingsFromSnapshot(DocumentSnapshot snapshot) {
    return UserSettings(
      uid: uid,
      notifications: snapshot.data()['settings_notifications'],
      lightDarkMode: snapshot.data()['settings_light_dark_mode'],
      visibility: snapshot.data()['settings_visibility'],
    );
  }

  //User Settings from snapshot
  User _userFromSnapshot(DocumentSnapshot snapshot) {
    return User(
      uid: uid,
      fullName: snapshot.data()['name'],
      email: snapshot.data()['email'],
      points: snapshot.data()['points'],
      location: snapshot.data()['location'],
      businessName: snapshot.data()['business_name'],
      jobTitle: snapshot.data()['job_title'],
      profileImage: snapshot.data()['profile_image'],
      skills: List.from(snapshot.data()['skills']),
      currentObjectives: snapshot.data()['current_objectives'],
      age: snapshot.data()['age'],
      gender: snapshot.data()['gender'],
      titles: List.from(snapshot.data()['titles']),
      lookingFor: List.from(snapshot.data()['looking_for']),
      experience: List<Experience>.from(snapshot.data()['experience'].map((item) {
        return Experience(area: item['area'], years: item['years']);
      })),
      qaulification: Qualification(type: snapshot.data()['qual_type'],
          subjectArea: snapshot.data()['qual_subject_area']),
      interests: List.from(snapshot.data()['interests']),
      improvements: snapshot.data()['improvements'],
      profileLinks: List<ProfileLinks>.from(
          snapshot.data()['profile_links'].map((item) {
            return ProfileLinks(platform: item['platform'], url: item['url']);
          })),
      networkingSeenAccounts: List.from(snapshot.data()['seen']),
      votes: List.from(snapshot.data()['votes']),
      likes: List.from(snapshot.data()['likes']),
      matches: List.from(snapshot.data()['matches']),
    );
  }

  Future checkForMatchSwipeCard(SwipeCardUser user, String operatingUserUid) {
    if(user.likes.contains(operatingUserUid)) {
      userCollection.doc(operatingUserUid).update(
          {'matches': FieldValue.arrayUnion([user.uid])});
      userCollection.doc(user.uid).update(
          {'matches': FieldValue.arrayUnion([operatingUserUid])});
      userCollection.doc(operatingUserUid).update(
          {'likes': FieldValue.arrayRemove([user.uid])});
      return userCollection.doc(operatingUserUid).update(
          {'likes': FieldValue.arrayRemove([user.uid])});
    }
  }

  Future checkForMatchUser(User user, String operatingUserUid) {
    if(user.likes.contains(operatingUserUid)) {
      userCollection.doc(operatingUserUid).update(
          {'matches': FieldValue.arrayUnion([user.uid])});
      userCollection.doc(user.uid).update(
          {'matches': FieldValue.arrayUnion([operatingUserUid])});
      userCollection.doc(operatingUserUid).update(
          {'likes': FieldValue.arrayRemove([user.uid])});
      return userCollection.doc(operatingUserUid).update(
          {'likes': FieldValue.arrayRemove([user.uid])});
    }
  }

  Future removeFromLikedUser(User user, String operatingUserUid) {
    if(user.likes.contains(operatingUserUid)) {
      return userCollection.doc(operatingUserUid).update(
          {'likes': FieldValue.arrayRemove([user.uid])});
    }
  }

  List<Improvement> _improvementListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Improvement(
        uid: doc.id,
        userUid: doc.data()['user_uid'] ?? '',
        title: doc.data()['title'] ?? '',
        description: doc.data()['description'] ?? '',
        upVote: doc.data()['up_votes'] ?? 0,
        downVote: doc.data()['down_votes'] ?? 0,
      );
    }).toList();
  }

  List<VotedImprovement> _improvementVotedListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return VotedImprovement(
        uid: doc.id,
        userUid: doc.data()['user_uid'] ?? '',
        title: doc.data()['title'] ?? '',
        description: doc.data()['description'] ?? '',
        upVote: doc.data()['up_votes'] ?? 0,
        downVote: doc.data()['down_votes'] ?? 0,
        upVoters: List.from(doc.data()['up_voters']),
        downVoters: List.from(doc.data()['down_voters']),
      );
    }).toList();
  }

  Improvement _improvementFromSnapshot(DocumentSnapshot snapshot) {
    return Improvement(
      uid: snapshot.id,
      userUid: snapshot.data()['user_uid'] ?? '',
      title: snapshot.data()['title'] ?? '',
      description: snapshot.data()['description'] ?? '',
      upVote: snapshot.data()['up_votes'] ?? 0,
      downVote: snapshot.data()['down_votes'] ?? 0,
    );
  }

  HomePost _homePostFromSnapshot(DocumentSnapshot snapshot) {
    return HomePost(
      uid: snapshot.id,
      userUid: snapshot.data()['user_uid'] ?? '',
      title: snapshot.data()['title'] ?? '',
      description: snapshot.data()['description'] ?? '',
    );
  }

  List<HomePost> _homePostListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return HomePost(
        uid: doc.id,
        userUid: doc.data()['user_uid'] ?? '',
        title: doc.data()['title'] ?? '',
        description: doc.data()['description'] ?? '',
      );
    }).toList();
  }

  HelpPost _helpPostFromSnapshot(DocumentSnapshot snapshot) {
    return HelpPost(
      uid: snapshot.id,
      userUid: snapshot.data()['user_uid'] ?? '',
      title: snapshot.data()['title'] ?? '',
      description: snapshot.data()['description'] ?? '',
    );
  }

  List<HelpPost> _helpPostListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return HelpPost(
        uid: doc.id,
        userUid: doc.data()['user_uid'] ?? '',
        title: doc.data()['title'] ?? '',
        description: doc.data()['description'] ?? '',
      );
    }).toList();
  }

  List<SwipeCardUser> _SwipeCardListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return SwipeCardUser(
        uid: doc.data()['user_uid'] ?? doc.id,
        name: doc.data()['name'] ?? '',
        businessName: doc.data()['business_name'] ?? '',
        profilePicture: doc.data()['profile_image'] ?? '',
        likes: List.from(doc.data()['likes']),
      );
    }).toList();
  }

  //Streams

  //TODO order from newest first
  Stream<List<Improvement>> get improvementsList {
    return improvementsCollection
        .where(FieldPath.documentId, whereNotIn: account.votes)
        //.orderBy('creation_date', descending: false)
        .limit(10).snapshots() //Will be paginated soon
        .map(_improvementListFromSnapshot);
  }

  //TODO order from newest first
  Stream<List<VotedImprovement>> get improvementsVotedList {
    return improvementsCollection
        .where(FieldPath.documentId, whereIn: account.votes)
        .limit(10) //Will be paginated soon
        .snapshots()
        .map(_improvementVotedListFromSnapshot);
  }

  List<User> _UserListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return User(
          uid: doc.data()['user_uid'] ?? doc.id,
          fullName: doc.data()['name'],
          profileImage: doc.data()['profile_image'],
          likes: List.from(doc.data()['likes']),
      );
    }).toList();
  }

  Stream<Improvement> get improvement {
    return improvementsCollection.document(uid)
        .snapshots()
        .map(_improvementFromSnapshot);
  }

  //get User doc stream
  Stream<UserSettings> get userSettings {
    return userCollection.document(uid)
        .snapshots()
        .map(_userSettingsFromSnapshot);
  }

  //get User doc stream
  Stream<User> get user {
    return userCollection.document(uid).snapshots()
        .map(_userFromSnapshot);
  }

  Stream<HomePost> get homepost {
    return homePostsCollection.document(uid).snapshots()
        .map(_homePostFromSnapshot);
  }

  Stream<List<HomePost>> get homePostList {
    return homePostsCollection.snapshots()
        .map(_homePostListFromSnapshot);
  }

  Stream<List<HomePost>> get homePostListFromUser {
    return homePostsCollection
        .where('user_uid', isEqualTo: uid)
    //.orderBy('creation_date', descending: false)
        .snapshots()
        .map(_homePostListFromSnapshot);
  }

  Stream<List<HelpPost>> get helpPostList {
    return helpPostsCollection.snapshots()
        .map(_helpPostListFromSnapshot);
  }

  Stream<List<HelpPost>> get helpPostListFromUser {
    return helpPostsCollection
        .where('user_uid', isEqualTo: uid)
    //.orderBy('creation_date', descending: false)
        .snapshots()
        .map(_helpPostListFromSnapshot);
  }

  Stream<List<SwipeCardUser>> get swipeCardUserProfile {
    return userCollection
        .where('user_uid', whereNotIn: account.networkingSeenAccounts)
        .limit(2)
        .snapshots()
        .map(_SwipeCardListFromSnapshot);
  }

  Stream<List<User>> get userWhoLiked {
    return userCollection
        .where(FieldPath.documentId, whereIn: account.likes)
        .snapshots()
        .map(_UserListFromSnapshot);
  }

  Stream<List<User>> get matches {
    return userCollection
        .where('matches', arrayContainsAny: [uid])
        .snapshots()
        .map(_UserListFromSnapshot);
  }
}