import 'dart:developer';

import 'package:cleverhire/recruiter/controller/api_services/get_created_vacancy.dart';
import 'package:cleverhire/recruiter/model/create_vacancy_model/create_vacancy_res_model.dart';
import 'package:flutter/foundation.dart';

class GetCreatedVacancyProvider with ChangeNotifier {
  List<CreateVacancyResModel>? createdVacancies;
  bool isLoading = false;
  int? indexId = 0;

  List<CreateVacancyResModel>? createdVacancy;
  Future<void> fetchCreatedVacancies() async {
    isLoading = true;
    notifyListeners();
    final apiServices = GetCreatedVacancyApiServices();
    await apiServices.getCreatedVacancy().then((value) {
      createdVacancies = value;
      createdVacancy = value;
      notifyListeners();
      isLoading = false;
      notifyListeners();
    });
    isLoading = false;
    notifyListeners();
  }

  void runFilter(String enterKeyword) {
    if (enterKeyword.isEmpty) {
      createdVacancy = createdVacancies!;
      notifyListeners();
    } else {
      createdVacancy = createdVacancies!
          .where((value) =>
              value.position.toLowerCase().contains(enterKeyword.toLowerCase()))
          .toList();
      notifyListeners();
      log(createdVacancy.toString());
    }
  }
}
