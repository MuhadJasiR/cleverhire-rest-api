import 'dart:developer';

import 'package:cleverhire/core/api/api_config.dart';
import 'package:cleverhire/recruiter/model/get_applied_people_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GetAppliedPeopleApiServices {
  Dio dio = Dio();
  Future<List<GetAppliedPeopleModel>?> getAppliedPeopleServices(
      String jobId) async {
    String path =
        "${ApiConfig.baseUrl}${ApiConfig.applyVacancy}$jobId/applications";
    FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();
    String? token = await flutterSecureStorage.read(key: "access_token");
    String newToken = token!.replaceAll('"', '');

    try {
      Response response = await dio.get(path,
          options: Options(headers: {"authorization": "Bearer $newToken"}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        final List<GetAppliedPeopleModel> appliedPeople =
            (response.data as List)
                .map((e) => GetAppliedPeopleModel.fromJson(e))
                .toList();
        return appliedPeople;
      }
    } on DioError catch (e) {
      log("Entering in dio Error ; ${e.message}");
    }
    return null;
  }
}
