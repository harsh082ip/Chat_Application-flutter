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

  // fetching Image Url for app drawer
  static Future<String> fetchImageUrl(String uid) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Profile_Pics')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get(); // Use .get() instead of .snapshots()

    final documents = querySnapshot.docs; // Use .docs to access the documents
    final item = documents[0].data() as Map<String, dynamic>;

    String? imgurl;
    imgurl = item['profileUrl'] as String;
    return imgurl;
  }

  // fetching UserName for app drawer
  static Future<String> fetchUserName(String uid) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Profile_Pics')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get(); // Use .get() instead of .snapshots()

    final documents = querySnapshot.docs; // Use .docs to access the documents
    final item = documents[0].data() as Map<String, dynamic>;

    String? username;
    username = item['name'] as String;
    return username;
  }

  // fetching Email for app drawer
  static Future<String> fetchUserEmail(String uid) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get(); // Use .get() instead of .snapshots()

    final documents = querySnapshot.docs; // Use .docs to access the documents
    final item = documents[0].data() as Map<String, dynamic>;

    String? useremail;
    useremail = item['email'] as String;
    return useremail;
  }
}
