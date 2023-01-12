// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:sublet_app/Firebase_functions.dart';
import 'package:sublet_app/models/data/property.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sublet_app/providers/Session_details.dart';
import 'package:sublet_app/widgets/host_widgets/Delete_prop_dialog.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PropertyScreen extends StatefulWidget {
  const PropertyScreen({super.key});

  @override
  State<PropertyScreen> createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {
  int activateIndex = 0;
  void _startEditProperty(BuildContext context, Property prop) {
    // The half window for adding new property
    showModalBottomSheet(
      context: context,
      builder: (((context) => EditProperty(prop))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Property? _currProperty =
        Provider.of<Session_details>(context).currentProperty;
    // final _propertyJson =
    //     ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    // final _property = Property.fromJson(_propertyJson);
    int available_color =
        (_currProperty!.occupied != null && _currProperty.occupied!)
            ? 0xFFEF5350
            : 0xFF8BC34A; // Light green for unoccupied, light red for occupied
    final appBar = AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
    );
    void ChangeAvailability() {
      Firebase_functions.Edit_Property(
          _currProperty.id!, {'occupied': !_currProperty.occupied!});
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
          stream: null,
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(children: <Widget>[
                Container(
                  height: (MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  width: MediaQuery.of(context).size.width,

                  //photo slider
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                        itemCount: _currProperty.imageUrls!.length,
                        itemBuilder: ((context, index, realIndex) {
                          print("\n\n");
                          print("--------------");
                          if (_currProperty.imageUrls!.isEmpty) {
                            return Image.asset(
                              'assets/Images/home-placeholder-profile.jpg',
                              fit: BoxFit.fill,
                            );
                          }

                          print(_currProperty.imageUrls!.length);
                          final urlImage = _currProperty.imageUrls![index];
                          for (int i = 0;
                              i < _currProperty.imageUrls!.length;
                              i++) {
                            print(_currProperty.imageUrls![i]);
                          }
                          print("\n\n");
                          return buildImage(urlImage, index);
                        }),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      if (_currProperty.imageUrls!.isNotEmpty)
                        buildIndicator(_currProperty.imageUrls!.length)
                      else
                        buildIndicator(1)
                    ],
                  ),

                  //  Image.asset('assets/Apartment_example.jpg',
                  //     fit: BoxFit
                  //         .cover), // (_property.image != null)? _property.image as Widget :
                ),
                Column(
                  children: [
                    Container(
                      // TITLE
                      margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                      // padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                      alignment: Alignment
                          .topLeft, // require for the title to begin from left
                      // height: constrains.maxHeight * 0.2,
                      // width: double.infinity,
                      child: FittedBox(
                        child: Text(
                          // textAlign: TextAlign.left,
                          _currProperty.name,
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            // fontSize: constrains.maxHeight * 0.2,
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      //Location TextBox
                      margin: EdgeInsets.only(top: 10, left: 15),
                      // padding: EdgeInsets.only(left: 15),
                      alignment: Alignment
                          .topLeft, // require for the title to begin from left
                      // height: constrains.maxHeight * 0.2,
                      // width: double.infinity,
                      child: Row(
                        children: [
                          Icon(Icons.location_on_outlined),
                          SizedBox(
                            width: 5,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: SizedBox(
                              // LOCATION
                              height: 20,
                              child: FittedBox(
                                child: Text(
                                  // textAlign: TextAlign.left,
                                  _currProperty.location,
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Chats with renters
                    GestureDetector(
                      onTap: () {
                        // VERY IMPORTANT: Move user to the apropriate chats page (screen with all chats about this property).

                        //Move to chat page for this property
                        print('Moving to chats page\n');
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.amber[600],
                          border: Border.all(
                              color: (Colors.amber[800]!),
                              width:
                                  3), //Exclamation mark added to assure null safety
                        ),
                        // margin: EdgeInsets.only(top: 5),
                        alignment: Alignment
                            .topLeft, // require for the title to begin from left
                        // height: constrains.maxHeight * 0.2,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.only(top: 13),
                                child: Icon(Icons.message),
                                margin: EdgeInsets.only(left: 15)),
                            SizedBox(
                              width: 5,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                textAlign: TextAlign.center,
                                // textAlign: TextAlign.left,
                                'Contact your renters',
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //Occupation status
                    GestureDetector(
                      onTap: () => ChangeAvailability(),
                      child: Container(
                        color: Color(available_color),
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        alignment: Alignment
                            .topLeft, // require for the title to begin from left
                        // height: constrains.maxHeight * 0.2,
                        child: Center(
                          child: FittedBox(
                            child: Text(
                              // textAlign: TextAlign.left,
                              (_currProperty.occupied!)
                                  ? 'Occupied. Tap to change status'
                                  : 'Not occupied. Tap to change status',
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //Remove this property -> will be fully implemented in the future
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext ctx) =>
                                Delete_prop_dialog(property: _currProperty));
                      },
                      child: Container(
                        color: Colors.red[800],
                        margin: EdgeInsets.only(top: 10),
                        // height: constrains.maxHeight * 0.2,
                        child: ListTile(
                          leading: Icon(Icons.delete),
                          title: Text('Delete this property',
                              style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            );
          }),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {_startEditProperty(context, _currProperty)},
        child: Icon(Icons.edit),
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
}

class EditProperty extends StatefulWidget {
  final Property _property;

  EditProperty(this._property);

  @override
  State<EditProperty> createState() => _EditPropertyState(
      this._property.name, this._property.location, this._property.description);
}

class _EditPropertyState extends State<EditProperty> {
  final String name;
  final String location;
  final String? description;
  _EditPropertyState(this.name, this.location, this.description);
  // final Property _property;
  late final propNameController = TextEditingController(text: name);
  late final propLocationController = TextEditingController(text: location);
  late final propDescController =
      TextEditingController(text: (description != null) ? description : '');
  Map<String, String> info = Map();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Property Name'),
                controller: propNameController,
                onSubmitted: (value) {
                  print('\n$value\n');
                  if (value.isNotEmpty && value != name) {
                    info['name'] = value;
                  }
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Property Location'),
                controller: propLocationController,
                onSubmitted: (value) {
                  if (value.isNotEmpty && value != location) {
                    info['location'] = value;
                  }
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Property Description'),
                controller: propDescController,
                onSubmitted: (value) {
                  if (value.isNotEmpty && value != description) {
                    info['description'] = value;
                  }
                },
              ),
              TextButton(
                onPressed: () {
                  print(info);
                  info.forEach((key, value) {
                    print('$key : $value\n');
                  });
                  Firebase_functions.Edit_Property(widget._property.id!, info);
                  setState(() {});
                  Navigator.pop(context);
                },
                child: Text('Update'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.purple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
