import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StorageUploader extends StatefulWidget {
  final File file;

  StorageUploader({this.file});

  @override
  _StorageUploaderState createState() => _StorageUploaderState();
}

class _StorageUploaderState extends State<StorageUploader> {

  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://the-oracle-112b2.appspot.com');

  UploadTask _uploadTask;

  void _startUpload() {
    String filePath = 'images/${Uuid().v4()}.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_uploadTask != null){

    }
  }
}
