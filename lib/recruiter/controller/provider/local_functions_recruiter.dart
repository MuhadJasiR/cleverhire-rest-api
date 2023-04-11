import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class LocalFunctionsRecruiter with ChangeNotifier {
  File? image;
  int index = 0;
  Future imagePickingRecruiter() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      this.image = imageTemp;
      notifyListeners();
    } on PlatformException catch (e) {
      log("failed to pick image $e");
    }
  }

  changingIndex(int value) {
    index = value;
    notifyListeners();
  }
}
