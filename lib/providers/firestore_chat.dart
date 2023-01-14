import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sublet_app/models/data/chat_user.dart';
import 'package:sublet_app/models/data/message.dart';

class FirestoreChats {
  // Return snapshots of all conversation this specific userId is participantating.
  // directing by usertype.
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllChats(
      String userID, String userType) {
    print("userType: ${userType} || UserId ${userID}");
    return FirebaseFirestore.instance
        .collection('chats')
        .where(userType == 'client' ? 'guestId' : 'hostId', isEqualTo: userID)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(chatId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(chatId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .snapshots();
  }

  ChatUsers getChatUser(Map<String, dynamic> snapshot) {
    return ChatUsers.fromJson(snapshot);
  }

  void uploadMessage(Message message, String chatId) {
    FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(message.toJson());
  }

  String startNewChat(ChatUsers chatUser, Message newMessage) {
    String chatId = FirebaseFirestore.instance
        .collection('chats')
        .add(chatUser.toJson())
        .then((value) => value.collection('messages').add(newMessage.toJson()))
        .toString();
    // FirebaseFirestore.instance
    //     .collection('chats')
    //     .doc(chatId)
    //     .collection('messages')
    //     .add(newMessage.toJson());
    // FirebaseFirestore.instance.collection('chats').doc(chatId).
    return chatId;
  }
}
