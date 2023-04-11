import 'dart:developer';

import 'package:cleverhire/recruiter/controller/api_services/get_applied_people_services.dart';
import 'package:cleverhire/recruiter/model/get_applied_people_model.dart';
import 'package:flutter/foundation.dart';

class GetAppliedPeoplesProvider with ChangeNotifier {
  List<GetAppliedPeopleModel>? appliedPeoples;
  bool isLoading = false;
  Future<void> fetchingAppliedPeople(String jobId) async {
    isLoading = true;
    notifyListeners();
    final appliedPeoplesApiServices = GetAppliedPeopleApiServices();
    await appliedPeoplesApiServices
        .getAppliedPeopleServices(jobId)
        .then((value) {
      appliedPeoples = value;
      notifyListeners();
      isLoading = false;
      notifyListeners();
    });
    isLoading = false;
    notifyListeners();
    log(appliedPeoples.toString());
  }
}
