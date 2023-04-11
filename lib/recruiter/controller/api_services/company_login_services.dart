import 'dart:developer';

import 'package:cleverhire/core/api/api_config.dart';
import 'package:cleverhire/recruiter/model/company_login_req_model/company_req_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CompanyLoginApiService {
  Dio dio = Dio();

  Future companyLoginVerification(CompanyReqModel model) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? token = await storage.read(key: "access_token");
    String path = ApiConfig.baseUrl + ApiConfig.userRecruiter;
    try {
      Response response = await dio.post(
        path,
        data: model.toJson(),
        options: Options(headers: {"authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        if (response.data["status"] == 422) {
          log(response.data["message"]);
        }
      }
    } on DioError catch (e) {
      log("Dio error");
      log(e.message.toString());
    }
  }
}
