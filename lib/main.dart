import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sublet_app/screens/Home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sublet_app/screens/Owner/Owner_data.dart';
import 'package:sublet_app/screens/Owner/manage_properties.dart';
import 'package:sublet_app/screens/Owner/tabs_screen.dart';
import 'package:sublet_app/screens/Renter/Asset_Page.dart';
import 'package:sublet_app/screens/Renter/Renter_Screen.dart';
import 'package:sublet_app/screens/Owner/property_screen.dart';
import 'package:sublet_app/screens/Renter/renter_tab_screen.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'Firebase_functions.dart';
import './providers/auth.dart';
import './widgets/app_drawer.dart';
import './screens/chat_screen.dart';
import 'screens/Owner/property.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('Attempting to connect to firebase servers\n');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Owner_data first = Owner_data('first name', 'first_id');
  // Property property = Property(
  //     id: 'asdf',
  //     name: 'no name',
  //     location: ' all locations',
  //     owner_id: 'first_id');
  print('Connection to firebase established. Running application\n');
  // Firebase_functions.Upload_owner(first);
  // Firebase_functions.Upload_property(property);
  // Firebase_functions.Delete_property(0);
  // Firebase_functions.get_avail_properties();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static String property_id =
      '0'; // id of a property. since the variable needs to be static to be easily accessible through multiple classes, it is declared in the main class and initialized with a meaningless value (0).
  // This widget is the root of your application.
  static String uid = '';
  static String uType = ''; // By default, the toggle start from client
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
            home: (auth.isAuth)
                ? ((uType == 'host') ?TabsScreen() : Renter_Screen())
                : HomeScreen(),
            // home: const HomeScreen(),
            routes: {
              '/property-screen': ((context) => const PropertyScreen()),
            },
            // home: RenterTabsScreen(),
          ),
        ));
  }
}
