import 'package:flutter/material.dart';
import 'package:flash_chat/utils.dart';

class BubbleMessage extends StatelessWidget {
  final String messageText;
  final String messageSender;
  final DateTime messageData;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Color bubbleColor;
  final BorderRadius bRadius;
  final IconData iconSent;

  BubbleMessage(
      {this.messageSender,
      this.messageText,
      this.mainAxisAlignment,
      this.crossAxisAlignment,
      this.bubbleColor,
      this.bRadius,
      this.messageData,
      this.iconSent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: <Widget>[
          Flexible(
            fit: FlexFit.loose,
            child: Material(
              elevation: 5.0,
              borderRadius: bRadius,
              color: bubbleColor,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child: Text(
                        messageText,
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          Utils.convertDataToTime(messageData),
                          style:
                              TextStyle(color: Colors.white54, fontSize: 10.0),
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          iconSent,
                          color: Colors.amber,
                          size: 13.0,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
