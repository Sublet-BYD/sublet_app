// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sublet_app/Firebase_functions.dart';
import 'package:sublet_app/main.dart';
import 'package:sublet_app/screens/Owner/Owner_data.dart';
import 'package:sublet_app/screens/Owner/property.dart';
import 'package:sublet_app/screens/Renter/Renter_Screen.dart';
import 'package:intl/intl.dart';
import 'package:sublet_app/screens/chat_screen.dart';

class Asset_Page extends StatefulWidget {
  // static final int? property_id;
  const Asset_Page({Key? key}) : super(key: key);

  @override
  State<Asset_Page> createState() => _Asset_PageState();
}

class _Asset_PageState extends State<Asset_Page> {
  Color contact_color = (Colors.amber[600]!);
  Property property = Property(
      id: MyApp.property_id,
      name: 'name',
      location: 'location',
      owner_id:
          208512); // Will be taken from firebase according to the given key
  late Future<Owner_data> fut_owner;
  late Owner_data owner;
  void get_owner_data() async {
    owner = await fut_owner;
  }

  @override
  void initState() {
    fut_owner = Firebase_functions.get_owner(property.owner_id);
  }

  @override
  Widget build(BuildContext context) {
    get_owner_data();
    // sleep(Duration(milliseconds: 7));
    return FutureBuilder(
        future: fut_owner,
        builder: (context, AsyncSnapshot<Owner_data> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              child: ListView(
                children: [
                  //Image with buttons on top of it
                  SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top) *
                        0.3,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        //Image
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: FittedBox(
                              fit: BoxFit.fill,
                              child: Image(
                                image: AssetImage(
                                    'assets/Apartment_example.jpg'), //(property.image != null)? property.image as ImageProvider :
                              )),
                        ),
                        //Back button
                        Positioned(
                          top: 0,
                          left: 0,
                          child: FloatingActionButton(
                            backgroundColor: Colors.transparent,
                            child: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Renter_Screen()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          //Title of the property
                          FittedBox(
                            fit: BoxFit.fitHeight,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                shape: StadiumBorder(
                                  side: BorderSide(
                                    // border color
                                    color: Colors.purple,
                                    // border thickness
                                    width: 5,
                                  ),
                                ),
                                elevation: 1,
                                child: ListTile(
                                  title: Center(
                                      child: Text(property.name,
                                          style: TextStyle(
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20))),
                                ),
                              ),
                            ),
                          ),
                          //Address
                          Card(
                            elevation: 0,
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: ListTile(
                                  leading: Container(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Icon(Icons.location_on, size: 30),
                                  ),
                                  title: Text(property.location,
                                      style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          fontSize: 15)),
                                ),
                              ),
                            ),
                          ),
                          //Information about the property
                          FittedBox(
                            alignment: Alignment.center,
                            fit: BoxFit.fitHeight,
                            child: Container(
                              width: MediaQuery.of(context).size.width - 20,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              child: Card(
                                elevation: 0,
                                child: Text(
                                  (property.description != null &&
                                          property.description!.length > 5)
                                      ? property.description as String
                                      : '{Man} Once upon a time there was a lovely princess.But she had an enchantment upon her of a fearful sort which could only be broken by loves first kiss.She was locked away in a castle guarded by a terrible fire-breathing dragon.Many brave knigts had attempted to free her from this dreadful prison, but non prevailed.She waited in the dragons keep in the highest room of the tallest tower for her true love and true loves first kiss.{Laughing} Like thats ever gonna happen.',
                                  style: TextStyle(
                                      fontFamily: 'OpenSans', fontSize: 10),
                                ),
                              ),
                            ),
                          ),
                          //Information about the owner
                          Card(
                            elevation: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(top: 10),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/Empty_profile_pic.jpg'), // Commented out: owner.profile_pic
                                  radius: 40,
                                ),
                                title: Text('Meet your host, ${owner.name}',
                                    style: TextStyle(
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(
                                    'They\'ve been hosting since ${(owner != null) ? owner.joined_at : 'literally just now'}'),
                              ),
                            ),
                          ),
                          //Availability of asset
                          Card(
                            elevation: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: ListTile(
                                leading: Container(
                                  padding: EdgeInsets.only(left: 25),
                                  child: GestureDetector(
                                      onTap: () {
                                        //open a calendar widget to view dates - to do in the future
                                        print('Clicked on calendar\n');
                                      },
                                      child: Icon(Icons.calendar_month_outlined,
                                          size: 30)),
                                ),
                                title: Center(
                                    child: Text('available_dates:',
                                        style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.bold))),
                                subtitle: Center(
                                    child: Text(
                                        (property.fromdate != null &&
                                                property.tilldate != null)
                                            ? '${DateFormat('dd/MM/yyyy').format(property.fromdate!)} - ${DateFormat('dd/MM/yyyy').format(property.tilldate!)}'
                                            : 'No available dates',
                                        style:
                                            TextStyle(fontFamily: 'OpenSans'))),
                              ),
                            ),
                          ),
                          //Contact
                          GestureDetector(
                            //Changing the field's colour when pressed
                            // onTapDown: (details) {
                            //   setState(() {
                            //     contact_color = (Colors.amber[700]!);
                            //   });
                            // },
                            onTap: () {
                              //Move to chat with owner
                              print(owner.toJson());
                              print('Redirecting to chat\n');
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ChatScreen(),
                                ), // need to feel with owner and client - id
                              );
                            },
                            child: Card(
                              elevation: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: contact_color,
                                  border: Border.all(
                                      color: (Colors.amber[800]!),
                                      width:
                                          3), //Exclamation mark added to assure null safety
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: ListTile(
                                  leading: Container(
                                    padding: EdgeInsets.only(left: 25),
                                    child: Icon(Icons.comment, size: 30),
                                  ),
                                  title: Center(
                                      child: Text('Contact',
                                          style: TextStyle(
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.bold))),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        });
  }
  //Function that returns rgb values to indicate availability of asset
  // int available_color(bool available){
  //   if(available){
  //     return 0xFF8BC34A; //Light green
  //   }
  //   return 0xFFEF5350; // Light red
  // }
  // String available_msg(bool available){
  //   if(available){
  //     return 'This asset is currently available';
  //   }
  //   return 'This asset is currently occupied';
  // }
}
