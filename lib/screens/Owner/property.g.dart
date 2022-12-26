// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Property _$PropertyFromJson(Map<String, dynamic> json) => Property(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      owner_id: json['owner_id'] as String,
      price: json['price'] as int?,
      fromdate: json['fromdate'] == null
          ? null
          : DateTime.parse(json['fromdate'] as String),
      tilldate: json['tilldate'] == null
          ? null
          : DateTime.parse(json['tilldate'] as String),
      dateAdded: json['dateAdded'] == null
          ? null
          : DateTime.parse(json['dateAdded'] as String),
      occupied: json['occupied'] as bool? ?? false,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$PropertyToJson(Property instance) => <String, dynamic>{
      'id': instance.id,
      'owner_id': instance.owner_id,
      'name': instance.name,
      'location': instance.location,
      'dateAdded': instance.dateAdded?.toIso8601String(),
      'fromdate': instance.fromdate?.toIso8601String(),
      'tilldate': instance.tilldate?.toIso8601String(),
      'occupied': instance.occupied,
      'price': instance.price,
      'description': instance.description,
    };
