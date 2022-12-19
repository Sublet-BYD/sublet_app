import 'package:flutter/material.dart';

class Renter_Screen extends StatefulWidget {
  const Renter_Screen({super.key});

  @override
  State<Renter_Screen> createState() => _Renter_ScreenState();
}

class _Renter_ScreenState extends State<Renter_Screen> {
  String uname = 'No name';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $uname'),
      ),
    );
  }
}