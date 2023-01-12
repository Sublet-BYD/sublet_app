import 'package:flutter/material.dart';
import 'package:sublet_app/widgets/chat_widgets/chat_messages.dart';

class ChatDetailPage extends StatefulWidget {
  final String imageURL;
  final String name;
  const ChatDetailPage({
    super.key,
    required this.name,
    required this.imageURL,
  });
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.imageURL),
                    maxRadius: 20,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        // Text(
                        //   "Online",
                        //   style: TextStyle(
                        //       color: Colors.grey.shade600, fontSize: 13),
                        // ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.settings,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: ChatMessages());
  }
}
