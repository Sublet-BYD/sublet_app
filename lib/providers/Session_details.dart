import 'package:flutter/material.dart';
import 'package:sublet_app/Firebase_functions.dart';
import 'package:sublet_app/models/Pair.dart';
import 'package:sublet_app/models/data/host_data.dart';
import 'package:sublet_app/models/data/property.dart';

class Session_details with ChangeNotifier {
  // This class contains all information related to the current session. It is a provider, meaning it will be used to "transfer" data between classes.
  String uid = "";
  String utype = "";
  String property_id = "";
  String host_id = "";
  String uname = "";
  Property? _currentProperty = null;

  String get UserId => uid;
  String get UserType => utype;
  String get PropertyId => property_id;
  String get HostId => host_id;
  String get UserName => uname;
  Property? get currentProperty => _currentProperty;

  void UpdateUid(String uid) {
    this.uid = uid;
    notifyListeners();
  }

  void UpdateUtype(String utype) {
    this.utype = utype;
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

  void UpdateProperty(Property newProperty) {
    _currentProperty = newProperty;
  }

  void Logout() {
    host_id = "";
    uid = "";
    utype = "";
    property_id = "";
    uname = "";
  }
}
