import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Fetch_Info {
  // fetching snapshots of Profile_Pics collection
  static Stream<QuerySnapshot> profilePicStream() {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return FirebaseFirestore.instance.collection('Profile_Pics').snapshots();
    } else {
      return Stream.empty();
    }
  }
}
