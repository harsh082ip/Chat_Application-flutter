import 'package:cloud_firestore/cloud_firestore.dart';

class User_Profile_Pic {
  String nickName;
  String profile_url;
  String uid;

  User_Profile_Pic({
    required this.nickName,
    required this.profile_url,
    required this.uid,
  });

  // app --> firebase

  Map<String, dynamic> toJson() {
    return {
      'nickname': nickName,
      'profileUrl': profile_url,
    };
  }

  // firebase --> app

  static User_Profile_Pic fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User_Profile_Pic(
        nickName: snapshot['nickname'],
        profile_url: snapshot['profileUrl'],
        uid: snapshot['uid']);
  }
}
