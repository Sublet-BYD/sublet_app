import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Property {
  final UniqueKey id;
  final UniqueKey owner_id;
  final String name;
  final String location;
  final DateTimeRange? dates;
  final ImageProvider? image;
  final String? description; // Short paragraph about the property which would be provided by the owner
  final int? price; // Price of subletting the property for a single night

  Property({
    required this.id,
    required this.name,
    required this.location,
    required this.owner_id,
    this.dates,
    this.description,
    this.image,
    this.price,
  });
}
