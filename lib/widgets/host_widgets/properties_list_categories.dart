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
  // @override
  // void initState() {
  //   // _properties = Firebase_functions.get_properties_of_owner(Provider.of<Session_details>(context).uid);
  // }
  void update_plist() async {
    plist = await _properties;
  }

  @override
  Widget build(BuildContext context) {
    var proStream = FirebaseFirestore.instance
        .collection('properties')
        .where("owner_id",
            isEqualTo: Provider.of<Session_details>(context).UserId.toString())
        .snapshots();
    print("LENTGHHHHHHHHHHHHHHHHHHHHH ${proStream.length.toString()}");
    setState(() {});
    return StreamBuilder(
        stream: proStream,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            margin: EdgeInsets.only(top: 10, bottom: 15),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                child: ListView.builder(
                  padding: EdgeInsets.only(left: 10),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final _propert_id = snapshot.data!.docs[index].data();
                    print("property_id");
                    print(Property.fromJson(_propert_id).id);
                    return InkWell(
                        splashColor: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20),
                        onTap: (() => onPropertyCardPress(context, index)),
                        child: PropertyCard(Property.fromJson(_propert_id)));
                  },
                  // return PropertyCard(plist[index]);
                  itemCount: snapshot.data!.docs.length,
                ),
              ),
            ),
          );
        }));
  }
}
