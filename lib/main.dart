import 'package:flutter/material.dart';
import 'package:sublet_app/screens/Home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sublet_app/screens/Owner/manage_properties.dart';
import 'package:sublet_app/screens/Owner/property_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('Attempting to connect to firebase servers\n');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Connection to firebase established. Running application\n');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ManageProperties(),
    );
  }
}
