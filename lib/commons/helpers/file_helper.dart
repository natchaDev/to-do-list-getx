import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class FileHelper {
  Future<File?> pickImageFromCamera() async {
    XFile? camera = await ImagePicker().pickImage(source: ImageSource.camera);
    if (camera == null) return null;
    return File(camera.path);
  }

  String? getImageBase64(File? image) {
    try {
      if (image == null) return null;
      List<int> imageBytes = image.readAsBytesSync();
      return base64Encode(imageBytes);
    } catch (e) {
      return null;
    }
  }
}