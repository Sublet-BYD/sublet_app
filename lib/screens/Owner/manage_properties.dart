import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sublet_app/screens/Owner/new_property.dart';
import 'properties_list_categories.dart';
import 'package:sublet_app/widgets/app_drawer.dart';

class ManageProperties extends StatelessWidget {
  const ManageProperties({super.key});

  final String _recently = 'Recently Added';
  final String _occupied = 'Occupied Properties';
  final String _unoccupied = 'Unoccupied Properties';

  @override
  Widget build(BuildContext context) {
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
                PropertiesListCategories(_recently),
                PropertiesListCategories(_occupied),
                PropertiesListCategories(_unoccupied),
                ElevatedButton(
                  // onPressed: () => Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => Scaffold(
                  //         body: Center(
                  //           child: ElevatedButton(
                  //             onPressed: () {
                  //               if (Navigator.canPop(context)) {
                  //                 Navigator.pop(context);
                  //               }
                  //             },
                  //             child: const Text('POP'),
                  //           ),
                  //         ),
                  //       ),
                  //     )),
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('PUSH'),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
