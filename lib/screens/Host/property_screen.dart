// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
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

  @override
  Widget build(BuildContext context) {
    var proStream = FirebaseFirestore.instance
        .collection('properties')
        .doc(Provider.of<Session_details>(context).property_id)
        .snapshots();
    late Property property;
    void _startEditProperty(BuildContext context) {
      // The half window for adding new property
      showModalBottomSheet(
        context: context,
        builder: (((context) => EditProperty(property))),
      );
    }

    final appBar = AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.deepPurple,
      elevation: 0,
    );
    void ChangeAvailability(Property _currProperty) {
      Firebase_functions.Edit_Property(
          _currProperty.id!, {'occupied': !_currProperty.occupied!});
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
          stream: proStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                property = Property.fromJson(snapshot.data!.data()!);
                return SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          // height: (MediaQuery.of(context).size.height -
                          //         MediaQuery.of(context).padding.top) *
                          //     0.3,
                          // width: MediaQuery.of(context).size.width,
                          color: Colors.grey,

                          //photo slider
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (property.imageUrls!.isEmpty)
                                Builder(builder: (context) {
                                  return Container(
                                    height: 300,
                                    // width: 200,
                                    child: Image.asset(
                                      'assets/Images/home-placeholder-profile.jpg',
                                      fit: BoxFit.fill,
                                    ),
                                  );
                                }),
                              if (property.imageUrls!.isNotEmpty)
                                CarouselSlider.builder(
                                  options: CarouselOptions(
                                    //
                                    height: 300,
                                    reverse: true,
                                    //viewportFraction: 1, //only one image
                                    //enlargeCenterPage: true,
                                    enableInfiniteScroll:
                                        false, //limt the slider
                                    // onPageChanged: (index, reason) =>
                                    //     setState(() => activateIndex = index),
                                  ),
                                  itemCount: property.imageUrls!.length,
                                  itemBuilder: ((context, index, realIndex) {
                                    final urlImage = property.imageUrls![index];

                                    //return buildImage(urlImage, index);
                                    return InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return Scaffold(
                                                appBar: AppBar(
                                                  title: Text("Full screen"),
                                                ),
                                                body: Hero(
                                                  tag: urlImage,
                                                  child: Image.network(
                                                    urlImage,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: Hero(
                                        tag: urlImage,
                                        child: Image.network(
                                          urlImage,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              //--------- for now I off the dot
                              // const SizedBox(
                              //   height: 5,
                              // ),
                              // if (property.imageUrls!.isNotEmpty)
                              //   buildIndicator(property.imageUrls!.length)
                              // else
                              //   buildIndicator(1)
                            ],
                          ),
                        ),
                        ContentIntro(
                          houseName: property.name,
                          houseAddress: property.location,
                        ),

                        //Occupation status

                        SizedBox(height: 20),
                        About(),

                        SizedBox(height: 25),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: ElevatedButton(
                                onPressed: () {
                                  ChangeAvailability(property);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  primary: Color((property.occupied != null &&
                                          property.occupied!)
                                      ? 0xFFEF5350
                                      : 0xFF8BC34A),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Text(
                                    // textAlign: TextAlign.left,
                                    (property.occupied!)
                                        ? 'Occupied'
                                        : 'Not occupied',
                                    style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ))),

                        SizedBox(height: 25),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: ElevatedButton(
                                onPressed: () => {_startEditProperty(context)},
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  primary: Colors.amber[300],
                                ),
                                child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text('Edit Property',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))))),

                        SizedBox(height: 25),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext ctx) =>
                                          Delete_prop_dialog(
                                              property: property));
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  primary: Colors.red,
                                ),
                                child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text('Delete Property',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))))),
                      ]),
                );
              } else {
                return Center(child: Text('An unexpected error has occurred.'));
              }
            }
          }),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterFloat,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => {_startEditProperty(context)},
      //   child: Icon(Icons.edit),
      // ),
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
      this._property.name,
      this._property.location,
      this._property.description,
      this._property.fromdate,
      this._property.tilldate);
}

class _EditPropertyState extends State<EditProperty> {
  final String name;
  final String location;
  final String? description;
  final DateTime? from, till;
  _EditPropertyState(
      this.name, this.location, this.description, this.from, this.till);
  // final Property _property;
  late final propNameController = TextEditingController(text: name);
  late final propLocationController = TextEditingController(text: location);
  late final propDescController =
      TextEditingController(text: (description != null) ? description : '');
  late final propStartDateController = TextEditingController(
    text: DateFormat.yMMMd()
        .format((from != null) ? from! : DateTime.now())
        .toString(),
  );
  late final propEndDateController = TextEditingController(
    text: DateFormat.yMMMd()
        .format((till != null) ? till! : DateTime.now())
        .toString(),
  );
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
              Text('First available date:'),
              TextField(
                controller: propStartDateController,
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "From" //label text of field
                    ),
                readOnly: true,
                onTap: (() async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2100));
                  if (pickedDate != null &&
                      pickedDate.isAfter(DateTime.now())) {
                    info['fromdate'] = pickedDate.toIso8601String();
                    String formattedDate =
                        DateFormat.yMMMd().format(pickedDate);
                    setState(() {
                      propStartDateController.text = formattedDate;
                    });
                  } else {
                    // print('incorrect date\n');
                    showDialog(
                      context: context,
                      builder: (BuildContext ctx) => AlertDialog(
                        title: Text('Wrong date'),
                        content: Text(
                            'The date you have selected has already passed.'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          )
                        ],
                      ),
                    );
                  }
                }),
              ),
              Text('Last available date:'),
              TextField(
                controller: propEndDateController,
                //editing controller of this TextField
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "To" //label text of field
                    ),
                readOnly: true,
                onTap: (() async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2100));
                  if (pickedDate != null &&
                      pickedDate
                          .isAfter((from != null) ? from! : DateTime.now())) {
                    info['tilldate'] = pickedDate.toIso8601String();
                    String formattedDate =
                        DateFormat.yMMMd().format(pickedDate);
                    setState(
                      () {
                        propEndDateController.text = formattedDate;
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext ctx) => AlertDialog(
                        title: Text('Wrong date'),
                        content: Text(
                            'The date you have selected has already passed or is before the first selected date.'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          )
                        ],
                      ),
                    );
                  }
                }),
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

class ContentIntro extends StatelessWidget {
  final String houseName;
  final String houseAddress;
  const ContentIntro(
      {Key? key, required this.houseName, required this.houseAddress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            houseName,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            houseAddress,
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14),
          ),
          SizedBox(height: 10),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: '\$4455 ',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
            ]),
          )
        ],
      ),
    );
  }
}

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Enum veniam dolor sint ipsum culpa magna dolor incididunt laborum excepteu...',
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14),
          )
        ],
      ),
    );
  }
}
