// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sublet_app/Firebase_functions.dart';
import 'package:sublet_app/main.dart';
import 'package:sublet_app/screens/Owner/property.dart';
import 'package:sublet_app/screens/Renter/Asset_Page.dart';
import 'package:sublet_app/widgets/app_drawer.dart';

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
  late Future<List<Property>> list;
  List<Property> plist = [];
  late int list_length;
  List<Card> cards = [];

  void get_avail_properties() async {
    plist = await list;
  }

  @override
  void initState() {
    list = Firebase_functions.get_avail_properties();
  }

  @override
  Widget build(BuildContext context) {
    get_avail_properties();
    // setState(() =>{} );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      alignment: Alignment.bottomCenter,
      child: FutureBuilder(
          future: list,
          builder:
              (BuildContext build, AsyncSnapshot<List<Property>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 70),
                physics: BouncingScrollPhysics(),
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                      onTap: () async {
                        onPress(context, (await list)[index].id!);
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
                                    'assets/Apartment_example.jpg'), // (list[index].image != null)? list[index].image as ImageProvider :
                                radius: 50,
                              ),
                              title: Text((plist[index]
                                  .name)), // The comparison is technically unneccesary, since name cant be null, but is still used as a safety precaution
                              subtitle: Text((plist[index].location != null)
                                  ? plist[index].location
                                  : 'No available location'),
                              trailing: Text((plist[index].price != null)
                                  ? '${plist[index].price}\$'
                                  : '0\$'),
                            ),
                          ),
                        ),
                      ));
                },
                itemCount: plist.length,
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container();
          }),
    );
  }

  void onPress(BuildContext context, String asset_id) {
    MyApp.property_id = asset_id;
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Asset_Page()));
  }
}
