import 'dart:developer';

import 'package:cleverhire/core/api/api_config.dart';
import 'package:cleverhire/recruiter/model/create_vacancy_model/create_vacancy_res_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SearchJobVacancyApiServices {
  Dio dio = Dio();
  Future<List<CreateVacancyResModel>?> searchedVacancy(
      String searchQuery) async {
    FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();
    String? token = await flutterSecureStorage.read(key: "access_token");
    String? newToken = token!.replaceAll('"', '');
    try {
      String path =
          "${ApiConfig.baseUrl}${ApiConfig.createVacancy}?position=$searchQuery";
      Response response = await dio.get(path,
          options: Options(headers: {"authorization": "Bearer $newToken"}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("getting searched data ${response.data}");
        final List<CreateVacancyResModel> searchedVacancy =
            (response.data as List)
                .map((e) => CreateVacancyResModel.fromJson(e))
                .toList();
        return searchedVacancy;
      } else {
        return null;
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
    return null;
  }
}
