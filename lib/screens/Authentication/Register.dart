import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final title = 'Register';

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordVerifyController = TextEditingController();
  final authType = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(30),
            child: Text(
              title,
              style: TextStyle(fontSize: 28),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            height: 300,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'user@email.com'),
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  controller: nameController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  controller: passwordController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Verify Password'),
                  controller: passwordVerifyController,
                ),
                // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
                ToggleSwitch(
                  initialLabelIndex: 0,
                  totalSwitches: 2,
                  labels: ['Client', 'Host'],
                  onToggle: (index) {
                    print('switched to: $index');
                  },
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.end,
            ),
          ),
        ],
      ),
    );
  }
}
