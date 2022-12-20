import 'package:flutter/material.dart';
import 'package:sublet_app/screens/Authentication/LogIn.dart';
import 'package:sublet_app/screens/Authentication/Register.dart';

enum AuthMode { Signup, Login }

class HomeScreen extends StatefulWidget {
  //Why is this satateful? should be stateless as it just reroutes clients to other screens
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //creating a unique key to identify our form (every form is required to have one).
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String uname = 'No name';
    String password = 'No password';

    return Scaffold(
      appBar: AppBar(title: Text('Sublet')),
      body: Center(
          child: Column(
        children: <Widget>[
          //Username widget
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: "Username"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty!';
              }
              uname = value;
              return null;
            },
          ),

          //Password widget
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(labelText: 'Password'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty!';
              }
              password = value;
              return null;
            },
          ),

          Text(
              'Creating an account means you\'r okey with our Terms of Service and our Privacy Policy'),

          ElevatedButton(
              onPressed: () {
                _navigateToNextScreen(context, 1);
              },
              child: const Text('Sign in')),

          Text('Don\'t have an accont? '),

          ElevatedButton(
              onPressed: () {
                _navigateToNextScreen(context, 2);
              },
              child: const Text('Sign up')),
        ],
      )),
    );
  }

//     return Scaffold(
//       appBar: AppBar(title: Text('Sublet')),
//       body: Center(
//         // child: Text('Home Page'),
//         child: Column(
//           children: [
//             ElevatedButton(
//               child: const Text(
//                 'Move to log in',
//                 style: TextStyle(fontSize: 15.0),
//               ),
//               onPressed: () {
//                 _navigateToNextScreen(context, 1);
//               },
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   _navigateToNextScreen(context, 2);
//                 },
//                 child: const Text("Sign up", style: TextStyle(fontSize: 15.0))),
//           ],
//         ),
//       ),
//     );
//   }

  void _navigateToNextScreen(BuildContext context, int tag) {
    if (tag == 1) {
      Null;
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => LogIn()));
    } else if (tag == 2) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Register()));
    }
  }
}
