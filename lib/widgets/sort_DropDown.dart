import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class sort_DropDown extends StatefulWidget {
  const sort_DropDown({super.key});

  @override
  State<sort_DropDown> createState() => _sort_DropDownState();
}

class _sort_DropDownState extends State<sort_DropDown> {
  final formKey = new GlobalKey<FormState>();
  late String _myActivity;
  late String _myActivityResult;
  @override
  void initState() {
    super.initState();
    _myActivity = '';
    _myActivityResult = '';
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: DropDownFormField(
                  titleText: 'My workout',
                  hintText: 'Please choose one',
                  value: _myActivity,
                  onSaved: (value) {
                    setState(() {
                      _myActivity = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      _myActivity = value;
                    });
                  },
                  dataSource: [
                    ElevatedButton(onPressed:() {
                      print('object');
                    }, child: Text('Hi')),
                    {
                      "display": "Climbing",
                      "value": "Climbing",
                    },
                    {
                      "display": "Walking",
                      "value": "Walking",
                    },
                    {
                      "display": "Swimming",
                      "value": "Swimming",
                    },
                    {
                      "display": "Soccer Practice",
                      "value": "Soccer Practice",
                    },
                    {
                      "display": "Baseball Practice",
                      "value": "Baseball Practice",
                    },
                    {
                      "display": "Football Practice",
                      "value": "Football Practice",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                ),
              ),
              // Container(
              //   padding: EdgeInsets.all(8),
              //   child: ElevatedButton(
              //     child: Text('Save'),
              //     onPressed:() {
              //       print(_myActivityResult);
              //     },
              //   ),
              // ),
              Container(
                padding: EdgeInsets.symmetric(vertical:5),
                child: Text(_myActivityResult),
              )
            ],
          ),
        ),
      ),
    );
  }
}