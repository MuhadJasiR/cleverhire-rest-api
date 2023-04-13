import 'package:cleverhire/job_seeker/controller/apiServices/get_seeker_details.dart';

import 'package:flutter/material.dart';

import '../../model/seeker_res_model.dart';

class GetSeekerDetailsProvider with ChangeNotifier {
  bool isLoading = false;
  SeekerDetailsResModel? seekerDetails;
  Future<void> fetchSeekerDetails() async {
    isLoading = true;
    notifyListeners();
    await GetSeekerDetailsApiServices()
        .getSeekerDetailsApiServices()
        .then((value) {
      seekerDetails = value;
      notifyListeners();
      isLoading = false;
      notifyListeners();
    });
    isLoading = false;
    notifyListeners();
  }
}
