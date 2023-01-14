//this class manages all out user logic (sign up ,login, logout ,and also makes sure when the app restarts
// we try login in user again)
//Firebase Auth REST API

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class Auth with ChangeNotifier {
  String _token = ''; // expire at some point of the time
  DateTime? _expiryDate;
  String _userId = '';
  final _auth = FirebaseAuth.instance;

  bool get isAuth {
    // Check if the token is not empty and the expiry date is after the current time
    return _token != '' && (_expiryDate?.isAfter(DateTime.now()) ?? false);
  }

  String get token {
    // Only return the token if the user is authenticated
    return isAuth ? _token : '';
  }

  Future<String> _authentication(
      String email, String password, String UrlSegment) async {
    try {
      var authResult; // Add this line

      if (UrlSegment == 'signUp') {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password); // Change this line

      } else if (UrlSegment == 'signInWithPassword') {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password); // Change this line
      }

      _auth.authStateChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');

          _userId = user.uid;
          _token = user.getIdToken().toString();
        }
      });

      _auth.idTokenChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
          _token = user.getIdToken().toString();

          ;
        }
      });

      _auth.userChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
        }
      });

      _expiryDate = DateTime.now().add(Duration(seconds: 3600));
      notifyListeners();
    } catch (error) {
      throw error;
    }

    print("check null");
    print(_auth.currentUser);
    print("\n\n");
    _userId = _auth.currentUser!.uid;
    print(_userId);
    print("\n\n");
    return _userId;
  }

  Future<String> signup(String email, String password) async {
    return _authentication(email, password, 'signUp');
  }

  Future<String> login(String email, String password) async {
    return _authentication(email, password, 'signInWithPassword');
  }

  void logout() async {
    _token = '';
    _userId = '';
    _expiryDate = null;
    await _auth.signOut();
    notifyListeners();
  }
}
