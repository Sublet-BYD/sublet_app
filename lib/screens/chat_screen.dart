import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sublet_app/widgets/chat/messages.dart';
import 'package:sublet_app/widgets/chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Container(
          child: Column(
        children: [
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
