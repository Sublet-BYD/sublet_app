// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatUsers _$ChatUsersFromJson(Map<String, dynamic> json) => ChatUsers(
      hostId: json['hostId'] as String,
      guestId: json['guestId'] as String,
      hostName: json['hostName'] as String,
      guestName: json['guestName'] as String,
      hostImageURL: json['hostImageURL'] as String,
      guestImageURL: json['guestImageURL'] as String,
    );

Map<String, dynamic> _$ChatUsersToJson(ChatUsers instance) => <String, dynamic>{
      'hostId': instance.hostId,
      'guestId': instance.guestId,
      'hostName': instance.hostName,
      'guestName': instance.guestName,
      'hostImageURL': instance.hostImageURL,
      'guestImageURL': instance.guestImageURL,
    };
