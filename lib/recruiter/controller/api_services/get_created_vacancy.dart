import 'dart:developer';

import 'package:cleverhire/core/api/api_config.dart';
import 'package:cleverhire/recruiter/model/create_vacancy_model/create_vacancy_res_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GetCreatedVacancyApiServices {
  Dio dio = Dio();
  Future<List<CreateVacancyResModel>?> getCreatedVacancy() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    final path = ApiConfig.baseUrl + ApiConfig.createVacancy;

    String? token = await storage.read(key: "access_token");
    String newToken = token!.replaceAll('"', '');
    try {
      Response response = await dio.get(
        path,
        options: Options(headers: {"authorization": "Bearer $newToken"}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        final List<CreateVacancyResModel> vacancy = (response.data as List)
            .map((e) => CreateVacancyResModel.fromJson(e))
            .toList();
        return vacancy;
      } else {
        return null;
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
    return null;
  }
}
