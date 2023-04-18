import 'dart:developer';

import 'package:cleverhire/core/api/api_config.dart';
import 'package:cleverhire/job_seeker/model/chat_res_model.dart';
import 'package:cleverhire/job_seeker/model/chat_user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GetAllChatApiServices {
  Dio dio = Dio();
  Future<GetAllChatModel?> fetchAllChatServices() async {
    String path = ApiConfig.baseUrl + ApiConfig.getChat;
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? token = await storage.read(key: "access_token");
    String newToken = token!.replaceAll('"', '');

    try {
      Response response = await dio.get(path,
          options: Options(headers: {"authorization": "Bearer $newToken"}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString(), name: "jasir");
        return GetAllChatModel.fromJson(response.data[0]);
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
    return null;
  }

  Future<List<ChatResModel>?> fetchPersonalChatServices(String chatId) async {
    String path = "${ApiConfig.baseUrl}${ApiConfig.getChat}/$chatId";
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? token = await storage.read(key: "access_token");
    String newToken = token!.replaceAll('"', '');

    try {
      Response response = await dio.get(path,
          options: Options(headers: {"authorization": "Bearer $newToken"}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString(), name: "response log");
        final List<ChatResModel> chatResModel = (response.data as List)
            .map((e) => ChatResModel.fromJson(e))
            .toList();

        return chatResModel;
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
    return null;
  }
}
