//This file will handle any and all interactions with the firebase firestore database.
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/Owner/Owner_data.dart';
import 'screens/Owner/property.dart';

class Firebase_functions {
  static var db = FirebaseFirestore.instance;

  static Future Upload_owner(Owner_data owner) async {
    bool res = true;
    Future<bool> cond = owner_exists(owner.id);
    while (await cond) { // Assigning new id numbers to owners
      owner.assign_id(Random().nextInt(999999));
      cond = owner_exists(owner.id);
    }
    db
        .collection('owners')
        .doc(owner.id.toString())
        .set({'data': owner.toJson()}).onError(
            (error, stackTrace) => {print('$stackTrace\n'), res = false});
    return res;
  }

  static Future<bool> owner_exists(int id) async {
    DocumentSnapshot<Map<String, dynamic>> document =
        await db.collection('owners').doc(id.toString()).get();
    return document.exists;
  }
  static Future<Owner_data> get_owner(int owner_id)async{
    DocumentSnapshot<Map<String, dynamic>> document =
          await db.collection('owners').doc(owner_id.toString()).get();
    if(!document.exists){
      print('Owner does not exist, please check your data\n');
      return Owner_data('no name');
    }
    print('${document.data() as Map<String, dynamic>}\n');
    Map<String, dynamic> json = document.data() as Map<String, dynamic>;
    Owner_data owner = Owner_data.fromJson(json['data']); // Using a hard null check because the document must have data, as it exists (we are past that check)
    return owner;
  }

}
