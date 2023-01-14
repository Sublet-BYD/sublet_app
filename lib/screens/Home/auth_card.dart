import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../Firebase_functions.dart';
import '../../models/data/host_data.dart';
import '../../providers/Session_details.dart';
import '../../providers/auth.dart';
import 'home_page.dart';
import 'package:flutter/material.dart';

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  State<AuthCard> createState() => _AuthCardState();
}

// control the auth mode
// this class has the botton to switch between this modes
class _AuthCardState extends State<AuthCard> {
  //what doing ?
  final GlobalKey<FormState> _formKey = GlobalKey();
  String imageURL =
      'https://firebasestorage.googleapis.com/v0/b/sublet-34e39.appspot.com/o/Empty_profile_pic.jpg?alt=media&token=3d3a8c93-7254-43e4-8a90-0855ce0406ab';
  String type = 'client';
  final _emailController = TextEditingController();
  final _userName = TextEditingController();

  AuthMode _authMode = AuthMode.Login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  var _isLoading = false;
  final _passwordController = TextEditingController(text: 'admin1');

//show dialog to the users
  void _showErrorDiallog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                // colse that dialog
                Navigator.of(ctx).pop();
              },
              child: const Text('Okay')),
        ],
      ),
    );
  }

  Future<void> _submit() async {
//close the soft keyboard which might still be open as soon we submit
    FocusScope.of(context).unfocus();

    // validtion faild
    if (!_formKey.currentState!.validate()) {
      //Invalid!
      print('NOT VALID');
      return;
    }

    //valtion succeeced
    //save all input
    _formKey.currentState!.save();

    // set the loading spinner
    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.Login) {
        // print('Log in');
        // Log user in
        context.read<Session_details>().UpdateUtype(
            await Provider.of<Auth>(context, listen: false).login(
                _authData['email'].toString(),
                _authData['password'].toString()));
        context.read<Session_details>().UpdateUid(
            await Provider.of<Auth>(context, listen: false).login(
                _authData['email'].toString(),
                _authData['password'].toString()));
        if (context.read<Session_details>().uid != '') {
          FirebaseFirestore.instance
              .collection('users')
              .doc(context.read<Session_details>().uid)
              .get()
              .then((doc) async {
            if (doc.exists) {
              // Document data is available
              print("--------------------------");

              String utype = doc.data()!['type'];
              print(utype);
              // To write a value
              context.read<Session_details>().UpdateUtype(utype);
              // MyApp.uType = doc.data()!['type'];
            } else {
              // Document is not found
              print(" this no such ");
              print("No such document!");
            }
            print("HERE");
            print(context.read<Session_details>().utype);
          });
        }
      } else {
        // Sign user up
        context.read<Session_details>().UpdateUid(
            await Provider.of<Auth>(context, listen: false).signup(
                _authData['email'].toString(),
                _authData['password']
                    .toString())); // Signing the new user up and keeping the unique id assigned to them by firebase
        // print("--------------------\n${context.read<Session_details>().uid}, ${_userName.text}, ${type}");
        Firebase_functions.Add_user(context.read<Session_details>().uid,
            _userName.text, type, imageURL);
        print("type ${type} ");
        if (type == 'host') {
          Firebase_functions.Upload_owner(
              Owner_data(_userName.text, context.read<Session_details>().uid));
        }
        context.read<Session_details>().UpdateUtype(type);
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
        var errorMessage = error.toString();
        _showErrorDiallog(errorMessage);
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  //switch from login to sign up
  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 500 : 260,
        //defend on the mode, sign up ask for extra
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 500 : 260),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: LayoutBuilder(
            builder: (ctx, constrains) => SizedBox(
              height: constrains.maxHeight,
              width: constrains.maxWidth,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: constrains.maxHeight * 0.2,
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'E-Mail'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Invalid email!';
                          }
                          return null;
                        },
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).textScaleFactor * 15),
                        onSaved: (value) {
                          _authData['email'] = value.toString();
                        },
                        controller: _emailController,
                      ),
                    ),
                    // Enter full name field for Sign Up
                    if (_authMode == AuthMode.Signup)
                      SizedBox(
                        height: constrains.maxHeight * 0.2,
                        child: TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Full Name'),
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).textScaleFactor * 15),
                          controller: _userName,
                        ),
                      ),
                    // TextField For Password
                    SizedBox(
                      height: constrains.maxHeight * 0.2,
                      child: TextFormField(
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).textScaleFactor * 15),
                        controller: _passwordController,
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        // make sure input show to the user
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 5) {
                            return 'Password is too short!';
                          }
                        },
                        onSaved: (value) {
                          _authData['password'] = value.toString();
                        },
                      ),
                    ),
                    // TextField of Confirm Password only for Sign Up
                    if (_authMode == AuthMode.Signup)
                      SizedBox(
                        height: constrains.maxHeight * 0.2,
                        child: TextFormField(
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).textScaleFactor * 15),
                          enabled: _authMode == AuthMode.Signup,
                          decoration: const InputDecoration(
                              labelText: 'Confirm Password'),
                          obscureText: true,
                          validator: _authMode == AuthMode.Signup
                              //check the password match
                              ? (value) {
                                  if (value != _passwordController.text) {
                                    return 'Passwords do not match!';
                                  }
                                }
                              : null,
                        ),
                      ),
                    if (_authMode ==
                        AuthMode
                            .Signup) // Toggle between host and client only for Sign Up state.
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ToggleSwitch(
                          initialLabelIndex: 0,
                          totalSwitches: 2,
                          labels: const ['Client', 'Host'],
                          onToggle: (index) {
                            if (index == 0) {
                              type = 'client';
                            } else {
                              type = 'host';
                            }
                          },
                        ),
                      ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (_isLoading)
                      const CircularProgressIndicator()
                    else
                      ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 8.0),
                            backgroundColor:
                                const Color.fromRGBO(215, 117, 255, 1)
                                    .withOpacity(
                                        0.5) //Theme.of(context).primaryColor,
                            ),
                        child: Text(
                            _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                      ),
                    TextButton(
                      onPressed: _switchAuthMode,
                      style: TextButton.styleFrom(
                        foregroundColor: const Color.fromRGBO(215, 117, 255, 1),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 4),
                      ),
                      child: Text(
                          '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
