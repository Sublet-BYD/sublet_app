import 'package:flutter/material.dart';

class CurrentChat with ChangeNotifier {
  final String chatId;
  String lastMessage;

  CurrentChat({required this.chatId, this.lastMessage = ''});

  // String get getchatId => chatId;

}
