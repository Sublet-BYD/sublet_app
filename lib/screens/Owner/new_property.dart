import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NewProperty extends StatefulWidget {
  const NewProperty({super.key});

  @override
  State<NewProperty> createState() => _NewPropertyState();
}

class _NewPropertyState extends State<NewProperty> {
  final propNameController = TextEditingController();
  final propLocationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Property Name'),
              controller: propNameController,
              onSubmitted: ((value) {}), // TODO
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Property Location'),
              controller: propLocationController,
              onSubmitted: ((value) {}), // TODO
            ),
          ],
        ),
      ),
    );
  }
}
