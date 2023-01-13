// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sublet_app/providers/Session_details.dart';
import 'package:sublet_app/providers/firestore_properties.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class Sort_Menu extends StatefulWidget {
  const Sort_Menu({super.key});

  @override
  State<Sort_Menu> createState() => _Sort_MenuState();
}

class _Sort_MenuState extends State<Sort_Menu> {
  Map<String, Object> sort_reqs = {'price' : true, 'from' : DateTime.now()}; // Defualt values
  late Future<List<String>> suggestions =
      Provider.of<FirestoreProperties>(context).getAllLocations();
  final propStartDateController = TextEditingController(
    text: DateFormat.yMMMd().format(DateTime.now()).toString(),
  );
  final propEndDateController = TextEditingController(
    text: DateFormat.yMMMd().format(DateTime.now()).toString(),
  );
  final locationController = TextEditingController(
    text: '',
  );
  DateTime from =
      DateTime.now(); // Will be selected by the user; Defualt value is now.
  late DateTime till; // Will be selected by the user; No defualt value.
  late String search_res; // Will be inputed by the user; No defualt location.
  bool sort_asc =
      true; // Will be selected by the user; Defualt value means sorting by ascending prices.
  @override
  Widget build(BuildContext context) {
    void printlist() async{
      print(await suggestions);
    }
    return FutureBuilder(
        future: suggestions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              return Column(
                children: [
                  //Search bar
                  TypeAheadField(
                      animationStart: 0,
                      animationDuration: Duration.zero,
                      suggestionsCallback: ((pattern) {
                        List<String> relevant_suggestions = [];
                        relevant_suggestions.addAll(snapshot.data!);
                        relevant_suggestions.retainWhere((element) {
                          return element
                              .toLowerCase()
                              .contains(pattern.toLowerCase());
                        });
                        return relevant_suggestions;
                      }),
                      itemBuilder: (context, sone) {
                        return Card(
                            child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(sone.toString()),
                        ));
                      },
                      textFieldConfiguration: TextFieldConfiguration(
                        decoration: InputDecoration(
                            labelText: 'Search location...',
                            prefixIcon: Icon(Icons.search)),
                            controller: locationController,
                      ),
                      onSuggestionSelected: ((suggestion) {
                        locationController.text = suggestion;
                        sort_reqs['location'] = suggestion;
                      })),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //       labelText: 'Search location...',
                  //       prefixIcon: Icon(Icons.search)),
                  //   // validator: (value) {
                  //   //   if (value!.isEmpty) {
                  //   //     return '!';
                  //   //   }
                  //   //   return null;
                  //   // },
                  //   style: TextStyle(
                  //       fontSize: MediaQuery.of(context).textScaleFactor * 15),
                  //   onSaved: (value) {
                  //     // print(_authData);
                  //     search_res =
                  //         value!; // Hard null check will be safe once list search is implemented (meaning users could only search locations from a given list).
                  //   },
                  // ),
                  //Sort by price:
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Sort by:',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  ToggleSwitch(
                    minWidth: 200,
                    initialLabelIndex: 0,
                    totalSwitches: 2,
                    labels: ['Price ascending', 'Price descending'],
                    onToggle: (index) {
                      if (index == 0) {
                        sort_reqs['price'] = true;
                      } else {
                        sort_reqs['price'] = false;
                      }
                    },
                  ),
                  // First date (from):
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
                        String formattedDate =
                            DateFormat.yMMMd().format(pickedDate);
                        sort_reqs['from'] = pickedDate;
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
                  // Second date (till):
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
                      if (pickedDate != null && pickedDate.isAfter(from)) {
                        till = pickedDate;
                        String formattedDate =
                            DateFormat.yMMMd().format(pickedDate);
                            sort_reqs['till'] = pickedDate;
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
                  ElevatedButton(
                      onPressed: (() {
                        Provider.of<Session_details>(context, listen: false).UpdateRequirements(sort_reqs);
                        Navigator.pop(context);
                      }),
                      child: Text('Confirm')),
                ],
              );
            }
            else{
              printlist();
              return Text('ERROR');
            }
          }
        });
  }
}
