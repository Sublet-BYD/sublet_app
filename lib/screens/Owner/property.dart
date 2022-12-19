import 'package:flutter/cupertino.dart';

class Property {
  final UniqueKey id;
  final String name;
  final String location;
  final DateTime? date;

  Property({
    required this.id,
    required this.name,
    required this.location,
    this.date,
  });
}
