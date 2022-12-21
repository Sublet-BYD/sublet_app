import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sublet_app/screens/Owner/new_property.dart';
import 'properties_list_categories.dart';
import 'package:sublet_app/widgets/app_drawer.dart';

class ManageProperties extends StatelessWidget {
  const ManageProperties({super.key});

  void _startAddNewProperty(BuildContext context) {
    // The half window for adding new property
    showModalBottomSheet(
      context: context,
      builder: (((context) => NewProperty())),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String _recently = 'Recently Added';
    final String _occupied = 'Occupied Properties';
    final String _unoccupied = 'Unoccupied Properties';

    final appBar = AppBar(title: Text('Manage Properties'));

    return Scaffold(
        appBar: appBar,
        drawer: AppDrawer(),
        body: Column(
          children: <Widget>[
            // Search Bar
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.15,
              padding: EdgeInsets.only(top: 20, left: 40, right: 40),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.all(8.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            Container(
              // Categories Lists -
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.85,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    PropertiesListCategories(_recently),
                    PropertiesListCategories(_occupied),
                    PropertiesListCategories(_unoccupied),
                  ],
                ),
              ),
            )
          ],
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (() => _startAddNewProperty(context)),
        ),
        resizeToAvoidBottomInset: false
        // For the floating button to not get pushed up by keyboard
        );
  }
}
