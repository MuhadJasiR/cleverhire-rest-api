import 'dart:developer';

import 'package:cleverhire/core/api/api_config.dart';
import 'package:cleverhire/authentication/model/sign_up/sign_up_req_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SignUpServicesApi {
  Dio dio = Dio();
  Future<String> signUpVerification(
      SignUpReqModel model, BuildContext context) async {
    String path = ApiConfig.baseUrl + ApiConfig.register;
    try {
      Response response = await dio.post(path, data: model.toJson());

      //=================================//
      if (response.statusCode == 201) {
        log(response.data.toString());

        log("status: ${response.data['status']}");
        if (response.data['status'] == 422) {
          return response.data['message'];
        }
      } else {
        return 'Something Went Wrong!!';
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
    return 'success';
  }
}
