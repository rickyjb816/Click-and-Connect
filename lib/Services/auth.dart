import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oracle/models/user.dart' as U;
import 'package:uuid/uuid.dart';

import 'database.dart';

class AuthService {

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //Create User Object base on FirebaseUser
  U.User _userFromFirebaseUser(auth.User user) {
    return user != null ? U.User(uid: user.uid) : null;
  }

  //Auth Change User Stream
  Stream<U.User> get user {
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }


  //Sign in Anon
  Future signInAnon() async {
    try{
      auth.UserCredential result = await _auth.signInAnonymously();
      return _userFromFirebaseUser(result.user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //Sign In Email and Password
  Future signInEmailAndPassword(String email, String password) async {
    try{
      auth.UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Register with Email and Password
  Future registerWithEmailAndPassword(String email, String password, String name, String businessName, String jobTitle, File profileImage) async {
    try{
      auth.UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      result.user.sendEmailVerification();

      final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://the-oracle-112b2.appspot.com');

      UploadTask _uploadTask;
      String downloadURL;
      var filePath = 'images/${Uuid().v4()}.png';
      _uploadTask = _storage.ref().child(filePath).putFile(profileImage);
      //var storageSnapshot = await _uploadTask.onComplete();
      //Check this Later
      _uploadTask.snapshotEvents.listen((event) {
        print(event.state);
      });
      _uploadTask.then((TaskSnapshot taskSnapshot) async {
        print(taskSnapshot.state);
        downloadURL = await taskSnapshot.ref.getDownloadURL();
        /*await userCollection.doc(uid).update({
          'profile_image': imageDownloadURL ?? imageName,
        });*/
      });
      Reference ref = FirebaseStorage.instance.ref().child(filePath);
      //String url = (await _uploadTask.).snapshot.ref.getDownloadURL();
      downloadURL = ref.getDownloadURL().toString();

      //create a document for the user with the uid
      await DatabaseService(uid: result.user.uid).updateUserData(name, email, businessName, jobTitle, 'Location Of User', downloadURL);

      return _userFromFirebaseUser(result.user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //Sign In Google - Works to sign user in but will create user if one doesn't exist and skip any set up process
  Future googleSignIn() async {
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken);

      final auth.UserCredential authResult = await _auth.signInWithCredential(credential);
      auth.User user = authResult.user;

      await DatabaseService(uid: authResult.user.uid).updateUserData(googleUser.displayName, googleUser.email, 'Add business', 'Add Job Title', 'Location Of User', googleUser.photoUrl);
      user.sendEmailVerification();

      return _userFromFirebaseUser(user);
    } catch(e) {
      return null;
    }
  }

  //Register with Google

  //Sign In Facebook

  //Register with Facebook

  //Sign In Twitter

  //Register with Twitter

  //Sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //UpdatePassword


  //Delete Account
  Future deleteAccount() async {
    auth.User user = await _auth.currentUser;
    await DatabaseService(uid: user.uid).deleteUserData();
    return await user.delete();
  }
}