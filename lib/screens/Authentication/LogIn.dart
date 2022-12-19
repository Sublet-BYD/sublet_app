import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    String uname = 'No name';
    String password = 'No password';
    return Form(
      key: _formKey, //Using our unique key
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Username widget
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Username'
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              uname = value;
              return null;
            },
          ),
          //Password widget
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Password'
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              password = value;
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: (){
                OnSubmit(uname, password);
              },
              child: const Text('Log in'),
            ),
          ),
        ],
      ), 
    );
  }
  void OnSubmit(String uname, String password){
    if (_formKey.currentState!.validate()) {//Checking the validity of the form's state
      //Interaction with firebase here
      if(uname == 'No name' || password == 'No password'){
        //Print an error message to the screen
        
      }
      print(uname);
      print(password);
    }
  }
}