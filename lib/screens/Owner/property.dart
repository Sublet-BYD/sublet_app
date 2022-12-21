import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Property {
  final UniqueKey id;
  final String name;
  final String location;
  final DateTimeRange? dates;
  final Image? image;
  final String? description; // Short paragraph about the property which would be provided by the owner

  Property({
    required this.id,
    required this.name,
    required this.location,
    this.dates,
    this.description,
    this.image,
  });
}
