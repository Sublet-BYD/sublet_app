import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sublet_app/models/data/chat_user.dart';

class FirestoreChats {
  // Return snapshots of all conversation this specific userId is participantating.
  // directing by usertype.
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllChats(
      String userID, String userType) {
    return FirebaseFirestore.instance
        .collection('chats')
        .where(userType == 'client' ? 'guest_id' : 'host_id', isEqualTo: userID)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(chatId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getLastMessage(chatId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .snapshots()
        .last;
  }

  ChatUsers getChatUser(Map<String, dynamic> snapshot) {
    return ChatUsers.fromJson(snapshot);
  }
}
