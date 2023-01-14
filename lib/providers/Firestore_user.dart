import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreUser {
  void updateUserData(String userId, String name, String about) async {
    var userDoc = FirebaseFirestore.instance.collection('users').doc(userId);
    userDoc.update({'name': name, 'about': about});
    DocumentSnapshot<Map<String, dynamic>> userType = await userDoc.get();
    if (userType.data()!['type'].toString() == 'host') {
      await FirebaseFirestore.instance
          .collection('hosts')
          .where('id', isEqualTo: userId)
          .get()
          .then(
        (value) {
          value.docs.first.data()['name'] = name;
        },
      );
    }
  }
}
