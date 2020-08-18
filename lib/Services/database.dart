import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:oracle/models/help_posts.dart';
import 'package:oracle/models/user.dart';
import '../models/improvement.dart';
import '../Pages/Home/improvement_list.dart';
import '../models/home_posts.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  //Collection Reference
  final CollectionReference userCollection = Firestore.instance.collection('Users');
  final CollectionReference improvementsCollection = Firestore.instance.collection('Improvements');
  final CollectionReference homePostsCollection = Firestore.instance.collection('HomePosts');
  final CollectionReference helpPostsCollection = Firestore.instance.collection('HelpPosts');


  Future updateUserData(String name, String email, String businessName, String jobTitle, String location, String profileImage) async {
    return await userCollection.document(uid).setData({
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
    });
  }

  Future updateUserSettings(String field, bool val) async {
    return await userCollection.document(uid).updateData({
      field : val,
    });
  }

  //Updates Users points
  Future updateUserPoints(int increase) async {
    return await userCollection.document(uid).updateData({
      'points' : FieldValue.increment(increase)
    });
  }

  Future deleteUserData() async {
    return userCollection.document(uid).delete();
  }

  Future<String> getImage(String profileImage) async {
    FirebaseStorage firebaseStorage = FirebaseStorage(storageBucket: 'gs://the-oracle-112b2.appspot.com');
    String Test = firebaseStorage.ref()
        .child(profileImage)
        .getDownloadURL().toString();
    return Test;
  }


  //Updates Improvement Vote
  Future updateVote(String nameField, int value, String voteField, String userUID) async {
    //Need this to only work based on if a user has voted or not, otherwise don't let them vote again
    return await improvementsCollection.document(uid).updateData({
      nameField: FieldValue.increment(value),
      'user_votes': FieldValue.arrayUnion([userUID]),
    });
  }

  Future addNewImprovement(String userUid, String title, String description) async {
    return await improvementsCollection.document().setData({
      'user_uid': userUid,
      'title': title,
      'description': description,
      'up_votes': 0,
      'down_votes': 0,
      'user_votes': FieldValue.arrayUnion([]),
      //Add two lists for who has up voted and down voted
    });
  }

  //User Settings from snapshot
  UserSettings _userSettingsFromSnapshot(DocumentSnapshot snapshot) {
    return UserSettings(
      uid: uid,
      notifications: snapshot.data['settings_notifications'],
      lightDarkMode: snapshot.data['settings_light_dark_mode'],
      visibility: snapshot.data['settings_visibility'],
    );
  }

  //User Settings from snapshot
  User _userFromSnapshot(DocumentSnapshot snapshot) {
    return User(
      uid: uid,
      fullName: snapshot.data['name'],
      email: snapshot.data['email'],
      points: snapshot.data['points'],
      location: snapshot.data['location'],
      businessName: snapshot.data['business_name'],
      jobTitle: snapshot.data['job_title'],
      profileImage: snapshot.data['profile_image'],
      skills: List.from(snapshot.data['skills']),
      currentObjectives: snapshot.data['current_objectives'],
      age: snapshot.data['age'],
      gender: snapshot.data['gender'],
      titles: List.from(snapshot.data['titles']),
      lookingFor: List.from(snapshot.data['looking_for']),
      experience: List<Experience>.from(snapshot.data['experience'].map((item) {
        return Experience(area: item['area'], years: item['years']);
      })),
      qaulification: Qualification(type: snapshot.data['qual_type'], subjectArea: snapshot.data['qual_subject_area']),
      interests: List.from(snapshot.data['interests']),
      improvements: snapshot.data['improvements'],
      profileLinks: List<ProfileLinks>.from(snapshot.data['profile_links'].map((item) {
        return ProfileLinks(platform: item['platform'], url: item['url']);
      })),
    );
  }

  List<Improvement> _improvementListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Improvement(
        uid: doc.documentID,
        userUid: doc.data['user_uid'] ?? '',
        title: doc.data['title'] ?? '',
        description: doc.data['description'] ?? '',
        upVote: doc.data['up_votes'] ?? 0,
        downVote: doc.data['down_votes'] ?? 0,
      );
    }).toList();
  }

  Improvement _improvementFromSnapshot(DocumentSnapshot snapshot) {
    return Improvement(
      uid: snapshot.documentID,
      userUid: snapshot.data['user_uid'] ?? '',
      title: snapshot.data['title'] ?? '',
      description: snapshot.data['description'] ?? '',
      upVote: snapshot.data['up_votes'] ?? 0,
      downVote: snapshot.data['down_votes'] ?? 0,
    );
  }

  HomePost _homePostFromSnapshot(DocumentSnapshot snapshot) {
    return HomePost(
      uid: snapshot.documentID,
      userUid: snapshot.data['user_uid'] ?? '',
      title: snapshot.data['title'] ?? '',
      description: snapshot.data['description'] ?? '',
    );
  }

  List<HomePost> _homePostListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return HomePost(
        uid: doc.documentID,
        userUid: doc.data['user_uid'] ?? '',
        title: doc.data['title'] ?? '',
        description: doc.data['description'] ?? '',
      );
    }).toList();
  }

  HelpPost _helpPostFromSnapshot(DocumentSnapshot snapshot) {
    return HelpPost(
      uid: snapshot.documentID,
      userUid: snapshot.data['user_uid'] ?? '',
      title: snapshot.data['title'] ?? '',
      description: snapshot.data['description'] ?? '',
    );
  }

  List<HelpPost> _helpPostListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return HelpPost(
        uid: doc.documentID,
        userUid: doc.data['user_uid'] ?? '',
        title: doc.data['title'] ?? '',
        description: doc.data['description'] ?? '',
      );
    }).toList();
  }

  //Streams

  Stream<List<Improvement>> get improvementsList {
    return improvementsCollection.snapshots()
      .map(_improvementListFromSnapshot);
  }

  Stream<Improvement> get improvement {
    return improvementsCollection.document(uid).snapshots()
        .map(_improvementFromSnapshot);
  }

  //get User doc stream
  Stream<UserSettings> get userSettings {
    return userCollection.document(uid).snapshots()
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
}