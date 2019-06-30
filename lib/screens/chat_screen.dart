import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const String id = '/chat';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _c;
  final _auth = FirebaseAuth.instance;
  final _fireStore = Firestore.instance;
  String userMessage;
  FirebaseUser currentUser;

  @override
  void initState() {
    super.initState();
    _c = TextEditingController();
    getCurrentUser();
    //listenToMessages();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        currentUser = user;
        print(currentUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  StreamBuilder<QuerySnapshot> getMessages() {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('messagges').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.amber,
            ),
          );
        }
        final messages = snapshot.data.documents;
        List<BubbleMessage> bubbleWidgets = [];
        for (var message in messages) {
          CrossAxisAlignment crossAxis = CrossAxisAlignment.end;
          Color color = Colors.black87;
          final messageText = message.data['text'].toString();
          final messageSender = message.data['sender'].toString();

          if (messageSender != currentUser.email) {
            crossAxis = CrossAxisAlignment.start;
            color = Colors.purple;
          }

          final bubbleWidget = BubbleMessage(
            messageText: messageText,
            messageSender: messageSender,
            crossAxisAlignement: crossAxis,
            bubbleColor: color,
          );
          bubbleWidgets.add(bubbleWidget);
        }
        return ListView(
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
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context); //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        //backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 2,
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
                        _fireStore.collection('messagges').add(
                            {'sender': currentUser.email, 'text': userMessage});
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

class BubbleMessage extends StatelessWidget {
  final String messageText;
  final String messageSender;
  final CrossAxisAlignment crossAxisAlignement;
  final Color bubbleColor;

  BubbleMessage(
      {this.messageSender,
      this.messageText,
      this.crossAxisAlignement,
      this.bubbleColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: crossAxisAlignement,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(20),
            color: bubbleColor,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(messageText),
            ),
          ),
        ),
      ],
    );
  }
}
