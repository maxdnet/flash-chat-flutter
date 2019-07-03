import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/user.dart';
import 'package:flash_chat/widgets/userlist_widget.dart';

class UserScreen extends StatefulWidget {
  static const String id = 'users';
  final User user;

  UserScreen({this.user});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _auth = FirebaseAuth.instance;
  final _fireStore = Firestore.instance;
  int currentUserID;
  FirebaseUser currentUser;

  @override
  void initState() {
    super.initState();
    var user = widget.user;

    //vengo dalla Login o dalla registrazione
    if (user != null) user.loginUser(context);
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          currentUser = user;
        });

        _fireStore
            .collection('users')
            .where('uid', isEqualTo: currentUser.uid)
            .snapshots()
            .listen((data) => currentUserID = data.documents[0]['id']);
      }
    } catch (e) {
      print(e);
    }
  }

  StreamBuilder<QuerySnapshot> getMessages() {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.amber,
            ),
          );
        }
        final users = snapshot.data.documents.reversed;
        List<Widget> usersListWidget = [];
        for (var user in users) {
          final userID = user.data['id'];
          if (userID == currentUserID) continue;

          final userListWidget = UserListBubble(
            user: user,
            uidCurrent: currentUser.uid,
            idSelected: userID,
            idCurrent: currentUserID,
          );
          usersListWidget.add(userListWidget);
        }

        usersListWidget.insert(
            0,
            Material(
              color: Colors.black54,
              textStyle: TextStyle(color: Colors.white70),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '${users.length.toString()} people',
                  textAlign: TextAlign.right,
                ),
              ),
            ));

        return ListView(
          reverse: false,
          children: usersListWidget,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elite people'),
      ),
      body: SafeArea(
        child: getMessages(),
      ),
    );
  }
}
