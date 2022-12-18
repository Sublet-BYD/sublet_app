import 'package:flutter/material.dart';
import 'package:sublet_app/screens/Authentication/LogIn.dart';

class HomeScreen extends StatefulWidget { //Why is this satateful? should be stateless as it just reroutes clients to other screens
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
          child: ElevatedButton(
            child: const Text(
              'Move to log in',
              style: TextStyle(fontSize: 15.0),
            ),
            onPressed: () {
              _navigateToNextScreen(context);
            },
        ),
      ),
    );
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LogIn()));
  }
}
