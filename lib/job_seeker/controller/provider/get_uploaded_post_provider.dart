import 'dart:developer';

import 'package:cleverhire/job_seeker/controller/apiServices/get_uploaded_post_services.dart';
import 'package:cleverhire/job_seeker/model/get_post_model.dart';
import 'package:flutter/material.dart';

class GetUploadedPostProvider with ChangeNotifier {
  List<GetUploadImageModel>? uploadedPost;

  bool isLoading = false;
  String? formattedDate;

  Future fetchUploadedPost() async {
    isLoading = true;
    await GetUploadedPostApiServices().getUploadedPost().then((value) {
      uploadedPost = value;
      notifyListeners();
      isLoading = false;
      notifyListeners();
      uploadedPost!.reversed.toList();
      notifyListeners();
    });
    isLoading = false;
    notifyListeners();
    log(uploadedPost.toString());
  }
}
