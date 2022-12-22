import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(8),
          child: Text('This work'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // tell firestroe we want get access to the message collection indise the path
          FirebaseFirestore.instance
              .collection('chats/KTu5DVP9EB1Cd4ZFSd8u/messages')
              .snapshots()
              .Snapshot((snapshot) {
            for (var doc in snapshot.documents) {
              print(doc.data()['text']);
            }
          });
        },
      ),
    );
  }
}
