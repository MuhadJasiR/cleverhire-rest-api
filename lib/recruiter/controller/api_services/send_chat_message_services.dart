import 'dart:developer';

import 'package:cleverhire/core/api/api_config.dart';
import 'package:cleverhire/job_seeker/model/send_chat_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SendChatApiServices {
  Dio dio = Dio();
  Future sendChatMessage(SendChatModel model) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'access_token');
    String newToken = token!.replaceAll('"', '');
    String path = ApiConfig.baseUrl + ApiConfig.sendMessage;

    try {
      Response response = await dio.post(path,
          data: model.toJson(),
          options: Options(headers: {"authorization": "Bearer $newToken"}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
  }
}
