import 'package:flutter/material.dart';
import 'package:sublet_app/providers/auth.dart';
import 'package:sublet_app/screens/Authentication/LogIn.dart';
import 'package:sublet_app/screens/Authentication/Register.dart';
import 'dart:math';
import 'package:provider/provider.dart';

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
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      padding:
                          //box size
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:
                            Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        'Sublet',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontFamily: 'Anton',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
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

  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  var _isLoading = false;
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    // validtion faild
    if (!_formKey.currentState!.validate()) {
      //Invalid!
      print('NOT VALID');
      return;
    }
    //valtion succeeced
    //save all input
    _formKey.currentState!.save();
    print('SECCED!!');

    // set the loading spinner
    setState(() {
      _isLoading = true;
    });
    if (_authMode == AuthMode.Login) {
      // Log user in
       await Provider.of<Auth>(context, listen: false).login(
          _authData['email'].toString(), _authData['password'].toString());
    } else {
      // Sign user up
      await Provider.of<Auth>(context, listen: false).signup(
          _authData['email'].toString(), _authData['password'].toString());
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
        height: _authMode == AuthMode.Signup ? 320 : 260,
        //defend on the mode, sign up ask for extra
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value.toString();
                    // print(_authData);
                  },
                ),
                TextFormField(
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
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
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
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _submit,
                    child:
                        Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 8.0),
                        backgroundColor: Color.fromRGBO(215, 117, 255, 1)
                            .withOpacity(0.5) //Theme.of(context).primaryColor,
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
    );
  }
}

//old
//   Scaffold(
//     appBar: AppBar(title: Text('Sublet')),
//     body: Center(
//         child: Column(
//       children: <Widget>[
//         //Username widget
//         TextFormField(
//           keyboardType: TextInputType.emailAddress,
//           decoration: const InputDecoration(labelText: "Username or E-mail"),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'This field cannot be empty!';
//             }
//             uname = value;
//             return null;
//           },
//         ),

//         //Password widget
//         TextFormField(
//           keyboardType: TextInputType.visiblePassword,
//           decoration: const InputDecoration(labelText: 'Password'),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'This field cannot be empty!';
//             }
//             password = value;
//             return null;
//           },
//         ),

//         Text(
//             'Creating an account means you\'r okey with our Terms of Service and our Privacy Policy'),

//         ElevatedButton(
//             onPressed: () {
//               _navigateToNextScreen(context, 1);
//             },
//             child: const Text('Sign in')),

//         Text('Don\'t have an accont? '),

//         ElevatedButton(
//             onPressed: () {
//               _navigateToNextScreen(context, 2);
//             },
//             child: const Text('Sign up')),
//       ],
//     )),
//   );
//}

//   void _navigateToNextScreen(BuildContext context, int tag) {
//     if (tag == 1) {
//       Null;
//       // this suold navgitate to acount home page

//       // Navigator.of(context)
//       //     .push(MaterialPageRoute(builder: (context) => LogIn()));
//     } else if (tag == 2) {
//       Navigator.of(context)
//           .push(MaterialPageRoute(builder: (context) => Register()));
//     }
//   }
// }
