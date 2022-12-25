import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Property {
  final int id;
  final UniqueKey owner_id;
  final String name;
  final String location;
  final DateTime dateAdded;
  final DateTimeRange dates;
  final bool? occupied;
  final int price; // Price of subletting the property for a single night
  final ImageProvider? image;
  final String?
      description; // Short paragraph about the property which would be provided by the owner

  Property({
    required this.id,
    required this.name,
    required this.location,
    required this.owner_id,
    required this.dates,
    required this.price,
    required this.dateAdded,
    this.occupied = false, // any property would be available on default
    this.image,
    this.description,
  });
}
