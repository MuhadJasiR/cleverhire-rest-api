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
    isLoading = true;
    notifyListeners();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final signInUser = SignInReqModel(email: email, password: password);
    await SignInServicesApi().signIn(signInUser, context).then((value) async {
      if (value != null) {
        storage.write(
            key: 'access_token', value: jsonEncode(value.accessToken));

        storage.write(key: "role", value: jsonEncode(value.user.role));
        log(value.user.role.toString());

        storage.write(key: "_id", value: value.user.id);
        log(value.user.id, name: "receiver Id");

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
        log('showing simple notification', name: "value==null");
        // showSimpleNotification(
        //     const Text(
        //       "Email and password does not match!",
        //       style: TextStyle(color: kWhiteColor),
        //     ),
        //     background: Colors.red);
        // isLoading = false;
        // notifyListeners();
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
