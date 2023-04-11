import 'dart:developer';

import 'package:cleverhire/authentication/model/sign_up/sign_up_res.dart';
import 'package:cleverhire/core/api/api_config.dart';
import 'package:cleverhire/authentication/model/sign_up/otp_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OtpServicesApi {
  Dio dio = Dio();
  Future<SignUpResModel?> otpVerification(
      SignUpOtpModel model, BuildContext context) async {
    String path = ApiConfig.baseUrl + ApiConfig.otpVerify;
    Response response = await dio.post(path, data: model.toJson());
    if (response.statusCode == 201) {
      log(response.data.toString());

      if (response.data['access_token'] != null) {
        SignUpResModel signUpResModel = SignUpResModel.fromJson(response.data);
        return signUpResModel;
      } else {
        log('OTP action failed');
        return null;
      }
    }
    return null;
  }
}
