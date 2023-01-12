// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sublet_app/Firebase_functions.dart';
import 'package:sublet_app/models/data/property.dart';
import 'package:sublet_app/screens/Guest/Asset_Page.dart';
import 'package:sublet_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import 'package:sublet_app/providers/Session_details.dart';
import 'package:sublet_app/models/sort_menu.dart';

class Renter_Screen extends StatefulWidget {
  const Renter_Screen({super.key});

  @override
  State<Renter_Screen> createState() => _Renter_ScreenState();
}

class _Renter_ScreenState extends State<Renter_Screen> {
  String uname = 'No name';
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Welcome, $uname'),
    );
    void showSortPanel() {
      showModalBottomSheet(
          context: context,
          builder: ((context) {
            return Sort_Menu();
          }));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false, // Preventing pixel overflow warnings
      drawer: AppDrawer(),
      // appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // Temporary, will be changed into sort/search using multiple variables in the future.
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.1,
              width: (MediaQuery.of(context).size.width),
              padding: EdgeInsets.only(top: 20, left: 40, right: 40),
              child: ElevatedButton(
                onPressed: showSortPanel,
                child: Text(
                  'Search',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shadowColor: Colors.transparent,
                ),
              ),
            ),
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.85,
                child: Assetlist()),
          ],
        ),
      ),
    );
  }
}

class Assetlist extends StatefulWidget {
  const Assetlist({super.key});
  @override
  State<Assetlist> createState() => _AssetlistState();
}

class _AssetlistState extends State<Assetlist> {
  var assetImage = 'assets/Apartment_example.jpg';

  @override
  Widget build(BuildContext context) {
    // get_avail_properties();
    var proStream =
        FirebaseFirestore.instance.collection('properties').snapshots();
    return StreamBuilder(
        stream: proStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 70),
              physics: BouncingScrollPhysics(),
              itemBuilder: (ctx, index) {
                final _property_data = snapshot.data!.docs[index].data(); // Renamed _propert_id to _property_data
                // VERY IMPORTANT: Change assetimage to be the first image in the url list of the property.
                // This will only be doable after finishing the implementation of url list in the Firebase collection
                // assetImage = 
                final Property property = Property.fromJson(_property_data);
                return GestureDetector(
                    onTap: () async {
                      onPress(context, _property_data['id'], property.owner_id);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: (MediaQuery.of(context).size.height -
                                MediaQuery.of(context).padding.top) *
                            0.12,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            //Making each card's edges circular
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(
                                assetImage,
                              ),
                              radius: 50,
                            ),
                            title: Text((property
                                .name)), // The comparison is technically unneccesary, since name cant be null, but is still used as a safety precaution
                            subtitle: Text((property.location != null)
                                ? property.location
                                : 'No available location'),
                            trailing: Text((property.price != null)
                                ? '${property.price}\$'
                                : '0\$'),
                          ),
                        ),
                      ),
                    ));
              },
              itemCount: snapshot.data!.docs.length,
            );
          }
        });
  }

  void onPress(BuildContext context, String asset_id, String host_id) {
    context.read<Session_details>().UpdatePropertyId(asset_id);
    context.read<Session_details>().UpdateHostId(host_id);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AssetPage(
          imagePath: assetImage,
        ),
      ),
    );
  }
}
