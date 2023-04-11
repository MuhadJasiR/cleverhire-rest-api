import 'package:cleverhire/recruiter/controller/api_services/update_vacancy_services.dart';
import 'package:cleverhire/recruiter/controller/provider/create_vacancy_provider.dart';

import 'package:cleverhire/recruiter/model/create_vacancy_model/create_vacancy_model.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class UpdateVacancyProvider with ChangeNotifier {
  Future<void> updateVacancyProvider(String vacancyId, context) async {
    final createVacancyProvider =
        Provider.of<CreateVacancyProvider>(context, listen: false);

    final updateVacancyPosition =
        createVacancyProvider.openPositionController.text;
    final updateVacancySalary = createVacancyProvider.salaryController.text;
    final updateVacancyLocationType =
        createVacancyProvider.selectedLocationType;
    final updateVacancyJobType = createVacancyProvider.selectedJobType;
    final updateVacancyRequirements =
        createVacancyProvider.requirementsController.text;

    final updateVacancyModel = CreateVacancyModel(
        position: updateVacancyPosition,
        salary: int.parse(updateVacancySalary),
        locationType: updateVacancyLocationType!,
        type: updateVacancyJobType!,
        description: updateVacancyRequirements);

    UpdateVacancyApiServices().updateVacancy(updateVacancyModel, vacancyId);
  }
}
