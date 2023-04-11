import 'dart:developer';

import 'package:cleverhire/job_seeker/controller/apiServices/uploading_resume_services.dart';
import 'package:cleverhire/job_seeker/controller/provider/local_functions_provider.dart';
import 'package:cleverhire/job_seeker/model/applying_for_vacancy_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../firebase/storage_services.dart';

class ApplyingForVacancyProvider with ChangeNotifier {
  bool isLoading = false;
  Future applyingForVacancy(BuildContext context, String jobId) async {
    final provider =
        Provider.of<FirebaseStorageProvider>(context, listen: false);
    final provider2 =
        Provider.of<LocalFunctionProvider>(context, listen: false);
    await provider.uploadFilesToFirebase(
        provider2.pdfFile!.path, provider2.pdfFile!.path, "Resumes");

    if (provider.downloadUrl != null) {
      isLoading = true;
      final applyingVacancyModel =
          ApplyingForVacancyModel(resume: provider.downloadUrl!);
      notifyListeners();
      log("This is your resume : ${provider.downloadUrl}");
      ApplyingForVacancy()
          .applyingForVacancyServices(applyingVacancyModel, jobId);
    } else {
      log("Error: downloadUrl is null");
    }
  }
}
