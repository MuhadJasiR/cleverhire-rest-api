import 'dart:developer';

import 'package:cleverhire/job_seeker/model/seeker_res_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/api/api_config.dart';

class GetSeekerDetailsApiServices {
  Dio dio = Dio();
  Future<SeekerDetailsResModel?> getSeekerDetailsApiServices() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    final path = ApiConfig.baseUrl + ApiConfig.getUser;

    String? token = await storage.read(key: "access_token");
    String newToken = token!.replaceAll('"', '');
    try {
      Response response = await dio.get(path,
          options: Options(headers: {"authorization": "Bearer $newToken"}));
      if (response.statusCode == 201 || response.statusCode == 200) {
        log(response.data.toString());
        response.data;
        log(":::::::::::::");
        return SeekerDetailsResModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      log("Entering in dio error ${e.message}");
    }
    return null;
  }
}
