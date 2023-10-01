import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class Upload_ChatImages{

  static Future<String?>  uploadChatImages(String imgpath) async {
    final file = File(imgpath);
    String filename = basename(file.path);
    final Reference storageRef =
          FirebaseStorage.instance.ref().child('Chats/Images/$filename');
      final UploadTask uploadTask = storageRef.putFile(file);
      String? dwnURL;
      await uploadTask.whenComplete(() async {
        final downloadURL = await storageRef.getDownloadURL();
        dwnURL = downloadURL;
        log('Profile uploaded to: $downloadURL');
      });
      return dwnURL;
  }
  
}