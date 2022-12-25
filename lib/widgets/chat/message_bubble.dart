import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
    this.message,
    //this.isMe,
    //   {
    //   required this.key,
    // }
  );

  // final Key key;
  final String message;
  //final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment:
      //       isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(12)
              // topLeft: Radius.circular(12),
              // topRight: Radius.circular(12),
              // bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
              // bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
              ),
          //),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Text(
            message,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
