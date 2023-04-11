import 'dart:developer';

import 'package:cleverhire/core/api/api_config.dart';
import 'package:cleverhire/job_seeker/model/upload_image_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UploadImageApiServices {
  Dio dio = Dio();
  Future uploadImageServices(UploadImageModel model) async {
    String path = ApiConfig.baseUrl + ApiConfig.post;
    FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();
    String? token = await flutterSecureStorage.read(key: "access_token");
    String newToken = token!.replaceAll('"', '');
    log(path);
    log(newToken);

    try {
      Response response = await dio.post(path,
          data: model.toJson(),
          options: Options(headers: {"authorization": "Bearer $newToken"}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
      }
    } on DioError catch (e) {
      log("entering on dio error");
      log(e.message.toString());
    }
  }
}
