import 'package:cloud_firestore/cloud_firestore.dart';

class User_Profile_Pic {
  String? name;
  String nickName;
  String profile_url;
  String uid;

  User_Profile_Pic({
    required this.profile_url,
    required this.uid,
    required this.name,
    required this.nickName,
  });

  // app --> firebase

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'nickname': nickName,
      'profileUrl': profile_url,
      'uid': uid,
    };
  }
}
