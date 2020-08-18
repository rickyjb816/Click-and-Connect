import 'package:flutter/material.dart';
import 'package:oracle/Pages/Authenticate/signIn.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:oracle/Services/auth.dart';
import 'package:oracle/shared/constants.dart';
import 'package:oracle/shared/loading.dart';
import 'package:oracle/image_capture.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class SignUp extends StatefulWidget {

  final Function toggleView;
  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  String _email, _password, _name, _businessName, _jobTitle;
  String error = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;
  String filePath;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(

        title: Text('Sign Up'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In Instead'),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                RaisedButton(
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  },
                  child: Text('Add Image From Camera'),
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                  },
                  child: Text('Add Image From Device'),
                ),
                SizedBox(height: 20.0),
                Image.file(_imageFile ??
                    File('assets/images/Click and Collect Logo.JPG')),
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (input) =>
                  input.isEmpty
                      ? "Enter Valid Email Address"
                      : null,
                  onSaved: (input) => _email = input,
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (input) =>
                  input.length < 6
                      ? 'Your password needs to be atleast 6 characters'
                      : null,
                  onSaved: (input) => _password = input,
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (input) =>
                  input.isEmpty
                      ? 'Enter Full Name'
                      : null,
                  onSaved: (input) => _name = input,
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Full Name'),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (input) =>
                  input.isEmpty
                      ? 'Enter Business Name'
                      : null,
                  onSaved: (input) => _businessName = input,
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Business Name'),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (input) =>
                  input.isEmpty
                      ? 'Enter Job Title'
                      : null,
                  onSaved: (input) => _jobTitle = input,
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Job Title'),
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  onPressed: signUp,
                  child: Text('Sign up'),
                ),
                SizedBox(height: 12.0,),
                Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> signUp() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        setState(() => loading = true);
        //await startUpload();
        dynamic result = await _auth.registerWithEmailAndPassword(
            _email, _password, _name, _businessName, _jobTitle, _imageFile);
        if (result == null) {
          setState(() {
            error = 'Please Supply a valid email';
            loading = false;
          });
        }
      } catch (e) {
        print(e.message);
      }
    }
  }

  File _imageFile;

  Future pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
    cropImage();
  }

  Future cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      compressFormat: ImageCompressFormat.jpg,
      maxHeight: 500,
      maxWidth: 500,
      androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.grey,
          toolbarWidgetColor: Colors.white,
          toolbarTitle: 'Crop It'
      ),
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  void clear() {
    setState(() {
      _imageFile = null;
    });
  }
}

