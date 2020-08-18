import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseImageProvider extends StatefulWidget {
  @override
  _FirebaseImageProviderState createState() => _FirebaseImageProviderState();
}

class _FirebaseImageProviderState extends State<FirebaseImageProvider> {

  var _image = "https://via.placeholder.com/350x150";

  @override
  Widget build(BuildContext context) {
    return Image.network(_image);
  }


  Future getImage(String profileImage) async {
    FirebaseStorage firebaseStorage = FirebaseStorage(storageBucket: 'gs://the-oracle-112b2.appspot.com');
    var downloadUrl = await firebaseStorage.ref()
        .child(profileImage)
        .getDownloadURL();

    setState(() {
      _image = downloadUrl;
    });
  }
}
