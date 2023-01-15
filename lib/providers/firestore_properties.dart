import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FirestoreProperties with ChangeNotifier {
  // This methods is used to get STREAMS for the StreamBuilder widgets of properties
  // If you implement any StreamBuilder for peoperty UI add methods here:
  Stream<QuerySnapshot<Map<String, dynamic>>> getRecentHostProperties(
      String hostId) {
    return FirebaseFirestore.instance
        .collection('properties')
        .where("owner_id", isEqualTo: hostId)
        .orderBy('dateAdded')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAvailableHostProperties(
      String hostId) {
    return FirebaseFirestore.instance
        .collection('properties')
        .where("owner_id", isEqualTo: hostId)
        .where("occupied", isEqualTo: false)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getOccupiedHostProperties(
      String hostId) {
    return FirebaseFirestore.instance
        .collection('properties')
        .where("owner_id", isEqualTo: hostId)
        .where("occupied", isEqualTo: true)
        .snapshots();
  }

  Future<List<String>> getAllLocations() async {
    List<String> output = ['any location'];
    FirebaseFirestore.instance.collection('properties').get().then((value) {
      if (value != null) {
        value.docChanges.forEach((element) {
          if (!output.contains(element)) {
            output.add(element.doc['location']);
          }
        });
      }
    });
    return output;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSortedProperties(
      Map<String, Object> requirements) {
    bool price_asc = requirements['price'] as bool;
    DateTime from = requirements['from'] as DateTime;
    DateTime till;
    String location;
    var output;
    if (requirements.containsKey('till')) {
      till = requirements['till'] as DateTime;
    } else {
      till = DateTime(
          3000); // Arbitrarily far away time; The user has not chosen an end date.
    }
    if (requirements.containsKey('location') &&
        requirements['location'] != 'any location') {
      // Return only properties from chosen location
      return FirebaseFirestore.instance
          .collection('properties')
          .where('location', isEqualTo: requirements['location'] as String)
          .where('occupied', isEqualTo: false)
          .where('fromdate', isGreaterThanOrEqualTo: from.toIso8601String())
          .snapshots();
    }
    return FirebaseFirestore.instance
        .collection('properties')
        .where('occupied', isEqualTo: false)
        .where('fromdate', isGreaterThanOrEqualTo: from.toIso8601String())
        .snapshots();
  }
}
