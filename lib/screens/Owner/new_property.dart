import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

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

  void _PresentDataPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2022),
    );
  }

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
                  onSubmitted: ((value) {}), // TODO
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Property Location'),
                  controller: propLocationController,
                  onSubmitted: ((value) {}), // TODO
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Property Price'),
                  controller: propPriceController,
                  onSubmitted: ((value) {}), // TODO
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
