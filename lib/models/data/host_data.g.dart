// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Owner_data _$Owner_dataFromJson(Map<String, dynamic> json) => Owner_data(
      json['name'] as String,
      json['id'] as String,
      plist:
          (json['plist'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      joined_at: json['joined_at'] as int?,
      chat_id_list: (json['chat_id_list'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$Owner_dataToJson(Owner_data instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'plist': instance.plist,
      'joined_at': instance.joined_at,
      'chat_id_list': instance.chat_id_list,
    };
