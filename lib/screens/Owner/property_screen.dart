import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sublet_app/screens/Owner/property.dart';

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

    final appBar = AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      resizeToAvoidBottomInset: false,
      body: Column(children: <Widget>[
        Container(
          height: (MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top) *
              0.3,
          width: MediaQuery.of(context).size.width,
          child: Image.asset('assets/Apartment_example.jpg', fit: BoxFit.cover),
        ),
        Container(
          // Name of Property
          height: (MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top) *
              0.4,
          // width: MediaQuery.of(context).size.width,
          child: LayoutBuilder(builder: (context, constrains) {
            return Column(children: [
              Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                // padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                alignment: Alignment
                    .topLeft, // require for the title to begin from left
                height: constrains.maxHeight * 0.2,
                // width: double.infinity,
                child: FittedBox(
                  child: Text(
                    // textAlign: TextAlign.left,
                    _property.name,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: constrains.maxHeight * 0.2,
                      fontWeight: FontWeight.bold,
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
                height: constrains.maxHeight * 0.2,
                // width: double.infinity,
                child: Row(
                  children: [
                    Icon(Icons.location_on_outlined),
                    SizedBox(
                      width: 5,
                    ),
                    FittedBox(
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
                  ],
                ),
              )
            ]);
          }),
        ),
      ]),
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
