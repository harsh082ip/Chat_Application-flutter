import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Fetch_Info {
  // fetching snapshots of Profile_Pics collection
  static Stream<QuerySnapshot> profilePicStream() {
    String user = FirebaseAuth.instance.currentUser!.uid;
    if (user != null) {
      return FirebaseFirestore.instance
          .collection('Profile_Pics')
          .where('uid', isNotEqualTo: user)
          .snapshots();
    } else {
      return Stream.empty();
    }
  }

  // fetching chats snaps
  static Stream<QuerySnapshot> fetchChats(String uid1) {
    return FirebaseFirestore.instance
        .collection('chats')
        .where('participants', arrayContains: uid1)
        .snapshots();
  }
}
