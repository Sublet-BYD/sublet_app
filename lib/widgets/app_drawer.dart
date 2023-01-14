import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sublet_app/main.dart';
import 'package:sublet_app/providers/Session_details.dart';
import 'package:sublet_app/screens/Home/home_page.dart';
import 'package:sublet_app/screens/User/profile_page.dart';

import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.account_box),
            title: const Text('My Account'),
            onTap: () {
              // Navigate to Profile page screen.
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ));
              // Navigator.of(context)
              //     .pushReplacement(MaterialPageRoute(builder: ((context) => HomeScreen())));
              // Provider.of<Auth>(context, listen: false).logout();
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              context
                  .read<Session_details>()
                  .Logout(); // Resetting all session_details
              Navigator.of(context).pop();
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
