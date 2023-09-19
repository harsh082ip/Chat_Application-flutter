import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Profile_Pic {
  static Future<XFile?> pickFile() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      return returnedImage;
    }
  }
}
