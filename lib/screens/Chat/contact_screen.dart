import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:sublet_app/models/data/chat_user.dart';
import 'package:sublet_app/providers/current_chat.dart';
import 'package:sublet_app/providers/firestore_chat.dart';
import 'package:sublet_app/widgets/chat_widgets/contact_card.dart';
import 'package:sublet_app/providers/Session_details.dart';

class ContactScreen extends StatefulWidget {
  final Stream<QuerySnapshot> chatUsersStream;
  const ContactScreen({
    super.key,
    required this.chatUsersStream,
  });

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

ContactCard widgetByUserType(
    BuildContext context, ChatUsers chatUsers, index, chatId) {
  String userId = Provider.of<Session_details>(context).UserId;
  print(" host imageURL: ${chatUsers.hostImageURL}");
  print("guestIdname: ${chatUsers.guestId} hostIdname: ${chatUsers.hostId}");
  String stURL = (chatUsers.hostImageURL == null ||
          chatUsers.guestImageURL == null)
      ? 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fstackoverflow.com%2Fquestions%2F49917726%2Fretrieving-default-image-all-url-profile-picture-from-facebook-graph-api&psig=AOvVaw0gYaZXd_ssSUA0fZBiZpd5&ust=1673653240146000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCIDCl6yaw_wCFQAAAAAdAAAAABAE'
      : (userId == 'client'
          ? chatUsers.hostImageURL!
          : chatUsers.guestImageURL!);
  return ContactCard(
    name: userId == 'client' ? chatUsers.hostName : chatUsers.guestName,
    imageUrl: stURL,
    isMessageRead: (index == 0 || index == 3) ? true : false,
    chatId: chatId,
  );
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: widget.chatUsersStream,
        builder: ((context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (!snapshot.hasData) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: const Text("Not available Chats yet"),
                );
              }
              final data = snapshot.data as QuerySnapshot;
              return Container(
                margin: const EdgeInsets.only(top: 10, bottom: 15),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: ListView.builder(
                      itemCount: data.docs.length,
                      // itemCount: 30,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 16),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        // PRINT HRER FOR CHECK
                        print(
                            'snapshot, data=${snapshot.data}, title=${data.docs[index].data()}');
                        ChatUsers chatUsers = FirestoreChats().getChatUser(
                            data.docs[index].data() as Map<String, dynamic>);
                        var chatId = data.docs[index].id;
                        return ChangeNotifierProvider.value(
                          value: CurrentChat(chatId: chatId),
                          child: widgetByUserType(
                              context, chatUsers, index, chatId),
                        );
                      },
                    ),
                  ),
                ),
              );
          }
        }),
      ),
    );
  }
}
