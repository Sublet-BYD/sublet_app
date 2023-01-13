import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:sublet_app/providers/current_chat.dart';

import '../../screens/Chat/chat_details_screen.dart';
import 'package:sublet_app/providers/Session_details.dart';
import 'package:sublet_app/providers/firestore_chat.dart';
import 'package:intl/intl.dart';

class ContactCard extends StatefulWidget {
  String name;
  String imageUrl;
  // String time = DateTime.now().toString();
  final chatId;
  bool isMessageRead = false; //dont know if needed
  ContactCard(
      {required this.name,
      required this.imageUrl,
      required this.isMessageRead,
      required this.chatId}) {}
  @override
  _ContactCardState createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  @override
  Widget build(BuildContext context) {
    final currentChatId = Provider.of<CurrentChat>(context).chatId;
    print(widget.imageUrl);
    Stream<QuerySnapshot> lastMessageStream =
        FirestoreChats().getLastMessage(widget.chatId);

    return StreamBuilder<Object>(
        stream: lastMessageStream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (!snapshot.hasData) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: const Text("Not contacts yet.."),
                );
              }
          }
          final lastMessage = (snapshot.data as QuerySnapshot).docs.last;
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ChangeNotifierProvider.value(
                  value: CurrentChat(
                      chatId: currentChatId, lastMessage: 'last message'),
                  child: ChatDetailPage(
                    name: widget.name,
                    imageURL: widget.imageUrl,
                  ),
                );
              }));
            },
            child: Container(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 10, bottom: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(widget.imageUrl),
                          maxRadius: 30,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.name,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  // messageText,
                                  // lastMessage,
                                  lastMessage.get('text'),
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade600,
                                      fontWeight: widget.isMessageRead
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    DateFormat('DD MMM').format(DateTime.parse(
                        DateFormat('yyyy-MM-dd HH:mm:ss')
                            .parse(lastMessage.get('createdAt'))
                            .toString())),
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: widget.isMessageRead
                            ? FontWeight.bold
                            : FontWeight.normal),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
