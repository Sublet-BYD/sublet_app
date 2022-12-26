import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Add the Firestore library
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sublet_app/Firebase_functions.dart';
import 'package:sublet_app/main.dart';
import 'package:sublet_app/screens/Owner/properties_list_categories.dart';
import './property.dart';

class NewProperty extends StatefulWidget {
  const NewProperty({super.key});

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

  // void _PresentDataPicker() {
  //   showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2022),
  //     lastDate: DateTime(2022),
  //   );
  // }

  // Get a reference to the Firestore database

  // final _db = FirebaseFirestore.instance;

  // Future<DocumentSnapshot> getOwnerDocument(String id) async {
  //   DocumentSnapshot doc = await _db.collection('owners').doc(id).get();
  //   if (doc.exists) {
  //     // Document data is available
  //     return doc;
  //   } else {
  //     // Document is not found, return an error
  //     return Future.error('Document not found');
  //   }
  // }

  // void _addNewProperty() async {
  //   // Add the new property to the 'properties' collection
  //   DocumentReference newPropertyRef = await _db.collection('properties').add({
  //     'name': propNameController.text,
  //     'location': propLocationController.text,
  //     'price': propPriceController.text,
  //     'startDate': propStartDateController.text,
  //     'endDate': propEndDateController.text,
  //     'status': propStatusController.text
  //   });

  // // Get the ID of the new property
  // String newPropertyId = newPropertyRef.id;

  // // Get the current user ID from Firebase Authentication
  // final currentUserId = FirebaseAuth.instance.currentUser;
  // print(MyApp.uid);

  // // Update the owner's plist field with the new property ID
  // await _db.collection('owners').doc(MyApp.uid).update({
  //   'plist': FieldValue.arrayUnion([newPropertyId])
  // });

  //   setState(() {});

  //   print('was add');
  // }

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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                TextButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      final user = FirebaseAuth.instance.currentUser;
                      Navigator.pop(context);
                      //  _addNewProperty();
                      Property pro = new Property(
                        name: propNameController.text,
                        location: propLocationController.text,
                        owner_id: MyApp.uid,
                        fromdate:
                            DateTime.tryParse(propStartDateController.text),
                        tilldate: DateTime.tryParse(propEndDateController.text),
                        price: int.parse(propPriceController.text),
                      );

                      Firebase_functions.Upload_property(pro);
                      // PropertiesListCategories.setState()
                      setState(() {
                        
                      });
                    },
                    child: Text("Add"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
