//This file will handle any and all interactions with the firebase firestore database.

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'models/data/host_data.dart';
import 'models/data/property.dart';
import './models/data/host_data.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

class Firebase_functions {
  static var db = FirebaseFirestore.instance;

  //Owner functions:

  static Future<bool> Upload_owner(Owner_data owner) async {
    bool res = true;
    if (await owner_exists(owner.id)) {
      return false; // User already exists
    }
    db
        .collection('hosts')
        .doc(owner.id.toString())
        .set(owner.toJson())
        .onError((error, stackTrace) => {print('$stackTrace\n'), res = false});
    return res;
  }

  static Future<bool> owner_exists(String id) async {
    DocumentSnapshot<Map<String, dynamic>> document =
        await db.collection('hosts').doc(id).get();
    return document.exists;
  }

  static Future<Owner_data> get_owner(String owner_id) async {
    // print(owner_id);
    DocumentSnapshot<Map<String, dynamic>> document =
        await db.collection('hosts').doc(owner_id).get();
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
    var owner_document = db.collection('hosts').doc(owner.id.toString());
    owner.Add_Property(property_id);
    owner_document.update({'plist': owner.plist}).onError(
        (error, stackTrace) => res = false);

    return res;
  }

  static Future<bool> Remove_Property(
      Owner_data owner, String property_id) async {
    bool res = true;
    var owner_document = db.collection('hosts').doc(owner.id.toString());
    owner.Remove_Property(property_id);
    owner_document.update({'plist': owner.plist}).onError(
        (error, stackTrace) => res = false);
    return res;
  }

  static Future<bool> Update_host_image(Owner_data owner, var image) async {
    bool res = true;
    final ref = FirebaseStorage.instance.ref().child("${owner.id}.jpg");
    final task = ref.putFile(image);
    final url = await ref.getDownloadURL();
    owner.Update_Image(image, url);
    var owner_document = db.collection('hosts').doc(owner.id.toString());
    owner_document.update({'imageUrl': owner.imageUrl}).onError(
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
    print('Owner exists\n');
    if (property.id != null && await property_exists(property.id!)) {
      print('Error -> Property already exists\n');
      return false;
    }
    DocumentReference prop = db.collection('properties').doc();
    property.assign_id(prop.id);
    print('Assigned id\n');
    if (property.imageUrls == null) {
      property.imageUrls = [];
    }
    if (property.images != null) {
      //print("\n------------------\n is outtt");
      //ref gives us access to our route cloud storage bucket
      //child allows to control where we want to store\read our file
      // Create a reference to the storage bucket
      for (int i = 0; i < property.images!.length; i = i + 1) {
        //print("\n------------------\n is innn");
        //print(property.images!.length);
        if (property.images![i] != null) {
          final storageRef = FirebaseStorage.instance.ref();
          Reference ref =
              storageRef.child("${DateTime.now().microsecondsSinceEpoch}.jpg");

          print('Uploaded image\n');
          //upload the file
          final metaData = SettableMetadata(contentType: 'image/jpeg');
          try {
            await ref.putFile(property.images![i], metaData);
            String url = await ref.getDownloadURL();
            FirebaseAuth auth = FirebaseAuth.instance;

            property.imageUrls!.add(url);
            print(auth.currentUser);
          } catch (e) {
            print(e);
          }
        }
      }
      property.images = null;
      print(property.imageUrls);
    }
    prop
        .set(property.toJson())
        .onError((error, stackTrace) => {print('$stackTrace\n'), res = false});

    //prop.update({'dateAdded': Timestamp.fromDate(DateTime.now())});
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

  static Future<bool> Edit_Property(
      String property_id, Map<String, Object> updates) async {
    bool res = true;
    if (!await property_exists(property_id)) {
      return false;
    }
    var property_document = db.collection('properties').doc(property_id);
    updates.forEach((key, value) {
      property_document
          .update({key: value}).onError((error, stackTrace) => res = false);
    });
    return res;
  }

  static Future<bool> Delete_property(String property_id) async {
    if (!await property_exists(property_id)) {
      return false;
    }
    bool res = true;
    Property prop = await get_property(property_id);
    String owner_id = (await get_property(property_id)).owner_id;
    db
        .collection('properties')
        .doc(property_id.toString())
        .delete()
        .onError((error, stackTrace) => res = false);
    if (res) {
      if (prop.imageUrls != null) {
        for (var url in prop.imageUrls!) {
          FirebaseStorage.instance.refFromURL(url).delete();
        }
      }
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

  static Future<List<Property>> get_properties_of_owner(String owner_id) async {
    Owner_data owner = await get_owner(owner_id);
    List<Property> res = [];
    if (owner.plist == null) {
      return res;
    }
    for (String pid in owner.plist!) {
      // Hard null check is safe as we confirmed owner.plist is not null
      res.add(await get_property(pid));
    }
    return res;
  }

  //Users functions:

  static Future<bool> Add_user(
      String uid, String name, String type, imageURL, String about) async {
    bool res = true;
    db.collection('users').doc(uid).set({
      'id': uid,
      'name': name,
      'type': type,
      'imageURL': imageURL,
      'about': about
    }).onError((error, stackTrace) => {print('$stackTrace\n'), res = false});
    return res;
  }

  static Future<String> get_user_type(String uid) async {
    var res = await db.collection('users').doc(uid).get();
    return res['type'];
  }
}
