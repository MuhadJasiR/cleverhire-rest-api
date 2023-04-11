import 'dart:developer';

import 'package:cleverhire/job_seeker/controller/apiServices/get_applied_jobs_services.dart';
import 'package:cleverhire/job_seeker/model/get_applied_jobs_model.dart';
import 'package:cleverhire/recruiter/controller/provider/get_created_vacancy_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetAppliedJobsProvider with ChangeNotifier {
  bool alreadyApplied = false;
  List<GetAppliedJobsModel>? appliedJobs;
  bool isLoading = false;
  Future<void> fetchingAppliedJobs() async {
    isLoading = true;
    notifyListeners();
    final appliedJobsApiServices = GetAppliedJobsApiServices();
    await appliedJobsApiServices.getAppliedJobsServices().then((value) {
      appliedJobs = value;
      notifyListeners();
      isLoading = false;
      notifyListeners();
    });
    isLoading = false;
    notifyListeners();
    log(appliedJobs.toString());
  }

  checkingAppliedOrNot(BuildContext context, index) {
    final provider =
        Provider.of<GetCreatedVacancyProvider>(context, listen: false);
    for (var i = 0; i < appliedJobs!.length; i++) {
      if (provider.createdVacancies![index].id == appliedJobs![i].jobId!.id) {
        alreadyApplied = true;
        notifyListeners();
        break;
      } else {
        alreadyApplied = false;
        notifyListeners();
      }
    }
  }
}
