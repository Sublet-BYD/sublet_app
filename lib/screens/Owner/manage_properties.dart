import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sublet_app/screens/Owner/new_property.dart';
import 'package:sublet_app/screens/Owner/tabs_screen.dart';
import 'properties_list_categories.dart';
import 'package:sublet_app/widgets/app_drawer.dart';

class ManageProperties extends StatefulWidget {
  const ManageProperties({super.key});

  @override
  State<ManageProperties> createState() => _ManagePropertiesState();
}

class _ManagePropertiesState extends State<ManageProperties> {
  final String _recently = 'Recently Added';

  final String _occupied = 'Occupied Properties';

  final String _unoccupied = 'Unoccupied Properties';

  // void refresh(){
  //     setState(() {

  //     });
  //   }

  @override
  Widget build(BuildContext context) {
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8.0),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(
                Icons.search,
                // color: Colors.white,
              ),
              contentPadding: EdgeInsets.all(8.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 60),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      child: Text(
                        'Recently Added',
                        style: TextStyle(
                          fontSize: 30 * curScaleFactor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: 15.0, left: 20),
                    ),
                    PropertiesListCategories(),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      child: Text(
                        'Recently Added',
                        style: TextStyle(
                          fontSize: 30 * curScaleFactor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: 15.0, left: 20),
                    ),
                    PropertiesListCategories(),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      child: Text(
                        'Recently Added',
                        style: TextStyle(
                          fontSize: 30 * curScaleFactor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: 15.0, left: 20),
                    ),
                    PropertiesListCategories(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
