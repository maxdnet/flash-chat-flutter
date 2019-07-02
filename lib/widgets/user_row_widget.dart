import 'package:flutter/material.dart';
import 'package:flash_chat/user.dart';

class UserRowWidget extends StatelessWidget {
  const UserRowWidget({
    Key key,
    @required String firstLetter,
    @required this.selectedUser,
  })  : _firstLetter = firstLetter,
        super(key: key);

  final String _firstLetter;
  final User selectedUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.amber,
            radius: 20,
            child: Text(
              _firstLetter,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ), //Image(image: AssetImage('images/boss.png')),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            selectedUser.username,
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ],
    );
  }
}
