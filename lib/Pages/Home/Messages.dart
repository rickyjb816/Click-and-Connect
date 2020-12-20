import 'package:flutter/material.dart';
import 'package:oracle/Pages/Home/MessengerTile.dart';
import 'package:oracle/Services/database.dart';
import 'package:oracle/models/user.dart';
import 'package:oracle/shared/loading.dart';
import 'package:provider/provider.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    return StreamBuilder<User>(
      stream: DatabaseService(uid: user.uid).user,
      builder: (context, snapshot) {

        User mainUser = snapshot.data;

        return StreamBuilder<List<User>>(
          stream: DatabaseService(uid: user.uid).matches,
          builder: (context, snapshot) {

            List<User> ul = snapshot.data;

            return Scaffold(
              appBar: AppBar(title: Text('Messages'), centerTitle: true,),
              body: ul == null ? Loading() : ListView.builder(
                  itemCount: ul.length,
                  itemBuilder: (context, index) {
                    return MessenagerTile(user: ul[index],);
                  })
            );
          });
      });
  }
}
