import 'dart:developer';

import 'package:cleverhire/core/api/api_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DeletePostApiServices {
  Dio dio = Dio();

  Future deletePostServices(String postId) async {
    String path = "${ApiConfig.baseUrl}${ApiConfig.post}/$postId";
    FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();
    String? token = await flutterSecureStorage.read(key: "access_token");
    String newToken = token!.replaceAll('"', '');

    try {
      Response response = await dio.delete(path,
          options: Options(headers: {"authorization": "Bearer $newToken"}));

      log("deleted successfully... ${response.data}");
    } on DioError catch (e) {
      log("Entering in DioError : ${e.message}");
    }
  }
}
