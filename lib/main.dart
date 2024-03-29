import 'package:flutter/material.dart';
import 'package:sublet_app/providers/Session_details.dart';
import 'package:sublet_app/providers/firestore_properties.dart';
import 'package:sublet_app/screens/Chat/contact_screen.dart';
import 'package:sublet_app/screens/Home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sublet_app/models/data/host_data.dart';
import 'package:sublet_app/screens/Host/tabs_screen.dart';
import 'package:sublet_app/screens/Host/property_screen.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import './providers/auth.dart';
// import 'package:dcdg/dcdg.dart';

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

  choosePage(String type, String id) {
    print("------------ userId on main!!!! ${id}");
    if (type == 'host' || type == 'client') {
      return TabsScreen(
        userType: type,
        userId: id,
      );
    } else {
      print("emptyy");
      return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProvider.value(
            value: Session_details(),
          ),
          ChangeNotifierProvider(
              create: ((context) =>
                  FirestoreProperties())) // Defining Session_details as a provider for the app.
        ],
        //rebuild this part of the tree
        //this ensure whenever that outh object changes
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => Consumer<Session_details>(
            builder: (ctx, session, _) => MaterialApp(
              title: 'Sublet',
              theme: ThemeData(
                primarySwatch: Colors.deepPurple,
                accentColor: Colors.deepOrange,
                fontFamily: 'Lato',
              ),
              debugShowCheckedModeBanner: false,
              home: (auth.isAuth)
                  ? choosePage(session.utype, session.UserId)
                  : HomeScreen(),
              // home: ContactScreen(
              //     chatUsersStream:
              //         FirestoreProperties().getAvailableHostProperties("1")),

              // home: const HomeScreen(),
              routes: {
                '/property-screen': ((context) => const PropertyScreen()),
              },

              // home: RenterTabsScreen(),
            ),
          ),
        ));
  }
}
