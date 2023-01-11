import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sublet_app/models/data/property.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PropertyScreen extends StatelessWidget {
  const PropertyScreen({super.key});

  void _startEditProperty(BuildContext context, Property prop) {
    // The half window for adding new property
    showModalBottomSheet(
      context: context,
      builder: (((context) => EditProperty(prop))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _property = ModalRoute.of(context)?.settings.arguments as Property;
    int available_color = (_property.occupied != null && _property.occupied!)
        ? 0xFFEF5350
        : 0xFF8BC34A; // Light green for unoccupied, light red for occupied
    final appBar = AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            height: (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top) *
                0.3,
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider.builder(
              options: CarouselOptions(autoPlay: true),
              itemCount: _property.imageUrls!.length,
              itemBuilder: ((context, index, realIndex) => 
              final urlImage= [index]) ,


        
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
                    _property.name,
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
                            _property.location,
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
              Container(
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
                      (_property.occupied!)
                          ? 'This Property is now occupied'
                          : 'This property is not occupied',
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
              //Empty container as a placeholder
              SizedBox(
                  // margin: EdgeInsets.only(top: 10),
                  // height: constrains.maxHeight * 0.2,
                  ),
              //Remove this property -> will be fully implemented in the future
              GestureDetector(
                onTap: () {
                  //Implement pop up warning window here
                  print((_property.occupied!)
                      ? 'You cannot delete this property, as it is currently occupied.'
                      : 'Are you sure you want to delete this property?\n');
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
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {_startEditProperty(context, _property)},
        child: Icon(Icons.edit),
      ),
    );
  }
}

class EditProperty extends StatefulWidget {
  final Property _property;

  EditProperty(this._property);

  @override
  State<EditProperty> createState() =>
      _EditPropertyState(this._property.name, this._property.location);
}

class _EditPropertyState extends State<EditProperty> {
  final String name;
  final String location;
  _EditPropertyState(this.name, this.location);
  // final Property _property;
  late final propNameController = TextEditingController(text: name);
  late final propLocationController = TextEditingController(text: location);

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
                onSubmitted: ((value) {}), // TODO
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Property Location'),
                controller: propLocationController,
                onSubmitted: ((value) {}), // TODO
              ),
              TextButton(
                onPressed: () => {},
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
