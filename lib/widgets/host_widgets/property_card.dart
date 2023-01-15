import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sublet_app/widgets/host_widgets/properties_list_categories.dart';

import '../../models/data/property.dart';

class PropertyCard extends StatelessWidget {
  final Property _property;

  const PropertyCard(this._property);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: Container(
        height: 500,
        width: 250.0,
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
                  child: _property.imageUrls!.isEmpty
                      ? Image.asset(
                          'assets/Images/home-placeholder-profile.jpg',
                          fit: BoxFit.fill,
                        )
                      : Image.network(
                          _property.imageUrls![0],
                          fit: BoxFit.fill,
                          height: 200,
                          width: 40,
                        ),
                ),
                SizedBox(
                  height: 10,
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
