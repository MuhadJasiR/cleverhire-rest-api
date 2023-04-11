import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FirebaseStorageProvider with ChangeNotifier {
  String? downloadUrl;

  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future uploadFilesToFirebase(
      String filePath, String fileName, String folderName) async {
    File file = File(filePath);
    try {
      firebase_storage.UploadTask uploadTask =
          storage.ref().child("$folderName/$fileName").putFile(file);
      downloadUrl = await (await uploadTask).ref.getDownloadURL();
      notifyListeners();

      log("resume link : $downloadUrl");
    } catch (e) {
      log(e.toString());
    }
  }

  Future deleteFileFromFirebase(String fileUrl) async {
    await FirebaseStorage.instance.refFromURL(fileUrl).delete();
    log("file deleted");
  }
}
