import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _entryMessage = '';
  final _controller = new TextEditingController();

  void _sendMessage() async{
    FocusScope.of(context).unfocus();
        final user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance.collection('chat').add({
      'text': _entryMessage,
      'createdAt': Timestamp.now(),
      'userId': user?.uid,
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Send a message...'),
            onChanged: ((value) {
              setState(() {
                _entryMessage = value;
              });
            }),
          )),
          IconButton(
              onPressed: _entryMessage.trim().isEmpty ? null : _sendMessage,
              icon: Icon(Icons.send),
              color: Theme.of(context).primaryColor),
        ],
      ),
    );
  }
}
