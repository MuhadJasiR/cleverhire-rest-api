import 'dart:developer';

import 'package:cleverhire/core/api/api_config.dart';
import 'package:cleverhire/recruiter/model/create_vacancy_model/create_vacancy_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UpdateVacancyApiServices {
  Dio dio = Dio();
  Future updateVacancy(CreateVacancyModel model, String vacancyId) async {
    String path = ApiConfig.baseUrl + ApiConfig.applyVacancy + vacancyId;
    log(vacancyId);
    log(path);
    FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();
    String? token = await flutterSecureStorage.read(key: 'access_token');
    String newToken = token!.replaceAll('"', '');
    log(newToken);
    try {
      Response response = await dio.put(
        path,
        data: model.toJson(),
        options: Options(headers: {"authorization": "Bearer $newToken"}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("${response.data}");
      }
    } on DioError catch (e) {
      log("Entering here");
      log(e.message.toString());
    }
  }
}
