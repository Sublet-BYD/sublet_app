// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Owner_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Owner_data _$Owner_dataFromJson(Map<String, dynamic> json){
  return Owner_data(
      json['name'] as String,
      plist: (json['plist'] as List<dynamic>?)?.map((e) => e as int).toList() ??
          const [],
      id: json['id'] as int?,
      joined_at: json['joined_at'] as int?,
    );
}
// } => Owner_data(
//       json['name'] as String,
//       plist: (json['plist'] as List<dynamic>?)?.map((e) => e as int).toList() ??
//           const [],
//       id: json['id'] as int?,
//       joined_at: json['joined_at'] as int?,
//     );

Map<String, dynamic> _$Owner_dataToJson(Owner_data instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'plist': instance.plist,
      'joined_at': instance.joined_at,
    };
