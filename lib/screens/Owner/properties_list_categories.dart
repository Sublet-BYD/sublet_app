import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '/screens/Owner/property_card.dart';
import '/screens/Owner/property.dart';

class PropertiesListCategories extends StatelessWidget {
  final String _title;

  PropertiesListCategories(this._title, {super.key});

  final List<Property> _properties = [
    Property(
      id: UniqueKey(),
      location: 'Na\'ale',
      name: 'Villa BaShtahim',
      date: DateTime.now(),
    ),
    Property(
      id: UniqueKey(),
      location: 'Na\'ale',
      name: 'Villa BaShtahim',
      date: DateTime.now(),
    ),
    Property(
      id: UniqueKey(),
      location: 'Na\'ale',
      name: 'Villa BaShtahim',
      date: DateTime.now(),
    ),
    Property(
      id: UniqueKey(),
      location: 'Na\'ale',
      name: 'Villa BaShtahim',
      date: DateTime.now(),
    ),
    Property(
      id: UniqueKey(),
      location: 'Na\'ale',
      name: 'Villa BaShtahim',
      date: DateTime.now(),
    ),
    Property(
      id: UniqueKey(),
      location: 'Na\'ale',
      name: 'Villa BaShtahim',
      date: DateTime.now(),
    ),
    Property(
      id: UniqueKey(),
      location: 'Na\'ale',
      name: 'Villa BaShtahim',
      date: DateTime.now(),
    ),
    Property(
      id: UniqueKey(),
      location: 'Na\'ale',
      name: 'Villa BaShtahim',
      date: DateTime.now(),
    ),
    Property(
      id: UniqueKey(),
      location: 'Na\'ale',
      name: 'Villa BaShtahim',
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title of the category
            Container(
              child: Text(
                _title,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
              margin: EdgeInsets.only(bottom: 15.0, left: 20),
            ),
            // Row Presentation of the properties of this category.

            Container(
              height: 200,
              child: ListView.builder(
                padding: EdgeInsets.only(left: 10),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return PropertyCard(this._properties[index]);
                },
                itemCount: _properties.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
