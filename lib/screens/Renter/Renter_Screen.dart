import 'package:flutter/material.dart';

class Renter_Screen extends StatefulWidget {
  const Renter_Screen({super.key});

  @override
  State<Renter_Screen> createState() => _Renter_ScreenState();
}

class _Renter_ScreenState extends State<Renter_Screen> {
  String uname = 'No name';
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: Text('Welcome, $uname'),);
    return Scaffold(
      resizeToAvoidBottomInset: false, // Preventing pixel overflow warnings
      appBar: appBar,
      body: Column(
        children: [
          Container( // Temporary, will be changed into sort/search using multiple variables in the future.
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) * 0.2,
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
            height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) *0.8,           
            child: AssetList()
          ),
        ],
      ),
    );
  }
}

class AssetList extends StatelessWidget {
  const AssetList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      alignment: Alignment.bottomCenter,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: () {
              onPress(context, index);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: SizedBox(
                height: 100,
                child: Card(
                  shape: RoundedRectangleBorder( //Making each card's edges circular
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                        Text(index.toString()),
                        const VerticalDivider(
                          width: 20,
                          color: Colors.black,
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/Apartment_example.jpg'),
                          radius: 30,
                        ),
                        const VerticalDivider(
                          width: 20,
                          color: Colors.black,
                        ),
                    ],
                  ),
                ),
              ),
            ), 
          );  
        },
        itemCount: 10,
      ),
    );
  }
  void onPress(BuildContext context, int asset_id){
      print(asset_id);
  }
}
