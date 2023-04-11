import 'dart:developer';

import 'package:cleverhire/core/api/api_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DeleteJobVacancyApiServices {
  Dio dio = Dio();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future deleteJobVacancy(String jobId) async {
    try {
      String path = ApiConfig.baseUrl + ApiConfig.applyVacancy + jobId;
      String? token = await _secureStorage.read(key: "access_token");
      String? newToken = token!.replaceAll('"', '');
      Response response = await dio.delete(path,
          options: Options(headers: {"authorization": "Bearer $newToken"}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Deleted successfully..");
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
  }
}
