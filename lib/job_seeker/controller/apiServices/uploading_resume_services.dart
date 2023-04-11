import 'dart:developer';

import 'package:cleverhire/core/api/api_config.dart';
import 'package:cleverhire/job_seeker/model/applying_for_vacancy_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApplyingForVacancy {
  Dio dio = Dio();
  Future applyingForVacancyServices(
      ApplyingForVacancyModel model, String jobId) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? token = await storage.read(key: "access_token");
    String newToken = token!.replaceAll('"', '');
    String? path = "${ApiConfig.baseUrl}${ApiConfig.applyVacancy}$jobId/apply";

    try {
      log(path);
      log(newToken);
      Response response = await dio.post(
        path,
        data: model.toJson(),
        options: Options(headers: {"authorization": "Bearer $newToken"}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        if (response.data["status"] == 422) {
          log(response.data["message"]);
        }
      }
    } on DioError catch (e) {
      log("Error.... cant apply for job.");
      log(e.message.toString());
    }
  }
}
