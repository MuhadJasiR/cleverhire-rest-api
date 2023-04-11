import 'dart:developer';
import 'dart:io';

import 'package:cleverhire/job_seeker/view/Explore/resume_uploading_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../firebase/storage_services.dart';

class LocalFunctionProvider with ChangeNotifier {
  FirebaseStorageProvider storage = FirebaseStorageProvider();
  File? imageFromGallery;
  File? imageGalleryName;
  int index = 0;
  File? pdfFile;
  File? pdfName;
  bool isLiked = false;
  int likedCount = 0;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image != null) {
        final imageTemp = File(image.path);
        imageFromGallery = imageTemp;
        imageGalleryName = File(image.name);
        notifyListeners();
        // storage
        //     .uploadFilesToFirebase(
        //         imageFromGallery!.path, imageGalleryName.toString(), "Images")
        //     .then((value) => log("image uploaded to firebase"));
      } else {}
    } on PlatformException catch (e) {
      log("failed to pick image: $e");
    }
  }

  Future pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["pdf"],
    );

    if (result != null) {
      pdfFile = File(result.files.single.path!);
      pdfName = File(result.files.single.name);

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResumeUpload(
                index4: 0,
              )));
    } else {
      return null;
    }
  }

  changeIndex(int value) {
    index = value;
    notifyListeners();
  }
}
