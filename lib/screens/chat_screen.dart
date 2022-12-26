import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sublet_app/screens/Renter/Asset_Page.dart';
import 'package:sublet_app/widgets/chat/messages.dart';
import 'package:sublet_app/widgets/chat/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  // const ChatScreen({super.key});
  static final ChatScreen _singleton = ChatScreen._internal();

  factory ChatScreen() {
    return _singleton;
  }

  ChatScreen._internal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Container(
          child: Column(
        children: const [
          //with wxpand youe make sure the lisy view only
          // takes as much space as available on the current screen
          Expanded(
            child: Messages(),
          ),
          NewMessage(),
        ],
      )),
    );
  }
}
