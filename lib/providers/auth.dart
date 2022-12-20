//this clas mange all out user logic (sign up ,loggin, loggout ,and also make sure when the app restart
// we try loggin in user again)

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token; // expire at some point of the time
  DateTime _expriryDate;
  String _userId;

  Future<void> signup(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[AIzaSyC4LGeN_A0MAJEeJON5Azv5UVCdUoRiAIU]';
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

    print(json.decode(response.body));
  }
}
