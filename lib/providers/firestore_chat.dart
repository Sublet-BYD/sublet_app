import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sublet_app/Firebase_functions.dart';
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
    DocumentReference newchat =
        FirebaseFirestore.instance.collection('chats').doc();
    String chatId = newchat.id;
    newchat.set(chatUser.toJson());
    newchat.collection('messages').add(newMessage.toJson());
    print(chatId);
    Firebase_functions.AddChatToUser(chatUser.guestId, chatId, chatUser.hostId);
    return chatId;
  }

  Future<bool> chatExists(hostId, guestId) async {
    if (!(await Firebase_functions.userExists(hostId)) ||
        !(await Firebase_functions.userExists(guestId))) {
      return false;
    }
    Map<String, dynamic> chatList =
        await Firebase_functions.getChatList(guestId);
    bool res = false;
    chatList.forEach((key, value) {
      if (value == hostId) {
        res = true;
        return;
      }
    });
    print(res ? 'Chat exists\n' : 'Doesnt exists\n');
    return res;
  }

  Future<String> getChat(hostId, guestId) async {
    Map<String, dynamic> chatList =
        await Firebase_functions.getChatList(guestId);
    String output = '';
    chatList.forEach((key, value) {
      if (value == hostId) {
        output = key;
        return;
      }
    });
    return output;
  }
}
