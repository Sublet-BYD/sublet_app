//This file will handle any and all interactions with the firebase firestore database.
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
    // final owner_ref = db
    //     .collection('owners')
    //     .withConverter(
    //         fromFirestore: Owner_data.fromFirestore,
    //         toFirestore: (Owner_data owner, options) =>
    //             owner.Prepare_upload_to_firestore())
    //     .doc('${owner.id}');
    // await owner_ref
    //     .set(owner)
    //     .onError((error, stackTrace) => {print('$stackTrace\n'), res = false});
    // print('result of firestore upload: $res');
    db.collection('owners').doc('first_upload').set({'data': owner.toJson()}).onError((error, stackTrace) => {print('$stackTrace\n'), res = false});;
    return res;
  }

// bool get_owner(Owner_data owner){

// }

}
