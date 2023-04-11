import 'dart:convert';
import 'dart:developer';

import 'package:cleverhire/authentication/controller/apiServices/sign_in_services.dart';
import 'package:cleverhire/authentication/model/sign_in/sign_in_req_model.dart';
import 'package:cleverhire/recruiter/view/home/recruiter_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../job_seeker/view/home/bottom_navigation_screen.dart';

class SignInProvider with ChangeNotifier {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> checkUserSignIn(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final signInUser = SignInReqModel(email: email, password: password);
    await SignInServicesApi().signIn(signInUser, context).then((value) async {
      isLoading = true;
      notifyListeners();
      if (value != null) {
        storage.write(
            key: 'access_token', value: jsonEncode(value.accessToken));

        storage.write(key: "role", value: jsonEncode(value.user.role));
        log(value.user.role.toString());

        final roleChecking = await storage.read(key: "role");
        log(roleChecking.toString());

        if (value.user.role == "recruiter") {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => RecruiterBottomNavigation()));
        } else if (value.user.role == "seeker") {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => BottomNavigation()));
        }

        disposeTexField();
      } else {
        log('showing simple notification');
        // showSimpleNotification(
        //     const Text(
        //       "Email and password does not match!",
        //       style: TextStyle(color: kWhiteColor),
        //     ),
        //     background: Colors.red);
        isLoading = false;
        notifyListeners();
      }
    });

    isLoading = false;
    notifyListeners();
  }

  void disposeTexField() {
    emailController.clear();
    passwordController.clear();
  }
}
