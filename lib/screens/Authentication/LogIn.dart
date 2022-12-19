import 'package:flutter/material.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log In page')),
      body: const Center(
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  //creating a unique key to identify our form (every form is required to have one).
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String res = 'No name';
    return Form(
      key: _formKey, //Using our unique key
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              res = value;
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {//Checking the validity of the form's state
                  //Interaction with firebase here
                  print(res);
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}