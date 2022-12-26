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

  //Owner functions:

  static Future<bool> Upload_owner(Owner_data owner) async {
    bool res = true;
    if (await owner_exists(owner.id)) {
      return false; // User already exists
    }
    db
        .collection('owners')
        .doc(owner.id.toString())
        .set(owner.toJson())
        .onError((error, stackTrace) => {print('$stackTrace\n'), res = false});
    return res;
  }

  static Future<bool> owner_exists(String id) async {
    DocumentSnapshot<Map<String, dynamic>> document =
        await db.collection('owners').doc(id).get();
    return document.exists;
  }

  static Future<Owner_data> get_owner(String owner_id) async {
    DocumentSnapshot<Map<String, dynamic>> document =
        await db.collection('owners').doc(owner_id).get();
    if (!document.exists) {
      print('Owner does not exist, please check your data\n');
      return Owner_data('no name', 'No id');
    }
    Map<String, dynamic> json = document.data() as Map<String, dynamic>;
    // Owner_data owner = Owner_data.fromJson(json['data']); // Using a hard null check because the document must have data, as it exists (we are past that check)
    return Owner_data.fromJson(json);
  }

  static Future<bool> Add_Property(Owner_data owner, String property_id) async {
    bool res = true;
    if (!await property_exists(property_id)) {
      print('Property does not exist.\n');
      return false;
    }
    var owner_document = db.collection('owners').doc(owner.id.toString());
    owner.Add_Property(property_id);
    owner_document.update({'plist': owner.plist}).onError(
        (error, stackTrace) => res = false);
    return res;
  }

  static Future<bool> Remove_Property(
      Owner_data owner, String property_id) async {
    bool res = true;
    var owner_document = db.collection('owners').doc(owner.id.toString());
    owner.Remove_Property(property_id);
    owner_document.update({'plist': owner.plist}).onError(
        (error, stackTrace) => res = false);
    return res;
  }

  //Property functions:

  static Future<bool> Upload_property(Property property) async {
    bool res = true;
    if (!await owner_exists(property.owner_id)) {
      print('Error -> owner doesn\'t exist');
      return false;
    }
    // if(await property_exists(property.id)){
    //   return false; // Property already exists
    // }
    // bool cond = await property_exists(property.id) || property.id == 0;
    // while (cond) {
    //   // Assigning new id numbers to owners
    //   property.assign_id(Random().nextInt(999999));
    //   cond = await property_exists(property.id) || property.id == 0;
    // }
    DocumentReference prop = db.collection('properties').doc();
    property.assign_id(prop.id);
    prop
        .set(property.toJson())
        .onError((error, stackTrace) => {print('$stackTrace\n'), res = false});
    await Add_Property(await get_owner(property.owner_id), property.id!);
    return res;
  }

  static Future<bool> property_exists(String id) async {
    DocumentSnapshot<Map<String, dynamic>> document =
        await db.collection('properties').doc(id.toString()).get();
    return document.exists;
  }

  static Future<Property> get_property(String property_id) async {
    DocumentSnapshot<Map<String, dynamic>> document =
        await db.collection('properties').doc(property_id.toString()).get();
    if (!document.exists) {
      print('property does not exist, please check your data\n');
      return Property(
          id: '0', name: 'No name', location: 'No location', owner_id: 'no id');
    }
    Map<String, dynamic> json = document.data() as Map<String, dynamic>;
    return Property.fromJson(json);
  }

  static Future<bool> Delete_property(String property_id) async {
    if (property_id == 0) {
      return false;
    }
    bool res = true;
    String owner_id = (await get_property(property_id)).owner_id;
    db
        .collection('properties')
        .doc(property_id.toString())
        .delete()
        .onError((error, stackTrace) => res = false);
    if (res) {
      Remove_Property(await get_owner(owner_id), property_id);
    }
    return res;
  }

  static Future<List<Property>> get_avail_properties() async {
    QuerySnapshot<Map<String, dynamic>> query = await db
        .collection('properties')
        .where('occupied', isEqualTo: false)
        .get();
    List<Property> res = [];
    for (var doc in query.docs) {
      res.add(Property.fromJson(doc.data()));
    }
    return res;
  }

  //Users functions:

  static Future<bool> Add_user(String uid, String name, String type) async {
    bool res = true;
    db
        .collection('users')
        .doc(uid)
        .set({'id': uid, 'name': name, 'type': type}).onError(
            (error, stackTrace) => {print('$stackTrace\n'), res = false});
    return res;
  }

  static Future<String> get_user_type(String uid) async {
    var res = await db.collection('users').doc(uid).get();
    return res['type'];
  }
}
