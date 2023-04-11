import 'dart:developer';

import 'package:cleverhire/core/api/api_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JobStatusChangingApiServices {
  Dio dio = Dio();
  Future jobStatusChangingServices(String jobId, selectedStatus) async {
    String path = ApiConfig.baseUrl + ApiConfig.jobStatus + jobId;
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? token = await storage.read(key: "access_token");
    String newToken = token!.replaceAll('"', '');
    try {
      Response response = await dio.patch(
        path,
        data: {"status": "$selectedStatus"},
        options: Options(headers: {"authorization": "Bearer $newToken"}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        log("success changed your job status");
      }
    } on DioError catch (e) {
      log("Entering in dioError ${e.message}");
    }
  }
}
