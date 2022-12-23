import 'package:flutter/material.dart';
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
      appBar: appBar,
      body: Column(
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
          Expanded(
            child: Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.8,
                child: Assetlist()),
          ),
        ],
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
  List<Property> list = [
    Property(
        id: UniqueKey(),
        owner_id: UniqueKey(),
        name: 'name',
        location: 'location'),
    Property(
        id: UniqueKey(),
        owner_id: UniqueKey(),
        name: 'name',
        location: 'location'),
    Property(
        id: UniqueKey(),
        owner_id: UniqueKey(),
        name: 'name',
        location: 'location'),
    Property(
        id: UniqueKey(),
        owner_id: UniqueKey(),
        name: 'name',
        location: 'location'),
    Property(
        id: UniqueKey(),
        owner_id: UniqueKey(),
        name: 'name',
        location: 'location'),
    Property(
        id: UniqueKey(),
        owner_id: UniqueKey(),
        name: 'name',
        location: 'location'),
    Property(
        id: UniqueKey(),
        owner_id: UniqueKey(),
        name: 'name',
        location: 'location'),
    Property(
        id: UniqueKey(),
        owner_id: UniqueKey(),
        name: 'name',
        location: 'location'),
    Property(
        id: UniqueKey(),
        owner_id: UniqueKey(),
        name: 'name',
        location: 'location')
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      alignment: Alignment.bottomCenter,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: () {
              onPress(context, list[index].id);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: Card(
                shape: RoundedRectangleBorder(
                  //Making each card's edges circular
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: (list[index].image != null)
                        ? list[index].image as ImageProvider
                        : AssetImage('assets/Apartment_example.jpg'),
                    radius: 50,
                  ),
                  title: Text((list[index].name != null &&
                          list[index].name.length > 5)
                      ? list[index].name
                      : 'No available name'), // The comparison is technically unneccesary, since name cant be null, but is still used as a safety precaution
                  subtitle: Text((list[index].location != null)
                      ? list[index].location
                      : 'No available location'),
                  trailing: Text((list[index].price != null)
                      ? list[index].price.toString() + '\$'
                      : '0\$'),
                ),
              ),
            ),
          );
        },
        itemCount: 9,
      ),
    );
  }

  void onPress(BuildContext context, UniqueKey asset_id) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Asset_Page(
              property_id: asset_id,
            )));
  }
}
