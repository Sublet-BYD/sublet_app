import 'package:flutter/material.dart';

class Session_details with ChangeNotifier{ // This class contains all information related to the current session. It is a provider, meaning it will be used to "transfer" data between classes.
  String uid = "";
  String utype = "";
  String property_id = "";
  String host_id = "";
  String uname = "";

  String get UserId => uid;
  String get UserType => utype;
  String get PropertyId => property_id;
  String get HostId => host_id;
  String get UserName => uname;

  void UpdateUid(String uid){
    this.uid = uid;
    notifyListeners();
  }
  void UpdateUtype(String utype){
    this.utype = utype;
    notifyListeners();
  }
  void UpdatePropertyId(String property_id){
    this.property_id = property_id;
    notifyListeners();
  }
  void UpdateHostId(String host_id){
    this.host_id = host_id;
    notifyListeners();
  }
  void UpdateName(String uname){
    this.uname = uname;
  }
  void Logout(){
    host_id = "";
    uid = "";
    utype = "";
    property_id = "";
    uname = "";
  }
}