import 'dart:developer';
import 'dart:io';

import 'package:chat_application/views/screen/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_core/src/get_main.dart';

import '../models/user_pic.dart';

class Upload_Profile_Pic {
  static void uploadProfilePic(
      String imgPath, String nickname, String? name) async {
    final file = File(imgPath);
    String filename = basename(file.path);
    try {
      final Reference storageRef =
          FirebaseStorage.instance.ref().child('Users/Profile_Pic/$filename');
      final UploadTask uploadTask = storageRef.putFile(file);
      String? dwnURL;
      await uploadTask.whenComplete(() async {
        final downloadURL = await storageRef.getDownloadURL();
        dwnURL = downloadURL;
        log('Profile uploaded to: $downloadURL');
      });

      User_Profile_Pic upp = User_Profile_Pic(
          name: name,
          nickName: nickname,
          profile_url: dwnURL.toString(),
          uid: FirebaseAuth.instance.currentUser!.uid);

      await FirebaseFirestore.instance
          .collection('Profile_Pics')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(upp.toJson())
          .then((value) {
        Get.offAll(HomeScreen());
      });
    } catch (e) {
      print('Error uploading pic: $e');
      return null;
    }
  }
}
