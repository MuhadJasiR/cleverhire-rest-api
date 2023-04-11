import 'package:cleverhire/job_seeker/controller/apiServices/search_vacancy_services.dart';
import 'package:cleverhire/recruiter/model/create_vacancy_model/create_vacancy_res_model.dart';
import 'package:flutter/cupertino.dart';

class SearchJobVacancyProvider with ChangeNotifier {
  List<CreateVacancyResModel>? searchResult;
  List<CreateVacancyResModel>? createdVacancy;
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();

  Future<void> searchRunFilterProvider(String enteredValue) async {
    isLoading = true;
    notifyListeners();

    final searchedList = SearchJobVacancyApiServices();
    await searchedList
        .searchedVacancy(enteredValue)
        .then((value) => {searchResult = value, notifyListeners()});
    isLoading = false;
    notifyListeners();

    if (enteredValue.isEmpty) {
      createdVacancy = searchResult;
      notifyListeners();
    } else {
      createdVacancy = searchResult!
          .where((element) => element.position
              .toLowerCase()
              .contains(enteredValue.toLowerCase()))
          .toList();
      notifyListeners();
    }
  }
}
