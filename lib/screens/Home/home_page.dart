import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sublet_app/Firebase_functions.dart';
import 'package:sublet_app/main.dart';
import 'package:sublet_app/providers/Session_details.dart';
import 'package:sublet_app/providers/auth.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:sublet_app/models/Exceptions/http_exception.dart';
import 'package:sublet_app/models/data/host_data.dart';
import 'package:toggle_switch/toggle_switch.dart';

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

    //r
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              //allow as to create a gradinat between two colors
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),

          //
          LayoutBuilder(
              builder: (context, constrains) => Container(
                    height: constrains.maxHeight,
                    width: constrains.maxWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          // flex: ,
                          // The SUBLET LOGO
                          child: Container(
                            height: constrains.maxHeight * 0.2,
                            margin: EdgeInsets.only(bottom: 2),
                            padding:
                                //box size
                                EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 92.0),
                            transform: Matrix4.rotationZ(-8 * pi / 180)
                              ..translate(-10.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/Images/1Sublet_logo.png'),
                                scale: 3,
                                filterQuality: FilterQuality.high,
                              ),
                              // borderRadius: BorderRadius.circular(20),
                              // color: Color.fromRGBO(255, 188, 117, 1)
                              //     .withOpacity(0.9),
                              // boxShadow: [
                              //   BoxShadow(
                              //     blurRadius: 8,
                              //     color: Colors.black26,
                              //     offset: Offset(0, 2),
                              //   ),
                              // ],
                            ),
                            // child: Text(
                            //   'Sublet',
                            //   style: TextStyle(
                            //     color: Colors.white,
                            //     fontSize: 46,
                            //     fontFamily: 'Quando',
                            //     // fontWeight: FontWeight.normal,
                            //   ),
                            // ),
                          ),
                        ),
                        Flexible(
                          flex: deviceSize.width > 600 ? 2 : 1,
                          child: AuthCard(),
                        ),
                      ],
                    ),
                  )),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  State<AuthCard> createState() => _AuthCardState();
}

//control the auth mode
// this class has the botton to switch between this modes
class _AuthCardState extends State<AuthCard> {
  //what doing ?
  final GlobalKey<FormState> _formKey = GlobalKey();
  String type = 'client';

  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final _userName = TextEditingController();

  var _isLoading = false;
  final _passwordController = TextEditingController();

//show dialog to the users
  void _showErrorDiallog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                // colse that dialog
                Navigator.of(ctx).pop();
              },
              child: Text('Okay')),
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
    // print('Success!!');

    // set the loading spinner
    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.Login) {
        print('Log in');
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
        Firebase_functions.Add_user(
            context.read<Session_details>().uid, _userName.text, type);
        print("type ${type} ");
        if (type == 'host') {
          Firebase_functions.Upload_owner(
              Owner_data(_userName.text, context.read<Session_details>().uid));
        }
        context.read<Session_details>().UpdateUtype(type);
      }
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
        var _errorMessage = error.toString();
        _showErrorDiallog(_errorMessage);
      });
    }

    //The following code is dead code and redundant

    // check for specific kind of error
    // on HttpException catch (error) {
    //   print("error is : ${error.toString()} ");
    //   var errorMessage = 'Authentication faild';
    //   if (error.toString().contains('EMAIL_EXISTS')) {
    //     errorMessage = 'This email address is already in use.';
    //   } else if (error.toString().contains('INVALID_EMAIL')) {
    //     errorMessage = 'This is not a valid email address.';
    //   } else if (error.toString().contains('WEAK_PASSWORD')) {
    //     errorMessage = 'This password is too weak.';
    //   } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
    //     errorMessage = 'Could not find a user with that email.';
    //   } else if (error.toString().contains('INVALID_PASSWORD')) {
    //     errorMessage = 'Incorrect email or password.';
    //   }
    //   _showErrorDiallog(errorMessage);
    // } catch (error) {
    //   print(error.toString());
    //   const errorMessage =
    //       'Could not authenticate you. Please try again later.';
    //   _showErrorDiallog(errorMessage);
    // }
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
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: LayoutBuilder(
            builder: (ctx, constrains) => Container(
              height: constrains.maxHeight,
              width: constrains.maxWidth,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: constrains.maxHeight * 0.2,
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'E-Mail'),
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
                          // print(_authData);
                        },
                      ),
                    ),
                    if (_authMode == AuthMode.Signup)
                      SizedBox(
                        height: constrains.maxHeight * 0.2,
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Name'),
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).textScaleFactor * 15),
                          controller: _userName,
                        ),
                      ),
                    SizedBox(
                      height: constrains.maxHeight * 0.2,
                      child: TextFormField(
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).textScaleFactor * 15),
                        controller: _passwordController,
                        decoration: InputDecoration(labelText: 'Password'),
                        // make sure input show to the user
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 5) {
                            return 'Password is too short!';
                          }
                        },
                        onSaved: (value) {
                          _authData['password'] = value.toString();
                          print(value);
                        },
                      ),
                    ),
                    if (_authMode == AuthMode.Signup)
                      SizedBox(
                        height: constrains.maxHeight * 0.2,
                        child: TextFormField(
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).textScaleFactor * 15),
                          enabled: _authMode == AuthMode.Signup,
                          decoration:
                              InputDecoration(labelText: 'Confirm Password'),
                          obscureText: true,
                          validator: _authMode == AuthMode.Signup
                              //check the password match
                              ? (value) {
                                  if (value != _passwordController.text) {
                                    print("dbug");
                                    print("value ${value}");
                                    print(_passwordController.text);
                                    return 'Passwords do not match!';
                                  }
                                }
                              : null,
                        ),
                      ),
                    if (_authMode == AuthMode.Signup)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ToggleSwitch(
                          initialLabelIndex: 0,
                          totalSwitches: 2,
                          labels: ['Client', 'Host'],
                          onToggle: (index) {
                            if (index == 0) {
                              type = 'client';
                            } else {
                              type = 'host';
                            }
                          },
                        ),
                      ),
                    SizedBox(
                      height: 15,
                    ),
                    if (_isLoading)
                      CircularProgressIndicator()
                    else
                      ElevatedButton(
                        onPressed: _submit,
                        child: Text(
                            _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 8.0),
                            backgroundColor: Color.fromRGBO(215, 117, 255, 1)
                                .withOpacity(
                                    0.5) //Theme.of(context).primaryColor,
                            ),
                      ),
                    TextButton(
                      onPressed: _switchAuthMode,
                      child: Text(
                          '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                      style: TextButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                        primary: Color.fromRGBO(215, 117, 255, 1),
                      ),
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
