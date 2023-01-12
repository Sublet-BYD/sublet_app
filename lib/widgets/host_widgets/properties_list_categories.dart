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
  final String title;
  final Stream proStream;
  const PropertiesListCategories({
    super.key,
    required this.proStream,
    required this.title,
  });
  @override
  State<PropertiesListCategories> createState() =>
      _PropertiesListCategoriesState();
}

class _PropertiesListCategoriesState extends State<PropertiesListCategories> {
  void onPropertyCardPress(BuildContext ctx) async {
    Navigator.of(ctx).pushNamed('/property-screen');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.proStream,
        builder: ((context, snapshot) {
          print('snapshot, data=${snapshot.data}, title=${widget.title}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (!snapshot.hasData) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: const Text("Not available properties here"),
                );
              }
              final data = snapshot.data as QuerySnapshot;
              return Container(
                margin: const EdgeInsets.only(top: 10, bottom: 15),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(left: 10),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final propertyJson =
                            data.docs[index].data() as Map<String, dynamic>;
                        final propertyObj = Property.fromJson(propertyJson);
                        return InkWell(
                          splashColor: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                          onTap: (() {
                            Provider.of<Session_details>(context)
                                .UpdateProperty(propertyObj);
                            return onPropertyCardPress(context);
                          }),
                          child: PropertyCard(propertyObj),
                        );
                      },
                      itemCount: data.docs.length,
                    ),
                  ),
                ),
              );
          }

          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          // if (!snapshot.hasData) {
          //   print('HII NO St: ${snapshot.data}');
          //   return Container(
          //     height: 300,
          //     width: 300,
          //     color: Colors.red,
          //   );
          // }
          // if (snapshot.data?.docs.length == 0) {
          //   return SizedBox(
          //       height: MediaQuery.of(context).size.height * 0.25,
          //       child: const Text("Not available properties here"));
          // }

          // return Container(
          //   margin: const EdgeInsets.only(top: 10, bottom: 15),
          //   child: SingleChildScrollView(
          //     child: SizedBox(
          //       height: MediaQuery.of(context).size.height * 0.25,
          //       child: ListView.builder(
          //         padding: const EdgeInsets.only(left: 10),
          //         scrollDirection: Axis.horizontal,
          //         itemBuilder: (context, index) {
          //           final propertId = snapshot.data?.docs[index].data();
          //           final propertyObj = Property.fromJson(propertId);
          //           return InkWell(
          //             splashColor: Theme.of(context).primaryColor,
          //             borderRadius: BorderRadius.circular(20),
          //             onTap: (() => onPropertyCardPress(context, propertyObj)),
          //             child: PropertyCard(propertyObj),
          //           );
          //         },
          //         itemCount: snapshot.data?.docs.length,
          //       ),
          //     ),
          //   ),
          // );
        }));
  }
}
