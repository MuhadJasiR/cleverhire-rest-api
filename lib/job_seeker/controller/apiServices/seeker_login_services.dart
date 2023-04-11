import 'dart:developer';

import 'package:cleverhire/core/api/api_config.dart';
import 'package:cleverhire/job_seeker/model/seeker_login_req_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../view/home/bottom_navigation_screen.dart';

class SeekerLoginApiServices {
  Dio dio = Dio();
  Future seekerLoginServices(SeekerReqModel model, BuildContext context) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? token = await storage.read(key: "access_token");
    String newToken = token!.replaceAll('"', '');
    String? path = ApiConfig.baseUrl + ApiConfig.seekerLogin;
    log("the path $path");
    log("THe token $newToken");
    try {
      Response response = await dio.post(
        path,
        data: model.toJson(),
        options: Options(headers: {"authorization": "Bearer $newToken"}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => BottomNavigation()));
        if (response.data["status"] == 422) {
          log(response.data["message"]);
        }
      }
    } on DioError catch (e) {
      log("Entering on dio error ; ${e.message}");
    }
  }
}
