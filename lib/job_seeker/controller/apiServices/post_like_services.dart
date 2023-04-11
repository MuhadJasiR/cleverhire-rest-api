import 'dart:developer';

import 'package:cleverhire/core/api/api_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PostLikeApiServices {
  Dio dio = Dio();
  List? likeCounts;
  Future postLiking(String postId) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? token = await storage.read(key: "access_token");
    String newToken = token!.replaceAll('"', '');
    String path = "${ApiConfig.baseUrl}${ApiConfig.postLike}$postId/like";

    try {
      Response response = await dio.post(path,
          options: Options(headers: {"authorization": "Bearer $newToken"}));
      log(response.data.toString());
    } on DioError catch (e) {
      log("Entering in dioError ${e.message}");
    }
  }

  Future postDisLiking(String postId) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? token = await storage.read(key: "access_token");
    String newToken = token!.replaceAll('"', '');
    String path = "${ApiConfig.baseUrl}${ApiConfig.postLike}$postId/like";

    try {
      Response response = await dio.delete(path,
          options: Options(headers: {"authorization": "Bearer $newToken"}));
      log(response.data.toString());
    } on DioError catch (e) {
      log("Entering in dioError ${e.message}");
    }
  }
}
