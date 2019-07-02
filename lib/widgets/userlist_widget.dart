import 'package:flutter/material.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/user.dart';
import 'package:flash_chat/widgets/user_row_widget.dart';

class UserListBubble extends StatelessWidget {
  final dynamic user;
  final String uidCurrent;
  final int idCurrent;
  final int idSelected;
  User selectedUser;
  String _firstLetter;
  String _username;
  String _uid;

  UserListBubble(
      {this.user, this.uidCurrent, this.idSelected, this.idCurrent}) {
    _uid = user.data['uid'];
    _username = user.data['user'];
    _firstLetter = _username.substring(0, 1);
    selectedUser = User(
        uidSelected: _uid,
        username: _username,
        uidCurrent: uidCurrent,
        idCurrent: idCurrent,
        idSelected: idSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
          elevation: 4,
          child: InkWell(
            onTap: () {
//              Navigator.pushNamed(context, ChatScreen.id,
//                  arguments: selectedUser);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreen(
                            selectedUser: selectedUser,
                          )));
            },
            child: UserRowWidget(
                firstLetter: _firstLetter, selectedUser: selectedUser),
          ),
        ),
      ],
    );
  }
}
