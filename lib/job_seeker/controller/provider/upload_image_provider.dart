import 'dart:developer';

import 'package:cleverhire/job_seeker/controller/apiServices/upload_image_services.dart';
import 'package:cleverhire/job_seeker/controller/firebase/storage_services.dart';
import 'package:cleverhire/job_seeker/controller/provider/local_functions_provider.dart';
import 'package:cleverhire/job_seeker/model/upload_image_model.dart';
import 'package:cleverhire/job_seeker/view/home/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadImageProvider with ChangeNotifier {
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  Future uploadImageProviderFunction(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final providerFirebase =
        Provider.of<FirebaseStorageProvider>(context, listen: false);
    final providerLocalFunction =
        Provider.of<LocalFunctionProvider>(context, listen: false);
    await providerFirebase.uploadFilesToFirebase(
        providerLocalFunction.imageFromGallery!.path,
        providerLocalFunction.imageGalleryName!.path,
        "postImages");

    final description = descriptionController.text.trim();

    if (providerFirebase.downloadUrl != null) {
      isLoading = true;
      notifyListeners();
      final uploadImageModel = UploadImageModel(
          description: description, image: providerFirebase.downloadUrl!);
      log("your download Url is ${providerFirebase.downloadUrl}");

      UploadImageApiServices().uploadImageServices(uploadImageModel);
      isLoading = false;
      notifyListeners();
      // ignore: use_build_context_synchronously
    } else {
      isLoading = false;
      notifyListeners();
      log("Error : your download url is null");
    }
  }

  disposeTextField(context) {
    descriptionController.clear();
    final provider = Provider.of<LocalFunctionProvider>(context, listen: false);
    provider.imageFromGallery = null;
  }
}
