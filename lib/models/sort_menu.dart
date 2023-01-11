// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Sort_Menu extends StatefulWidget {
  const Sort_Menu({super.key});

  @override
  State<Sort_Menu> createState() => _Sort_MenuState();
}

class _Sort_MenuState extends State<Sort_Menu> {
  final propStartDateController = TextEditingController(
    text: DateFormat.yMMMd().format(DateTime.now()).toString(),
  );
  final propEndDateController = TextEditingController(
    text: DateFormat.yMMMd().format(DateTime.now()).toString(),
  );
  DateTimeRange range = DateTimeRange(
      start: DateTime.now(),
      end: DateTime(
          2030)); // Will be selected by the user; Defualt values are from today till an arbitrarily long away date.
  String search_res = ''; // Will be inputed by the user; No defualt location.
  bool sort_asc =
      true; // Will be selected by the user; Defualt value means sorting by ascending prices.
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          //Search bar
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Search location...',
                prefixIcon: Icon(Icons.search)),
            keyboardType: TextInputType.emailAddress,
            // validator: (value) {
            //   if (value!.isEmpty) {
            //     return '!';
            //   }
            //   return null;
            // },
            style: TextStyle(
                fontSize: MediaQuery.of(context).textScaleFactor * 15),
            onSaved: (value) {
              // print(_authData);
              search_res =
                  value!; // Hard null check will be safe once list search is implemented (meaning users could only search locations from a given list).
            },
          ),
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
                sort_asc = true;
              } else {
                sort_asc = false;
              }
            },
          ),
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
                  //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2100));
              if (pickedDate != null && pickedDate.isAfter(DateTime.now())) {
                print(
                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate = DateFormat.yMMMd().format(pickedDate);
                print(formattedDate);
                setState(() {
                  propStartDateController.text =
                      formattedDate; //set output date to TextField value.
                });
              } else {
                print('incorrect date\n');
              }
            }),
          ),
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
                  //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2100));
              if (pickedDate != null) {
                print(
                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate = DateFormat.yMMMd().format(pickedDate);
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
        ],
      ),
    );
  }
}
