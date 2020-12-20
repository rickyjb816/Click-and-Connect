import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oracle/Services/database.dart';
import 'package:oracle/models/user.dart';
import 'package:oracle/shared/constants.dart';

class ProfileEdit extends StatefulWidget {

  final User user;

  ProfileEdit({this.user});

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {



  List<String> items = ['Picture', 'Job Title', 'Location', 'Looking For', 'Name', 'Gender', 'Profile Links', 'Highest Qualification', 'Skills', 'Titles', 'Business Name', 'Age', 'Current Objectives', 'Interests', 'Improvements', 'Experience'];
  String selected = 'Picture';

  List<String> socialItems = ['Facebook', 'LinkedIn', 'Twitter', 'Instagram', 'Website'];
  String selectedSocial = 'Facebook';

  TextEditingController _jobTitleController;
  TextEditingController _locationController;
  TextEditingController _nameController;
  TextEditingController _highestQualSubjectController;
  TextEditingController _highestQualTypeController;
  TextEditingController _businessNameController;
  TextEditingController _currentObjectivesController;
  TextEditingController _skillsAddController;
  TextEditingController _lookingForAddController;
  TextEditingController _titlesAddController;
  TextEditingController _interestsAddController;
  TextEditingController _improvementsController;
  TextEditingController _genderController;
  TextEditingController _profileLinkUrlController;
  TextEditingController _experienceAreaController;

  String jobTitle;
  String location;
  List<String> sk;
  List<String> lookingfor;
  String name;
  String highestQualSub;
  String highestQualType;
  String businessName;
  String currentObjectives;
  List<String> titles;
  List<String> interests;
  String improvements;
  String gender;
  List<ProfileLinks> profileLinks;
  String profileLinkUrl;
  List<Experience> experience;
  String experienceArea;

  String image;
  String filePath;
  File _imageFile;

  Timestamp dateTaken;
  DateTime pickedDate;
  Timestamp experienceDateTaken;
  DateTime experiencePickedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.user.skills);
    jobTitle = widget.user.jobTitle;
    sk = widget.user.skills;
    location = widget.user.location;
    lookingfor = widget.user.lookingFor;
    name = widget.user.fullName;
    highestQualSub = widget.user.qaulification.subjectArea;
    highestQualType = widget.user.qaulification.type;
    businessName = widget.user.businessName;
    currentObjectives = widget.user.currentObjectives;
    titles = widget.user.titles;
    interests = widget.user.interests;
    improvements = widget.user.improvements;
    gender = widget.user.gender;
    profileLinks = widget.user.profileLinks;
    experience = widget.user.experience;

    pickedDate = widget.user.age.toDate();
    dateTaken = Timestamp.fromDate(pickedDate);

