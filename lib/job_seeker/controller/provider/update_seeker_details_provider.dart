import 'package:flutter/cupertino.dart';

class UpdateSeekerDetailsProvider with ChangeNotifier {
  // Future<void> updateSeekerDetailsProvider(context) async {
  //   final seekerLogin =
  //       Provider.of<SeekerLoginProvider>(context, listen: false);

  //   final dateTime = seekerLogin.selectedDate;
  //   final address = seekerLogin.addressController.text;
  //   final occupation = seekerLogin.occupationController.text;

  //   final providerFirebase =
  //       Provider.of<FirebaseStorageProvider>(context, listen: false);
  //   final provider2 =
  //       Provider.of<LocalFunctionProvider>(context, listen: false);
  //   await providerFirebase.uploadFilesToFirebase(
  //       provider2.imageFromGallery!.path,
  //       provider2.imageGalleryName!.path,
  //       "Images");

  //   if (providerFirebase.downloadUrl != null) {
  //     final updatedSeekerModel = SeekerReqModel(
  //         dateOfBirth: dateTime!,
  //         address: address,
  //         occupation: occupation,
  //         profileImage: providerFirebase.downloadUrl!);

  //     UpdateSeekerDetailsApiServices().updateSeekerLogin(updatedSeekerModel);
  //   } else {
  //     log("Error : your download url is null");
  //   }
  // }
}
