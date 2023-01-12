//this class manages all out user logic (sign up ,login, logout ,and also makes sure when the app restarts
// we try login in user again)
//Firebase Auth REST API

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sublet_app/providers/Session_details.dart';
import '../models/Exceptions/http_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth with ChangeNotifier {
  String _token = ''; // expire at some point of the time
  DateTime? _expiryDate;
  String _userId = '';
  final _auth = FirebaseAuth.instance;
// //if we have a token and the token didnt expire then then user is authenticated
  // bool get isAuth {
  //   return token != '';
  // }

  // String get token {
  //   // if it's null we cants  have a vaild token
  //   if (_expiryDate != null &&
  //       _expiryDate.isAfter(DateTime.now()) &&
  //       _token != '') {
  //     return _token;
  //   }
  //   return '';
  // }

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
          //Provider.of<Session_details>(context).UpdateUid(user.uid);

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
  // Future<String> _authentication(
  //     String email, String password, String UrlSegment) async {
  //   try {
  //     final url = Uri.parse(
  //         'https://identitytoolkit.googleapis.com/v1/accounts:$UrlSegment?key=AIzaSyC4LGeN_A0MAJEeJON5Azv5UVCdUoRiAIU');

  //     final response = await http.post(
  //       url,
  //       body: json.encode(
  //         {
  //           'email': email,
  //           'password': password,
  //           'returnSecureToken': true,
  //         },
  //       ),
  //     );
  //     // print("-------------------------");
  //     // print(response.statusCode);
  //     // print(json.decode(response.body));
  //     // print("-------------------------");
  //     final responseData = json.decode(response.body);
  //     //check for http error
  //     if (responseData['error'] != null) {
  //       //using our exption handler and send the error message from firebase
  //       // faild validtion
  //       throw HttpException(responseData['error']['message']);
  //     }
  //     _token = responseData['idToken'];
  //     _userId = responseData['localId'];

  //     _expiryDate = DateTime.now().add(
  //       Duration(
  //         seconds: int.parse(
  //           responseData['expiresIn'],
  //         ),
  //       ),
  //     );
  //     notifyListeners();
  //   } catch (error) {
  //     throw error;
  //   }
  //   return _userId;
  // }

  Future<String> signup(String email, String password) async {
    return _authentication(email, password, 'signUp');
  }

  // void Utype(String type) {
  //   print("from auttht");
  //   print(type);
  //   MyApp.uType = type;
  //   notifyListeners();
  // }

  Future<String> login(String email, String password) async {
    // print(email);
    // print(password);
    return _authentication(email, password, 'signInWithPassword');
  }

  void logout() async {
    _token = '';
    _userId = '';
    _expiryDate = null;
    await _auth.signOut();
    notifyListeners();
    // print(_userId);
  }
}
