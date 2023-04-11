import 'dart:developer';

import 'package:cleverhire/core/api/api_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../model/get_applied_jobs_model.dart';

class GetAppliedJobsApiServices {
  Dio dio = Dio();
  Future<List<GetAppliedJobsModel>?> getAppliedJobsServices() async {
    String path = "${ApiConfig.baseUrl}${ApiConfig.applyVacancy}applied";
    FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();
    String? token = await flutterSecureStorage.read(key: "access_token");
    String newToken = token!.replaceAll('"', '');
    try {
      Response response = await dio.get(path,
          options: Options(headers: {"authorization": "Bearer $newToken"}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        final List<GetAppliedJobsModel> appliedJobs = (response.data as List)
            .map((e) => GetAppliedJobsModel.fromJson(e))
            .toList();
        return appliedJobs;
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
    return null;
  }
}
