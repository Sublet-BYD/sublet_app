import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:json_annotation/json_annotation.dart';
import 'package:sublet_app/screens/Owner/property.dart';
import 'package:intl/intl.dart';
part 'Owner_data.g.dart';

// @JsonSerializable(explicitToJson: true)
class Owner_data {
  late final int id; // late keyword added in order to initialize the variable later but keep it final
  late final String name;
  late final List<int>? plist;
  late final int joined_at; // Year of registration
  // late final ImageProvider? profile_pic; // Images will be kept in a seperate collection 

  Owner_data(this.name, { this.plist = const [], int? id, int? joined_at}){ // commented out: this.profile_pic = const AssetImage('assets/Empty_profile_pic.jpg'),
    this.id = (id != null)? id :  Random().nextInt(99999); //Flutter has no int.maxvalue function. Because of course it doesn't.
    this.joined_at = (joined_at != null) ? joined_at : int.parse(DateFormat('yyyy').format(DateTime.now()));
  }
  void Add_Property(int new_property){
    plist!.add(new_property);
  }
  void Remove_Property(Property old_property){
    if(plist!.contains(old_property)){
      plist!.remove(old_property);
      //Update firestore
    }
    else{
      print('property not in list');
    }
  }
  //Function that transfers the object's data into a format that fits firestore's conditions
  Map<String, dynamic> Prepare_upload_to_firestore(){
     return {
      if(id != null) "id" : id,
      if(name != null) "name" : name,
      if(plist != null) "plist": plist,
      if(joined_at != null || joined_at <= 0) "joined_at" : joined_at,
      // if(profile_pic != null) "profile_pic" : profile_pic,
    };
  }
  factory Owner_data.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, // Factory is used here to return a single instance of the class for each owner
  SnapshotOptions? options){
    final data = snapshot.data();
    return Owner_data(data?['name'],id: data?['id'] ,plist: data?['plist'] is Iterable ? List.from(data?['plist']) : null, joined_at: data?['joined_at']); // Commented out: , profile_pic: data?['profile_pic']
  }
  //Obsolete to/from json functions:

  // Map<String,dynamic> toJson(){
  //   Map<String, dynamic> plist_json = {};
  //   print('object\n');
  //   for(var uid in plist!){
  //     print('object\n');
  //     plist_json[uid.toString()] = uid.toString();
  //     print('$plist_json\n');
  //   }
  //   return{'id': id, 'name': name, 'plist': plist_json, 'joined_at': joined_at};
  // }

  // Owner_data.fromJson(Map<String, dynamic> json){
  //   id = json['id'];
  //   name = json['name'];
  //   plist = json['plist'];
  //   joined_at = json['joined_at'];
  // }

  factory Owner_data.fromJson(Map<String, dynamic> json) => _$Owner_dataFromJson(json);

  Map<String, dynamic> toJson() => _$Owner_dataToJson(this);

}