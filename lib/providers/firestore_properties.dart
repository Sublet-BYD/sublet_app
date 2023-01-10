import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'Session_details.dart';

class FirestoreProperties with ChangeNotifier {
  // final String _userID;
  Stream<QuerySnapshot<Map<String, dynamic>>> properties = FirebaseFirestore
      .instance
      .collection('properties')
      .where("owner_id", isEqualTo: '')
      .snapshots();

  // FirestoreProperties() {
  //   // properties = FirebaseFirestore.instance
  //   //     .collection('properties')
  //   //     .where("owner_id", isEqualTo: _userID)
  //   //     .snapshots();
  // }

  Stream<QuerySnapshot<Map<String, dynamic>>> getRecentHostProperties(
      var hostId) {
    return FirebaseFirestore.instance
        .collection('properties')
        .where("owner_id", isEqualTo: hostId)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAvailableHostProperties(
      var hostId) {
    return FirebaseFirestore.instance
        .collection('properties')
        .where("owner_id", isEqualTo: hostId)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getOccupiedHostProperties(
      var hostId) {
    return FirebaseFirestore.instance
        .collection('properties')
        .where("owner_id", isEqualTo: hostId)
        .snapshots();
  }
}
