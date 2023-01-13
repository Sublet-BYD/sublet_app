import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:sublet_app/providers/Session_details.dart';
import 'package:sublet_app/providers/current_chat.dart';
import 'package:sublet_app/providers/firestore_chat.dart';

import '../../models/data/message.dart';

class ChatMessages extends StatefulWidget {
  ChatMessages({super.key});

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  final _messageController = new TextEditingController();
  // DUMMY MESSAGES for example:
  // List<Message> messages = [
  //   Message(messageContent: "Hello, Will", messageType: "receiver"),
  //   Message(messageContent: "How have you been?", messageType: "receiver"),
  //   Message(
  //       messageContent: "Hey Kriss, I am doing fine dude. wbu?",
  //       messageType: "sender"),
  //   Message(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
  //   Message(messageContent: "Is there any thing wrong?", messageType: "sender"),
  // ];

  @override
  Widget build(BuildContext context) {
    final String chatId = Provider.of<CurrentChat>(context).chatId;
    final receiver = Provider.of<Session_details>(context).UserType;
    Stream messagesStream = FirestoreChats().getAllMessages(chatId);

    return StreamBuilder(
        stream: messagesStream,
        builder: (context, snapshot) {
          final data = snapshot.data as QuerySnapshot;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (!snapshot.hasData) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: const Text("Not available properties here"),
                );
              }
          }

          return Stack(
            children: <Widget>[
              ListView.builder(
                itemCount: data.docs.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 10, bottom: 60),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  // get the message from the snapshots with the correct index.
                  final messageAsMap =
                      data.docs[index].data() as Map<String, dynamic>;
                  final Message message = Message.fromJson(messageAsMap);

                  return Container(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 10, bottom: 10),
                    child: Align(
                      alignment: (message.userType == receiver
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (message.userType == receiver
                              ? Colors.grey.shade200
                              : Colors.blue[200]),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          message.text,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Align(
                // Lower Bar of chat screen
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  height: 60,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        // should be the tap function for ADD Icon
                        onTap: () {},
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: const InputDecoration(
                              hintText: "Write message...",
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      FloatingActionButton(
                        // Send Icon
                        onPressed: () => SendMessage(receiver, chatId),
                        backgroundColor: Colors.blue,
                        elevation: 0,
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  SendMessage(String _userType, String chatId) {
    Message messageToSend = Message(
      text: _messageController.text,
      userType: _userType,
    );
    FirestoreChats().uploadMessage(messageToSend, chatId);
    _messageController.clear();
  }
}
