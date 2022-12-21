import 'package:flutter/material.dart';
import 'package:sublet_app/screens/Renter/Renter_Screen.dart';


class Asset_Page extends StatefulWidget {
  const Asset_Page({super.key});

  @override
  State<Asset_Page> createState() => _Asset_PageState();
}

class _Asset_PageState extends State<Asset_Page> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          //Image with buttons on top of it
          Expanded(
            flex: 3,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                //Image
                Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image(image: AssetImage('assets/Apartment_example.jpg'),
                      )
                    ),
                ),
                //Back button
                Positioned(
                  top:0,
                  left:0,
                  child: FloatingActionButton(
                    backgroundColor: Colors.transparent,
                    child: Icon(Icons.arrow_back),
                    onPressed: (){
                      Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Renter_Screen()));
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              color: Colors.white,
            ),
          ),
      ],
    );
  }
}