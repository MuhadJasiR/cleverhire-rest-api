import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/api/api_config.dart';

class CommentApiServices {
  Dio dio = Dio();
  Future commentApiServices(String postId, String commentController) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? token = await storage.read(key: "access_token");
    String newToken = token!.replaceAll('"', '');
    String path = "${ApiConfig.baseUrl}${ApiConfig.postLike}$postId/comment";

    try {
      Response response = await dio.post(path,
          options: Options(headers: {"authorization": "Bearer $newToken"}),
          data: {"comment": commentController});

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
      }
    } on DioError catch (e) {
      log("Entering dio error ${e.message}");
    }
  }
}
