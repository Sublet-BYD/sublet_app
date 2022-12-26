//this clas mange all out user logic (sign up ,loggin, loggout ,and also make sure when the app restart
// we try loggin in user again)
//Firebase Auth REST API

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token = ''; // expire at some point of the time
  DateTime? _expiryDate;
  String _userId = '';

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
      final url = Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:$UrlSegment?key=AIzaSyC4LGeN_A0MAJEeJON5Azv5UVCdUoRiAIU');
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      // print("-------------------------");
      // print(response.statusCode);
      // print(json.decode(response.body));
      // print("-------------------------");
      final responseData = json.decode(response.body);
      //check for http error
      if (responseData['error'] != null) {
        //using our exption handler and send the error message from firebase
        // faild validtion
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      print("USERID: ");
      print(_userId);
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
    return _userId;
  }

  Future<String> signup(String email, String password) async {
    return _authentication(email, password, 'signUp');
  }

  Future<String> login(String email, String password) async {
    // print(email);
    // print(password);
    return _authentication(email, password, 'signInWithPassword');
  }

  void logout() {
    _token = '';
    _userId = '';
    _expiryDate = null;
    notifyListeners();
  }
}
