import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'Session_details.dart';

class FirestoreProperties with ChangeNotifier {
  // This methods is used to get STREAMS for the StreamBuilder widgets of properties
  // If you implement any StreamBuilder for peoperty UI add methods here:
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
        .where("occupied", isEqualTo: false)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getOccupiedHostProperties(
      var hostId) {
    return FirebaseFirestore.instance
        .collection('properties')
        .where("owner_id", isEqualTo: hostId)
        .where("occupied", isEqualTo: true)
        .snapshots();
  }
}
