import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:sublet_app/providers/Session_details.dart';
import 'package:sublet_app/providers/firestore_properties.dart';
import 'package:sublet_app/screens/Host/new_property.dart';
import 'package:sublet_app/screens/Host/tabs_screen.dart';
import 'properties_list_categories.dart';
import 'package:sublet_app/widgets/app_drawer.dart';

class ManageProperties extends StatefulWidget {
  const ManageProperties({super.key});

  @override
  State<ManageProperties> createState() => _ManagePropertiesState();
}

class _ManagePropertiesState extends State<ManageProperties> {
  // void refresh(){
  //     setState(() {

  //     });
  //   }

  @override
  Widget build(BuildContext context) {
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Consumer<FirestoreProperties>(
        builder: (context, firestoreProperties, child) {
      return Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8.0),
          //   child: TextFormField(
          //     decoration: InputDecoration(
          //       labelText: 'Search',
          //       prefixIcon: const Icon(
          //         Icons.search,
          //         // color: Colors.white,
          //       ),
          //       contentPadding: EdgeInsets.all(8.0),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(30),
          //       ),
          //     ),
          //   ),
          // ),
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
                      PropertiesListCategories(
                          proStream:
                              firestoreProperties.getRecentHostProperties(
                                  Provider.of<Session_details>(context)
                                      .UserId)),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        child: Text(
                          'Occupied Properties',
                          style: TextStyle(
                            fontSize: 30 * curScaleFactor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                        margin: EdgeInsets.only(bottom: 15.0, left: 20),
                      ),
                      PropertiesListCategories(
                          proStream:
                              firestoreProperties.getOccupiedHostProperties(
                                  Provider.of<Session_details>(context)
                                      .UserId)),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        child: Text(
                          'Unoccupied Properties',
                          style: TextStyle(
                            fontSize: 30 * curScaleFactor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                        margin: EdgeInsets.only(bottom: 15.0, left: 20),
                      ),
                      PropertiesListCategories(
                          proStream:
                              firestoreProperties.getAvailableHostProperties(
                                  Provider.of<Session_details>(context)
                                      .UserId)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
