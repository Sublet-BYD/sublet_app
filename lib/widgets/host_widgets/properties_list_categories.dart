import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:sublet_app/Firebase_functions.dart';
import 'package:sublet_app/providers/Session_details.dart';
import 'package:sublet_app/providers/firestore_properties.dart';
import 'property_card.dart';
import '../../models/data/property.dart';

class PropertiesListCategories extends StatefulWidget {
  Stream proStream;
  PropertiesListCategories({super.key, required this.proStream});
  @override
  State<PropertiesListCategories> createState() =>
      _PropertiesListCategoriesState();
}

class _PropertiesListCategoriesState extends State<PropertiesListCategories> {
  void onPropertyCardPress(BuildContext ctx, Property property) async {
    Navigator.of(ctx).pushNamed(
      '/property-screen',
      arguments: property,
    );
  }

  // late Future<List<Property>> _properties;
  // late List<Property> plist;
  // @override
  // void initState() {
  //   // _properties = Firebase_functions.get_properties_of_owner(Provider.of<Session_details>(context).uid);
  // }
  // void update_plist() async {
  //   plist = await _properties;
  // }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return StreamBuilder(
        stream: widget.proStream,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            margin: const EdgeInsets.only(top: 10, bottom: 15),
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 10),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final propertId = snapshot.data!.docs[index].data();
                    final propertyObj = Property.fromJson(propertId);
                    return InkWell(
                      splashColor: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                      onTap: (() => onPropertyCardPress(context, propertyObj)),
                      child: PropertyCard(propertyObj),
                    );
                  },
                  itemCount: snapshot.data!.docs.length,
                ),
              ),
            ),
          );
        }));
  }
}
