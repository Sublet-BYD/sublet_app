//this clas mange all out user logic (sign up ,loggin, loggout ,and also make sure when the app restart
// we try loggin in user again)

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  // String _token; // expire at some point of the time
  // DateTime _expriryDate;
  // String _userId;

  Future<void> _authentication(
      String email, String password, String UrlSegment) async {
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
    print("-------------------------");
    print(response.statusCode);
    print(json.decode(response.body));
    print("-------------------------");
  }

  Future<void> signup(String email, String password) async {
   return _authentication(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
  return  _authentication(email, password, 'signInWithPassword');
  }
}
