import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sublet_app/screens/Owner/property_screen.dart';
import '/screens/Owner/property_card.dart';
import '/screens/Owner/property.dart';

class PropertiesListCategories extends StatelessWidget {
  final String _title;

  PropertiesListCategories(this._title, {super.key});

  void onPropertyCardPress(BuildContext ctx, int asset_id) {
    Navigator.of(ctx).pushNamed(
      '/property-screen',
      arguments: _properties[asset_id],
    );
  }

  final List<Property> _properties = [
    Property(
      id: UniqueKey(),
      owner_id: UniqueKey(),
      location: 'Na\'ale',
      name: 'Villa BaShtahim',
      dates: DateTimeRange(start: DateTime.now(), end: DateTime.now()),
    ),
    Property(
      id: UniqueKey(),
      owner_id: UniqueKey(),
      location: 'Na\'ale',
      name: 'Villa BaShtahim',
      dates: DateTimeRange(start: DateTime.now(), end: DateTime.now()),
    ),
    Property(
      id: UniqueKey(),
      owner_id: UniqueKey(),
      location: 'Na\'ale',
      name: 'Villa BaShtahim',
      dates: DateTimeRange(start: DateTime.now(), end: DateTime.now()),
    ),
    Property(
      id: UniqueKey(),
      owner_id: UniqueKey(),
      location: 'Na\'ale',
      name: 'Villa BaShtahim',
      dates: DateTimeRange(start: DateTime.now(), end: DateTime.now()),
    ),
    Property(
      id: UniqueKey(),
      owner_id: UniqueKey(),
      location: 'Na\'ale',
      name: 'Villa BaShtahim',
      dates: DateTimeRange(start: DateTime.now(), end: DateTime.now()),
    ),
    Property(
      id: UniqueKey(),
      owner_id: UniqueKey(),
      location: 'Na\'ale',
      name: 'Villa BaShtahim',
      dates: DateTimeRange(start: DateTime.now(), end: DateTime.now()),
    ),
    Property(
      id: UniqueKey(),
      owner_id: UniqueKey(),
      location: 'Na\'ale',
      name: 'Villa BaShtahim',
      dates: DateTimeRange(start: DateTime.now(), end: DateTime.now()),
    ),
    Property(
      id: UniqueKey(),
      owner_id: UniqueKey(),
      location: 'Na\'ale',
      name: 'Villa BaShtahim',
      dates: DateTimeRange(start: DateTime.now(), end: DateTime.now()),
    ),
    Property(
      id: UniqueKey(),
      owner_id: UniqueKey(),
      location: 'Na\'ale',
      name: 'Villa BaShtahim',
      dates: DateTimeRange(start: DateTime.now(), end: DateTime.now()),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title of the category
            Container(
              child: Text(
                _title,
                style: TextStyle(
                  fontSize: 30 * curScaleFactor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
              margin: EdgeInsets.only(bottom: 15.0, left: 20),
            ),
            // Row Presentation of the properties of this category.

            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              child: ListView.builder(
                padding: EdgeInsets.only(left: 10),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                      splashColor: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                      onTap: (() => onPropertyCardPress(context, index)),
                      child: PropertyCard(this._properties[index]));
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
