import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// Add the Firestore library
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sublet_app/Firebase_functions.dart';
import 'package:sublet_app/widgets/image_widgets/image_input.dart';
import '../../models/data/property.dart';
import 'package:provider/provider.dart';
import 'package:sublet_app/providers/Session_details.dart';
import 'dart:io';

class NewProperty extends StatefulWidget {
  final Function refresh;
  const NewProperty({required this.refresh, super.key});

  @override
  State<NewProperty> createState() => _NewPropertyState();
}

class _NewPropertyState extends State<NewProperty> {
  final propNameController = TextEditingController();
  final propLocationController = TextEditingController();
  final propPriceController = TextEditingController();
  final propStatusController = TextEditingController();
  final propStartDateController = TextEditingController(
    text: DateFormat.yMMMd().format(DateTime.now()).toString(),
  );
  final propEndDateController = TextEditingController(
    text: DateFormat.yMMMd().format(DateTime.now()).toString(),
  );
  var appBar = AppBar(
    title: Text('Add a new Property'),
  );

  File? _pickedImaged;
  void _selectImage(File pickedImage) {
    _pickedImaged = pickedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ImageInput(_selectImage),
              TextField(
                decoration: InputDecoration(labelText: 'Property Name'),
                controller: propNameController,
                onSubmitted: ((value) {
                  FocusScope.of(context).unfocus();
                  final user = FirebaseAuth.instance.currentUser;
                }), // TODO
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Property Location'),
                controller: propLocationController,
                onSubmitted: ((value) {
                  FocusScope.of(context).unfocus();
                  final user = FirebaseAuth.instance.currentUser;
                }), // TODO
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Property Price'),
                controller: propPriceController,
                onSubmitted: ((value) {
                  FocusScope.of(context).unfocus();
                  final user = FirebaseAuth.instance.currentUser;
                }), // TODO
              ),
              Container(
                padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                // height: MediaQuery.of(context).size.width / 3,
                child: Center(
                  child: TextField(
                    controller: propStartDateController,
                    //editing controller of this TextField
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
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100));
                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat.yMMMd().format(pickedDate);
                        print(formattedDate);
                        setState(() {
                          propStartDateController.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {}
                    }),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                // height: MediaQuery.of(context).size.width / 3,
                child: Center(
                  child: TextField(
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
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100));
                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat.yMMMd().format(pickedDate);
                        print(formattedDate);
                        setState(
                          () {
                            propEndDateController.text =
                                formattedDate; //set output date to TextField value.
                          },
                        );
                      } else {}
                    }),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  //  _addNewProperty();
                  if (_pickedImaged == null) {
                    print("is in");
                    Property pro = Property(
                      name: propNameController.text,
                      location: propLocationController.text,
                      owner_id:
                          Provider.of<Session_details>(context, listen: false)
                              .UserId
                              .toString(),
                      fromdate: DateTime.tryParse(propStartDateController.text),
                      tilldate: DateTime.tryParse(propEndDateController.text),
                      price: int.parse(propPriceController.text),
                    );
                    Firebase_functions.Upload_property(pro).then(
                      (value) {
                        if (value) {
                          print("-----------------------");
                          print(value);
                          // Property was uploaded successfully
                          // Now you can use the updated property in the PropertyScreen
                          Navigator.pop(context);
                          widget.refresh();
                        }
                      },
                    );
                  } else {
                    print("is out");
                    Property pro = Property(
                      name: propNameController.text,
                      location: propLocationController.text,
                      owner_id:
                          Provider.of<Session_details>(context, listen: false)
                              .UserId
                              .toString(),
                      fromdate: DateTime.tryParse(propStartDateController.text),
                      tilldate: DateTime.tryParse(propEndDateController.text),
                      price: int.parse(propPriceController.text),
                      image: _pickedImaged,
                    );
                    Firebase_functions.Upload_property(pro).then(
                      (value) {
                        if (value) {
                          // Property was uploaded successfully
                          // Now you can use the updated property in the PropertyScreen
                          Navigator.pop(context);
                          widget.refresh();
                        }
                      },
                    );
                  }
                },
                icon: Icon(Icons.add),
                label: Text('Add Place'),
                style: ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
