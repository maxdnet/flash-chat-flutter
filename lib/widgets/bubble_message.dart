import 'package:flutter/material.dart';
import 'package:flash_chat/utils.dart';

class BubbleMessage extends StatelessWidget {
  final String messageText;
  final String messageSender;
  final DateTime messageData;
  final CrossAxisAlignment crossAxisAlignement;
  final Color bubbleColor;
  final BorderRadius bRadius;

  BubbleMessage(
      {this.messageSender,
      this.messageText,
      this.crossAxisAlignement,
      this.bubbleColor,
      this.bRadius,
      this.messageData});

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
            borderRadius: bRadius,
            color: bubbleColor,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    messageText,
                    style: TextStyle(fontSize: 15.0),
                  ),
                  Text(
                    Utils.convertDataToTime(messageData),
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 10.0,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