    experiencePickedDate = DateTime.now();
    experienceDateTaken = Timestamp.fromDate(experiencePickedDate);
  }

  @override
  Widget build(BuildContext context) {


    _jobTitleController = new TextEditingController(text: jobTitle);
    _locationController = new TextEditingController(text: widget.user.location);
    _nameController = new TextEditingController(text: widget.user.fullName);
    _highestQualSubjectController = new TextEditingController(text: widget.user.qaulification.subjectArea);
    _highestQualTypeController = new TextEditingController(text: widget.user.qaulification.type);
    _businessNameController = new TextEditingController(text: widget.user.businessName);
    _currentObjectivesController = new TextEditingController(text: widget.user.currentObjectives);
    _skillsAddController = new TextEditingController();
    _lookingForAddController = new TextEditingController();
    _titlesAddController = new TextEditingController();
    _interestsAddController = new TextEditingController();
    _improvementsController = new TextEditingController(text: widget.user.improvements);
    _genderController = new TextEditingController(text: widget.user.gender);
    _profileLinkUrlController = new TextEditingController();
    _experienceAreaController = new TextEditingController();

    //pickedDate = widget.user.age.toDate();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            new DropdownButton<String>(
              value: selected,
              items: items.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  selected = val;
                });
              },
            ),
            updateWidget(),
          ],
        ),
      ),
    );
  }


  @override
  Future<void> dispose() async {
    super.dispose();
    await DatabaseService(uid: widget.user.uid).updateUser(_jobTitleController.text, _nameController.text, _locationController.text, _businessNameController.text, _currentObjectivesController.text, new Qualification(type: _highestQualTypeController.text, subjectArea: _highestQualSubjectController.text), sk, lookingfor, titles, interests, improvements, gender, Timestamp.fromDate(pickedDate), _imageFile != null, _imageFile, widget.user.profileImage, profileLinks, experience);
  }

  //'Picture', 'Job Title', 'Location', 'Looking For', 'Name', 'Profile Links', 'Highest Qualification', 'Skills', 'Titles', 'Business Name', 'Age', 'Current Objectives'
  Widget updateWidget() {
    switch(selected)
    {
      case 'Picture':
        {
          return Column(
            children: [
              Text('Add Image From:'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 10.0),
                  RaisedButton(
                    color: mainColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
                    textColor: Colors.white,
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: Text('Camera', textScaleFactor: 1.5,),
                    ),
                  ),
                  SizedBox(width: 20,),
                  RaisedButton(
                    color: mainColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
                    textColor: Colors.white,
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: Text('Device', textScaleFactor: 1.5,),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),

              SizedBox(height: 20.0),
              Card(
                  color: mainColor,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: _imageFile != null ? Image.file(_imageFile,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ) : Image.network(widget.user.profileImage,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        )
                    ),
                  )
              ),
            ],
          );
        }
      case 'Job Title':
        {
          //_jobTitleController = new TextEditingController(text: jobTitle);
          return TextField(
            controller: _jobTitleController,
            onChanged: (val) {
              jobTitle = val;
              _jobTitleController.value = TextEditingValue(
                  text: val,
                  selection: TextSelection.fromPosition(TextPosition(offset: val.length),));
            },
          );
          break;
        }
      case 'Location':
        {
          return TextField(controller: _locationController,
            onChanged: (val) {
            location = val;
            _locationController.value = TextEditingValue(
                text: val,
                selection: TextSelection.fromPosition(TextPosition(offset: val.length),));
          },);
          break;
        }
      case 'Looking For':
        {
          return Column(
            children: [
              TextField(controller: _lookingForAddController,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            lookingfor.add(_lookingForAddController.text);
                          });
                        })
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: lookingfor.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text(lookingfor[index]),);
                  })
            ],
          );
          break;
        }
      case 'Name':
        {
          return TextField(controller: _nameController,
            onChanged: (val) {
              name = val;
              _nameController.value = TextEditingValue(
                  text: val,
                  selection: TextSelection.fromPosition(TextPosition(offset: val.length),));
            },);
          break;
        }
      case 'Gender':
        {
          return TextField(controller: _genderController,
            onChanged: (val) {
              gender = val;
              _genderController.value = TextEditingValue(
                  text: val,
                  selection: TextSelection.fromPosition(TextPosition(offset: val.length),));
            },);
          break;
        }
      case 'Profile Links':
        {
          return Column(
            children: [
              DropdownButton<String>(
                value: selectedSocial,
                items: socialItems.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedSocial = val;
                  });
                },
              ),
              TextField(
                controller: _profileLinkUrlController,
                onChanged: (val) {
                profileLinkUrl = val;
                _profileLinkUrlController.value = TextEditingValue(
                  text: val,
                  selection: TextSelection.fromPosition(TextPosition(offset: val.length),));
                },
              ),
              FlatButton(
                child: Text('Add'),
                onPressed: () {
                  setState(() {
                    profileLinks.add(ProfileLinks(platform: selectedSocial, url: _profileLinkUrlController.text));
                  });

                },
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: profileLinks.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text(profileLinks[index].platform), subtitle: Text(profileLinks[index].url));
                  })
            ],
          );
          break;
        }
      case 'Highest Qualification':
        {
          return Column(
            children: [
              TextField(controller: _highestQualSubjectController,
                onChanged: (val) {
                highestQualSub = val;
                _highestQualSubjectController.value = TextEditingValue(
                    text: val,
                    selection: TextSelection.fromPosition(TextPosition(offset: val.length),));
                },
              ),
              TextField(controller: _highestQualTypeController,
                onChanged: (val) {
                highestQualType = val;
                _highestQualTypeController.value = TextEditingValue(
                    text: val,
                    selection: TextSelection.fromPosition(TextPosition(offset: val.length),));
                },
              ),
            ],
          );
          break;
        }
      case 'Skills':
        {
          return Column(
            children: [
              TextField(controller: _skillsAddController,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          sk.add(_skillsAddController.text);
                        });
                      })
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: sk.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text(sk[index]),);
                  })
            ],
          );
          break;
        }
      case 'Titles':
        {
          return Column(
            children: [
              TextField(controller: _titlesAddController,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            titles.add(_titlesAddController.text);
                          });
                        })
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: titles.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text(titles[index]),);
                  })
            ],
          );
          break;
        }
      case 'Business Name':
        {
          return TextField(controller: _businessNameController,
            onChanged: (val) {
              businessName = val;
              _businessNameController.value = TextEditingValue(
                  text: val,
                  selection: TextSelection.fromPosition(TextPosition(offset: val.length),));
            },);
          break;
        }
      case 'Age':
        {
          //Date Of Birth
          return ListTile(
            title: Text('DOB: ${pickedDate.day}/${pickedDate.month}/${pickedDate.year}'),
            trailing: Icon(Icons.keyboard_arrow_down),
            onTap: pickDate,
          );
          break;
        }
      case 'Current Objectives':
        {
          return TextField(controller: _currentObjectivesController,
              onChanged: (val) {
            currentObjectives = val;
            _currentObjectivesController.value = TextEditingValue(
                text: val,
                selection: TextSelection.fromPosition(TextPosition(offset: val.length),));
          });
          break;
        }
      case 'Interests':
        {
          return Column(
            children: [
              TextField(controller: _interestsAddController,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            interests.add(_interestsAddController.text);
                          });
                        })
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: interests.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text(interests[index]),);
                  })
            ],
          );
          break;
        }
      case 'Improvements':
        {
          return TextField(
            controller: _improvementsController,
            onChanged: (val) {
              improvements = val;
              _improvementsController.value = TextEditingValue(
                  text: val,
                  selection: TextSelection.fromPosition(TextPosition(offset: val.length),));
            },
          );
        }
      case 'Experience':
        {
          return Column(
            children: [
              TextField(
                controller: _experienceAreaController,
                onChanged: (val) {
                  experienceArea = val;
                  _experienceAreaController.value = TextEditingValue(
                      text: val,
                      selection: TextSelection.fromPosition(TextPosition(offset: val.length),));
                },
              ),
              ListTile(
                title: Text('Date: ${experiencePickedDate.day}/${experiencePickedDate.month}/${experiencePickedDate.year}'),
                trailing: Icon(Icons.keyboard_arrow_down),
                onTap: experiencePickDate,
              ),
              FlatButton(
                child: Text('Add'),
                onPressed: () {
                  setState(() {
                    experience.add(Experience(area: _experienceAreaController.text, years: experienceDateTaken));
                  });
                },
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: experience.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text(experience[index].area), subtitle: Text('Years: ' + _getYears(experience[index].years)), );
                  })
            ],
          );
        }
    }
  }

  String _getYears(Timestamp date) {
    final start = date.toDate();
    final todaysDate = DateTime.now();
    final difference = todaysDate.difference(start);
    return (difference.inDays/365).floor().toString();
  }

  pickDate() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: pickedDate,
        firstDate: DateTime(DateTime.now().year-100),
        lastDate: DateTime(DateTime.now().year+100)
    );

    if(date != null) {
      setState(() {
        pickedDate = date;
        dateTaken = Timestamp.fromDate(pickedDate);
      });
    }
  }

  experiencePickDate() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: experiencePickedDate,
        firstDate: DateTime(DateTime.now().year-100),
        lastDate: DateTime(DateTime.now().year+100)
    );

    if(date != null) {
      setState(() {
        experiencePickedDate = date;
        experienceDateTaken = Timestamp.fromDate(experiencePickedDate);
      });
    }
  }

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

