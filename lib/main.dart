import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sublet_app/screens/Home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sublet_app/screens/Owner/manage_properties.dart';
import 'package:sublet_app/screens/Owner/tabs_screen.dart';
import 'package:sublet_app/screens/Renter/Asset_Page.dart';
import 'package:sublet_app/screens/Renter/Renter_Screen.dart';
import 'package:sublet_app/screens/Owner/property_screen.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './widgets/app_drawer.dart';

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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
        ],
        //rebuild this part of the tree
        //this ensure whenever that outh object changes
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'Sublet',
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
            ),
            // home: auth.isAuth ? ManageProperties() : HomeScreen(),
            home: const TabsScreen(),
            routes: {
              '/property-screen': ((context) => const PropertyScreen()),
            },
          ),
        ));
  }
}
