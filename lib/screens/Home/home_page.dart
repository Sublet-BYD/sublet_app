import 'package:flutter/material.dart';
import 'package:sublet_app/screens/Authentication/LogIn.dart';
import 'package:sublet_app/screens/Authentication/Register.dart';

class HomeScreen extends StatefulWidget {
  //Why is this satateful? should be stateless as it just reroutes clients to other screens
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        // child: Text('Home Page'),
        child: Column(
          children: [
            ElevatedButton(
              child: const Text(
                'Log in',
                style: TextStyle(fontSize: 15.0),
              ),
              onPressed: () {
                _navigateToNextScreen(context, 1);
              },
            ),
            ElevatedButton(
                onPressed: () {
                  _navigateToNextScreen(context, 2);
                },
                child: const Text("Sign up", style: TextStyle(fontSize: 15.0))),
          ],
        ),
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context, int tag) {
    if (tag == 1) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LogIn()));
    } else if (tag == 2) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Register()));
    }
  }
}
