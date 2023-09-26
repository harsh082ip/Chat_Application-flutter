
import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser{
  String name;
  String email;
  String uid;

  MyUser({required this.name, required this.email, required this.uid});

  // app --> firebase

  Map<String, dynamic> toJson(){
    return {
      'name':name,
      'email':email,
      'uid':uid
    };
  }

  // firebase --> app

 static MyUser fromSnap(DocumentSnapshot snap){
    var snapshot= snap.data() as Map<String, dynamic>;
    return MyUser(name: snapshot['name'], email: snapshot['email'], uid: snapshot['uid']);
  }
}