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
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: crossAxisAlignment,
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

  //Questa è quella nuova che non me Wrappa il testo

//  Widget build(BuildContext context) {
//    return Row(
//      mainAxisAlignment: crossAxisAlignement,
//      //crossAxisAlignment: CrossAxisAlignment.center,
//      children: <Widget>[
//        Padding(
//          padding: const EdgeInsets.all(8.0),
//          child: Material(
//            elevation: 5.0,
//            borderRadius: bRadius,
//            color: bubbleColor,
//            child: Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.end,
//                children: <Widget>[
//                  Text(
//                    messageText,
//                    style: TextStyle(fontSize: 15.0),
//                  ),
//                  Row(
//                    children: <Widget>[
//                      Text(
//                        '${Utils.convertDataToTime(messageData)}',
//                        style: TextStyle(
//                          color: Colors.white54,
//                          fontSize: 10.0,
//                        ),
//                        textAlign: TextAlign.right,
//                      ),
//                      SizedBox(
//                        width: 3.0,
//                      ),
//                      Icon(
//                        iconSent, //check
//                        size: 13.0,
//                        color: Colors.amberAccent,
//                      ),
//                    ],
//                  ),
//                ],
//              ),
//            ),
//          ),
//        )
//      ],
//    );
//  }
}
