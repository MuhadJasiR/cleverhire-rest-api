import 'dart:developer';

import 'package:cleverhire/core/api/api_config.dart';
import 'package:cleverhire/recruiter/model/create_vacancy_model/create_vacancy_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CreateVacancyApiServices {
  Dio dio = Dio();
  Future creatingVacancy(CreateVacancyModel model) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'access_token');
    String newToken = token!.replaceAll('"', '');
    String path = ApiConfig.baseUrl + ApiConfig.createVacancy;

    try {
      Response response = await dio.post(
        path,
        data: model.toJson(),
        options: Options(headers: {"authorization": "Bearer $newToken"}),
      );
      if (response.statusCode == 201) {
        log(response.data.toString());

        log("status: ${response.data['status']}");
        if (response.data['status'] == 422) {
          return response.data['message'];
        }
      } else {
        return 'Something Went Wrong!!';
      }
    } on DioError catch (e) {
      log("entering here");
      log(e.message.toString());
    }
  }
}
