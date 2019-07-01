import 'package:flutter/material.dart';

class UserListBubble extends StatelessWidget {
  final String userName;
  final String userID;
  String firstLetter;

  UserListBubble({
    this.userName,
    this.userID,
  }) {
    firstLetter = userName.substring(0, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
          elevation: 4,
          child: InkWell(
            onTap: () {},
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.amber,
                    radius: 20,
                    child: Text(
                      firstLetter,
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
                    userName,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
