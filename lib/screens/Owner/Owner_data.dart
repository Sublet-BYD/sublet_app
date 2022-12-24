import 'package:flutter/material.dart';
import 'package:sublet_app/screens/Owner/property.dart';
import 'package:intl/intl.dart';

class Owner_data {
  late final UniqueKey id; // late keyword added in order to initialize the variable later but keep it final
  late final String name;
  late final List<UniqueKey>? plist;
  late final int joined_at; // Year of registration
  late final ImageProvider? profile_pic;

  Owner_data(this.name, {this.profile_pic = const AssetImage('assets/Empty_profile_pic.jpg'),  UniqueKey? property}){
    id = UniqueKey();
    if(property != null){
      plist = [property];
    }
    else{
      plist = [];
    }
    joined_at = int.parse(DateFormat('yyyy').format(DateTime.now()));
  }
  void Add_Property(UniqueKey new_property){
    plist!.add(new_property);
  }
  void Remove_Property(Property old_property){
    plist!.remove(old_property.id);
  }


}