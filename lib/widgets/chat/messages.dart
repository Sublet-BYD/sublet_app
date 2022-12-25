import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sublet_app/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat').
          // //oreder of the chat by time and fix the view
           orderBy('createdAt', descending: true)
           .snapshots(),
      builder: (context, chatSnapshot) {
        //still waitng for some data
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatSnapshot.data!.docs.length, //how many item we need
          itemBuilder: (context, index) => MessageBubble(
            chatDocs[index]['text'],
            // chatDocs[index]['userId'],
          ),
        );
      },
    );
  }
}
