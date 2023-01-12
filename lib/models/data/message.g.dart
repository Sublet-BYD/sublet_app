// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      text: json['text'] as String,
      userType: json['userType'] as String,
    )..createdAt = json['createdAt'] as String;

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'text': instance.text,
      'userType': instance.userType,
    };
