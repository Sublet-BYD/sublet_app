import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sublet_app/screens/Owner/properties_list_categories.dart';

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
        child: LayoutBuilder(
          builder: (context, constrains) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: Image.asset(
                    'assets/Apartment_example.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    _property.name,
                    style: TextStyle(
                        fontFamily: 'QuickSand',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Location: ${_property.location}',
                    style: TextStyle(
                      fontFamily: 'QuickSand',
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
