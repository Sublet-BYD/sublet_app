import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chat_user.g.dart';

@JsonSerializable(explicitToJson: true)
class ChatUsers {
  String hostId;
  String guestId;
  String hostName;
  String guestName;
  String hostImageURL;
  String guestImageURL;
  ChatUsers({
    required this.hostId,
    required this.guestId,
    required this.hostName,
    required this.guestName,
    required this.hostImageURL,
    required this.guestImageURL,
  });

  factory ChatUsers.fromJson(Map<String, dynamic> json) {
    return _$ChatUsersFromJson(json);
  }
}
