import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sublet_app/screens/Owner/property.dart';
import 'package:intl/intl.dart';
part 'Owner_data.g.dart';

@JsonSerializable(explicitToJson: true)
class Owner_data {
  late int id; // late keyword added in order to initialize the variable later
  late final String name;
  late final List<int>? plist;
  late final int joined_at; // Year of registration
  // late final ImageProvider? profile_pic; // Images will be kept in a seperate collection 

  Owner_data(this.name, { this.plist = const [], int? id, int? joined_at}){
    this.id = (id != null)? id : Random().nextInt(999999); //Flutter has no int.maxvalue function. Because of course it doesn't.
    this.joined_at = (joined_at != null) ? joined_at : int.parse(DateFormat('yyyy').format(DateTime.now()));
  }
  void Add_Property(int new_property){ // This function should only be called via Firebase_functions.Add_Property (IMPORTANT)
    plist!.add(new_property);
  }
  void Remove_Property(int old_property){ // This function should only be called via Firebase_functions.Remove_Property (IMPORTANT)
    if(plist!.contains(old_property)){
      plist!.remove(old_property);   
    }
    else{
      print('property not in list');
    }
  }
  void assign_id(int id){ // This function will be called by Firebase_functions when uploading a new owner to the database.
    this.id = id;
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

  factory Owner_data.fromJson(Map<String, dynamic> json){
   return _$Owner_dataFromJson(json);
  }
  Map<String, dynamic> toJson() => _$Owner_dataToJson(this);

}