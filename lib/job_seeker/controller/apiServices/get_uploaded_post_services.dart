import 'dart:developer';

import 'package:cleverhire/job_seeker/model/get_post_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/api/api_config.dart';

class GetUploadedPostApiServices {
  Dio dio = Dio();

  Future<List<GetUploadImageModel>?> getUploadedPost() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    final path = ApiConfig.baseUrl + ApiConfig.post;

    String? token = await storage.read(key: "access_token");
    String newToken = token!.replaceAll('"', '');
    try {
      Response response = await dio.get(
        path,
        options: Options(headers: {"authorization": "Bearer $newToken"}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString(), name: "fetching post image");
        final List<GetUploadImageModel> uploadedImagePost =
            (response.data as List)
                .map((e) => GetUploadImageModel.fromJson(e))
                .toList();
        return uploadedImagePost;
      }
    } on DioError catch (e) {
      log("Entering in dio error ${e.message}");
    }
    return null;
  }
}
