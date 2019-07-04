import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/widgets/bubble_message.dart';
import 'package:flash_chat/user.dart';
import 'package:flash_chat/widgets/user_row_widget.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'users/chat';
  final User selectedUser;

  ChatScreen({this.selectedUser});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _c;

  final _auth = FirebaseAuth.instance;
  final _fireStore = Firestore.instance;
  String chatID;
  String _firstLetter;
  User selectedUser;
  String userMessage;

  FirebaseUser currentUser;

  @override
  void initState() {
    super.initState();
    selectedUser = super.widget.selectedUser;
    chatID = getChatID(selectedUser.idSelected, selectedUser.idCurrent);
    _firstLetter = selectedUser.username.substring(0, 1);
    _c = TextEditingController();
  }

  String getChatID(int n1, int n2) {
    return (n1 < n2 ? '$n1' + '_' + '$n2' : '$n2' + '_' + '$n1');
  }

  Stream<QuerySnapshot> getSnapshots() {
    return _fireStore.collection('/rooms/$chatID/messagges').snapshots();
  }

  StreamBuilder<QuerySnapshot> getMessages() {
    return StreamBuilder<QuerySnapshot>(
      stream: getSnapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.amber,
            ),
          );
        }
        final messages = snapshot.data.documents.reversed;
        List<BubbleMessage> bubbleWidgets = [];
        for (var message in messages) {
          MainAxisAlignment mainAxis = MainAxisAlignment.end;
          CrossAxisAlignment crossAxis = CrossAxisAlignment.end;
          Color color = Colors.black87;
          BorderRadius bradius = kBubbleMessageBorderRadiusUser;
          IconData iconSend = Icons.check;

          final messageText = message.data['message'].toString();
          final messageSender = message.data['from'].toString();
          final Timestamp messageTime = message.data['data'];
          final bool isNew = message.data['isnew'];

          if (messageSender != selectedUser.uidCurrent) {
            mainAxis = MainAxisAlignment.start;
            crossAxis = CrossAxisAlignment.start;
            color = Colors.purple;
            bradius = kBubbleMessageBorderRadiusVisitor;
            iconSend = Icons.chevron_right;
          }

          final bubbleWidget = BubbleMessage(
            messageText: messageText,
            messageSender: messageSender,
            crossAxisAlignment: crossAxis,
            mainAxisAlignment: mainAxis,
            bubbleColor: color,
            bRadius: bradius,
            messageData: messageTime.toDate(),
            iconSent: iconSend,
          );
          bubbleWidgets.add(bubbleWidget);
        }
        return ListView(
          reverse: true,
          padding: EdgeInsets.all(10),
          children: bubbleWidgets,
        );
      },
    );
  }

  @override
  void dispose() {
    _c?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
//        actions: <Widget>[
//          IconButton(
//              icon: Icon(Icons.close),
//              onPressed: () {
//                _auth.signOut();
//                Navigator.pop(context); //Implement logout functionality
//              }),
//        ],
        title: UserRowWidget(
            firstLetter: _firstLetter, selectedUser: selectedUser),
        //backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              fit: FlexFit.loose,
              child: getMessages(),
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        //Do something with the user input.
                        userMessage = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                      controller: _c,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      if (userMessage != null) {
                        _fireStore.collection('/rooms/$chatID/messagges').add({
                          'from': selectedUser.uidCurrent,
                          'message': userMessage,
                          'data': DateTime.now(),
                          'isNew': true
                        });
                        setState(() {
                          _c.clear();
                        });
                      }
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
