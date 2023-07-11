import 'dart:convert';
import 'dart:developer';

import 'package:cleverhire/authentication/controller/provider/sign_in_provider.dart';
import 'package:cleverhire/core/api/api_config.dart';
import 'package:cleverhire/authentication/model/sign_in/sign_in_req_model.dart';
import 'package:cleverhire/authentication/model/sign_in/sign_in_res.dart';
import 'package:cleverhire/core/color/color.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

class SignInServicesApi {
  Dio dio = Dio();
  Future<SignInRes?> signIn(SignInReqModel model, BuildContext context) async {
    String path = ApiConfig.baseUrl + ApiConfig.login;
    final provider = Provider.of<SignInProvider>(context, listen: false);
    try {
      Response response =
          await dio.post(path, data: jsonEncode(model.toJson()));
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        log("entering here ");
        if (response.data["message"] ==
            "no user with given email address is found") {
          provider.isLoading = false;
          provider.notifyListeners();
          showSimpleNotification(
              const Text(
                "no user with given email address is found",
                style: TextStyle(color: kWhiteColor),
              ),
              background: Colors.red);
        }

        if (response.data["status"] == 422) {
          provider.isLoading = false;
          provider.notifyListeners();
          log('Wrong password email');
          showSimpleNotification(
              const Text(
                "Incorrect password!..",
                style: TextStyle(color: kWhiteColor),
              ),
              background: Colors.red);
          return null;
        } else {
          final SignInRes signInResModel1 = SignInRes.fromJson(response.data);

          return signInResModel1;
        }
      }
    } on DioError catch (e) {
      showSimpleNotification(
          const Text(
            'Oops! There was a problem with the server. Please try again later.',
            // e.message.toString(),
            style: TextStyle(color: kWhiteColor),
          ),
          background: Colors.red);

      log(e.message.toString());
    }

    return null;
  }
}
