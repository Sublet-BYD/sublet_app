import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sublet_app/screens/Owner/properties_list_view.dart';

import 'property.dart';

class PropertyCard extends StatelessWidget {
  final Property _property;

  PropertyCard(this._property);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: Container(
        width: 150.0,
        margin: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _property.name,
              style: TextStyle(
                  fontFamily: 'QuickSand',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Location: ${_property.location}',
              style: TextStyle(
                fontFamily: 'QuickSand',
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
