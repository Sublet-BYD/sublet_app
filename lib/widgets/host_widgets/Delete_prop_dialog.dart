// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sublet_app/Firebase_functions.dart';
import 'package:sublet_app/models/data/property.dart';

class Delete_prop_dialog extends StatefulWidget {
  final Property property;
  const Delete_prop_dialog({super.key, required this.property});

  @override
  State<Delete_prop_dialog> createState() => _Delete_prop_dialogState();
}

class _Delete_prop_dialogState extends State<Delete_prop_dialog> {
  @override
  Widget build(BuildContext context) {
    Property _property = widget.property;
    if (_property.occupied!) {
      return AlertDialog(
        title: Text('Cannot delete'),
        content: Text(
            'You cannot delete this property, as it is currently occupied.'),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ),
        ],
      );
    }
    return AlertDialog(
      title: Text('Confirm deletion'),
      content: Text( 'Are you sure you want to delete this property?'),
      actions: [
        ElevatedButton(
          onPressed: () {            
            Navigator.pop(context);            
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Firebase_functions.Delete_property(_property.id!);
            var nav = Navigator.of(context);
            nav.pop();
            nav.pop();
          },
          child: Text('Confirm'),
        )
      ],
    );
  }
}
