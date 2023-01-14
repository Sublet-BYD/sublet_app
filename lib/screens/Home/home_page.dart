// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sublet_app/Firebase_functions.dart';
import 'package:sublet_app/main.dart';
import 'package:sublet_app/providers/Session_details.dart';
import 'package:sublet_app/providers/auth.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:sublet_app/models/Exceptions/http_exception.dart';
import 'package:sublet_app/models/data/host_data.dart';
import 'package:sublet_app/screens/Home/auth_card.dart';
import 'package:toggle_switch/toggle_switch.dart';

enum AuthMode { Signup, Login }

class HomeScreen extends StatefulWidget {
  //Why is this satateful? should be stateless as it just reroutes clients to other screens
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              //allow as to create a gradinat between two colors
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0, 1],
              ),
            ),
          ),

          //
          LayoutBuilder(
            builder: (context, constrains) => SizedBox(
              height: constrains.maxHeight,
              width: constrains.maxWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    // flex: ,
                    // The SUBLET LOGO
                    child: Container(
                      height: constrains.maxHeight * 0.2,
                      margin: EdgeInsets.only(bottom: 2),
                      padding:
                          //box size
                          EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 92.0),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-10.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/Images/1Sublet_logo.png'),
                          scale: 3,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
