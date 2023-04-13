import 'dart:developer';

import 'package:cleverhire/core/api/api_config.dart';
import 'package:cleverhire/job_seeker/model/seeker_login_req_model.dart';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UpdateSeekerDetailsApiServices {
  Dio dio = Dio();
  Future updateSeekerLogin(SeekerReqModel model) async {
    String path = ApiConfig.baseUrl + ApiConfig.seekerLogin;
    FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();
    String? token = await flutterSecureStorage.read(key: "access_token");
    String newToken = token!.replaceAll('"', '');
    log(path);
    log(newToken);
    try {
      Response response = await dio.put(path,
          data: model.toJson(),
          options: Options(headers: {"authorization": "Bearer $newToken"}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("${response.data}");
      }
    } on DioError catch (e) {
      log("Entering in dio Error ${e.message}");
    }
  }
}
