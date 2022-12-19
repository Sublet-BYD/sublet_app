import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sublet_app/screens/Owner/new_property.dart';

class ManageProperties extends StatelessWidget {
  const ManageProperties({super.key});

  void _startAddNewProperty(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (((context) => NewProperty())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Properties')),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.all(8.0),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
          )
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (() => _startAddNewProperty(context)),
      ),
    );
  }
}
