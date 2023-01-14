// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:sublet_app/models/Pair.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sublet_app/models/data/chat_user.dart';
import 'package:sublet_app/models/data/message.dart';
import 'package:sublet_app/providers/Session_details.dart';
import 'package:sublet_app/models/data/host_data.dart';
import 'package:sublet_app/models/data/property.dart';
import 'package:intl/intl.dart';
import 'package:sublet_app/providers/firestore_chat.dart';
import 'package:sublet_app/screens/Host/tabs_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../providers/current_chat.dart';
import '../Chat/chat_details_screen.dart';

class AssetPage extends StatefulWidget {
  final String imagePath;
  const AssetPage({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> {
  Color contact_color = (Colors.amber[600]!);
  late Future<Pair<Property, Owner_data>> data;
  late Property property;
  late Owner_data owner;
  int activateIndex = 0;

  Future<Pair<Property, Owner_data>> getData() async {
    data = Provider.of<Session_details>(context, listen: false).GetProp_Host();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final selfAccount = Provider.of<Session_details>(context);
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: getData(),
          builder:
              (context, AsyncSnapshot<Pair<Property, Owner_data>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                property = snapshot.data!.obj1;
                owner = snapshot.data!.obj2;
              }

              return Column(
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
                          child: Hero(
                            tag: widget.imagePath,
                            child: Column(
                              children: [
                                //Image slider
                                CarouselSlider.builder(
                                  options: CarouselOptions(
                                    height: 200,
                                    reverse: true,
                                    //viewportFraction: 1, //only one image
                                    //enlargeCenterPage: true,
                                    //enableInfiniteScroll: false, //lime the slider
                                    onPageChanged: (index, reason) =>
                                        setState(() => activateIndex = index),
                                  ),
                                  itemCount: property.imageUrls!.length,
                                  itemBuilder: ((context, index, realIndex) {
                                    if (property.imageUrls!.isEmpty) {
                                      return Image.asset(
                                        'assets/Images/home-placeholder-profile.jpg',
                                        fit: BoxFit.fill,
                                      );
                                    }
                                    print(property.imageUrls!.length);
                                    final urlImage = property.imageUrls![index];
                                    // for (int i = 0;
                                    //     i < property.imageUrls!.length;
                                    //     i++) {
                                    //   print(property.imageUrls![i]);
                                    // }

                                    return buildImage(urlImage, index);
                                  }),
                                ),
                                //Dot indicator
                                const SizedBox(
                                  height: 5,
                                ),
                                if (property.imageUrls!.isNotEmpty)
                                  buildIndicator(property.imageUrls!.length)
                                else
                                  buildIndicator(1)
                              ],
                            ),
                          ),
                        ),
                        //Back button
                        Positioned(
                          top: 0,
                          left: 0,
                          child: FloatingActionButton(
                            backgroundColor: Colors.transparent,
                            child: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ListView(
                      children: [
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
                                          child:
                                              Icon(Icons.location_on, size: 30),
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
                                    width:
                                        MediaQuery.of(context).size.width - 20,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: Card(
                                      elevation: 0,
                                      child: Text(
                                        (property.description != null &&
                                                property.description!.length >
                                                    5)
                                            ? property.description as String
                                            : '{Man} Once upon a time there was a lovely princess.But she had an enchantment upon her of a fearful sort which could only be broken by loves first kiss.She was locked away in a castle guarded by a terrible fire-breathing dragon.Many brave knigts had attempted to free her from this dreadful prison, but non prevailed.She waited in the dragons keep in the highest room of the tallest tower for her true love and true loves first kiss.{Laughing} Like thats ever gonna happen.',
                                        style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontSize: 10),
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
                                      title: Text(
                                          'Meet your host, ${owner.name}',
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
                                            child: Icon(
                                                Icons.calendar_month_outlined,
                                                size: 30)),
                                      ),
                                      title: Center(
                                          child: Text('available_dates:',
                                              style: TextStyle(
                                                  fontFamily: 'OpenSans',
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      subtitle: Center(
                                          child: Text(
                                              (property.fromdate != null &&
                                                      property.tilldate != null)
                                                  ? '${DateFormat('dd/MM/yyyy').format(property.fromdate!)} - ${DateFormat('dd/MM/yyyy').format(property.tilldate!)}'
                                                  : 'No available dates',
                                              style: TextStyle(
                                                  fontFamily: 'OpenSans'))),
                                    ),
                                  ),
                                ),
                                //Contact
                                GestureDetector(
                                  // new implementation on chat!
                                  // please ask before change
                                  onTap: () {
                                    final newChat = ChatUsers(
                                        hostId: owner.id,
                                        guestId: selfAccount.UserId,
                                        hostName: owner.name,
                                        guestName: selfAccount.UserName,
                                        hostImageURL: (owner.imageUrl
                                                    .toString()
                                                    .isEmpty ||
                                                owner.imageUrl == null)
                                            ? 'https://firebasestorage.googleapis.com/v0/b/sublet-34e39.appspot.com/o/Empty_profile_pic.jpg?alt=media&token=3d3a8c93-7254-43e4-8a90-0855ce0406ab'
                                            : owner.imageUrl,
                                        guestImageURL:
                                            'https://firebasestorage.googleapis.com/v0/b/sublet-34e39.appspot.com/o/Empty_profile_pic.jpg?alt=media&token=3d3a8c93-7254-43e4-8a90-0855ce0406ab');
                                    final newMessage = Message(
                                      text: "Hello ${owner.name}",
                                      userType: selfAccount.UserType,
                                    );
                                    String newChatId = FirestoreChats()
                                        .startNewChat(newChat, newMessage);

                                    //Move to chat with owner
                                    // print(owner.toJson());
                                    // print('Redirecting to chat\n');
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ChangeNotifierProvider.value(
                                        value: CurrentChat(
                                            chatId: newChatId,
                                            lastMessage: 'last message'),
                                        child: ChatDetailPage(
                                          name: owner.name,
                                          imageURL: owner.imageUrl == null
                                              ? 'https://firebasestorage.googleapis.com/v0/b/sublet-34e39.appspot.com/o/Empty_profile_pic.jpg?alt=media&token=3d3a8c93-7254-43e4-8a90-0855ce0406ab'
                                              : owner.imageUrl,
                                        ),
                                      );
                                    }));
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
                                                    fontWeight:
                                                        FontWeight.bold))),
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
                  ),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
        //margin: EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey,
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
        ),
      );

  Widget buildIndicator(int length) => AnimatedSmoothIndicator(
        activeIndex: activateIndex,
        count: length,
        effect: SlideEffect(
          activeDotColor: Colors.deepPurple,
          dotHeight: 10,
          dotWidth: 10,
        ),
      );

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
