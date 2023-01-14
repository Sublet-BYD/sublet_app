import 'package:flutter/material.dart';
import 'package:sublet_app/Firebase_functions.dart';
import 'package:sublet_app/models/Pair.dart';
import 'package:sublet_app/models/data/host_data.dart';
import 'package:sublet_app/models/data/property.dart';
import 'Firestore_user.dart';

class Session_details with ChangeNotifier {
  // This class contains all information related to the current session. It is a provider, meaning it will be used to "transfer" data between classes.
  String uid = "";
  String utype = "";
  String property_id = "";
  String host_id = "";
  String uname = "";
  String imgURL = "";
  String userEmail = 'example@example.com';
  String userAbout = '';
  // String userAbout = '';
  Map<String, Object> sort_reqs = {
    'price': true,
    'from': DateTime.now(),
    'location': 'any location'
  }; // Requirements for sorting the properties in Guest_Feed; Defualt sort will only be by ascending prices.

  String get UserId => uid;
  String get UserType => utype;
  String get PropertyId => property_id;
  String get HostId => host_id;
  String get UserName => uname;
  String get ImgURL => imgURL;
  String get UserEmail => userEmail;
  String get UserAbout => userAbout;

  Map<String, Object> get SortReqs => sort_reqs;

  void UpdateUid(String uid) {
    this.uid = uid;
    notifyListeners();
  }

  void UpdateUtype(String utype) {
    this.utype = utype;
    notifyListeners();
  }

  void UpdateUserImage(String userImg) {
    imgURL = userImg;
    notifyListeners();
  }

  void UpdatePropertyId(String property_id) {
    this.property_id = property_id;
    notifyListeners();
  }

  void UpdateHostId(String host_id) {
    this.host_id = host_id;
    notifyListeners();
  }

  void UpdateName(String uname) {
    this.uname = uname;
    notifyListeners();
  }

  void UpdateAbout(String about) {
    this.userAbout = about;
    notifyListeners();
  }

  void UpdateUserData(String name, String about) {
    this.uname = name;
    this.userAbout = about;
    FirestoreUser().updateUserData(UserId, name, about);
    notifyListeners();
  }

  void UpdateRequirements(Map<String, Object> sort_reqs) {
    this.sort_reqs = sort_reqs;
    notifyListeners();
  }

  Future<Property> GetProperty() async {
    return Firebase_functions.get_property(property_id);
  }

  Future<Owner_data> GetHost() async {
    return Firebase_functions.get_owner(host_id);
  }

  Future<Pair<Property, Owner_data>> GetProp_Host() async {
    return Pair(await GetProperty(), await GetHost());
  }

  void Logout() {
    host_id = "";
    uid = "";
    utype = "";
    property_id = "";
    uname = "";
    imgURL = "";
    sort_reqs = {
      'price': true,
      'from': DateTime.now(),
      'location': 'any location'
    };
  }
}
