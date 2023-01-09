import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:sublet_app/Firebase_functions.dart';
import 'package:sublet_app/providers/Session_details.dart';
import '/screens/Owner/property_card.dart';
import '/screens/Owner/property.dart';

class PropertiesListCategories extends StatefulWidget {
  const PropertiesListCategories({super.key});
  @override
  State<PropertiesListCategories> createState() =>
      _PropertiesListCategoriesState();
}

class _PropertiesListCategoriesState extends State<PropertiesListCategories> {
  void onPropertyCardPress(BuildContext ctx, int asset_id) async {
    Navigator.of(ctx).pushNamed(
      '/property-screen',
      arguments: (await _properties)[asset_id],
    );
  }

  late Future<List<Property>> _properties;
  late List<Property> plist;
  @override
  void initState() {
    _properties = Firebase_functions.get_properties_of_owner(Provider.of<Session_details>(context).uid);
  }
  void update_plist() async{
    plist = await _properties;
  }

  @override
  Widget build(BuildContext context) {
    update_plist();
    setState(() {
      
    });
    return FutureBuilder(
        future: _properties,
        builder:
            (BuildContext context, AsyncSnapshot<List<Property>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              margin: EdgeInsets.only(top: 10, bottom: 15),
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: 10),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                          splashColor: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                          onTap: (() =>
                              onPropertyCardPress(context, index)),
                          child: PropertyCard(plist[index]));
                    },
                    // return PropertyCard(plist[index]);
                    itemCount: plist.length,
                  ),
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        });
  }
}
