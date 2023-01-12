import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'property.g.dart';

@JsonSerializable()
class Property {
  String? id;
  final String owner_id;
  late String name;
  late String location;
  late DateTime? dateAdded, fromdate, tilldate;
  // final DateTimeRange? dates;
  late bool? occupied;
  final int? price; // Price of subletting the property for a single night
  // final ImageProvider? image;
  late String?
      description; // Short paragraph about the property which would be provided by the owner
  var image;
  var imageUrl;
  List<String>? imageUrls;

  Property({
    this.id,
    required this.name,
    required this.location,
    required this.owner_id,
    // this.dates,
    this.price,
    this.fromdate,
    this.tilldate,
    this.dateAdded,
    this.occupied = false, // any property would be available on default
    // this.image,
    this.description,
    this.image,
    this.imageUrls,
  }) {
    dateAdded = DateTime.now();
    
  }


  void assign_id(String id) {
    // This function will be called by Firebase_functions when uploading a new owner to the database.
    this.id = id;
  }

  factory Property.fromJson(Map<String, dynamic> json) {
    return _$PropertyFromJson(json);
  }
  Map<String, dynamic> toJson() => _$PropertyToJson(this);
}
