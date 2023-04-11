import 'package:cleverhire/authentication/controller/apiServices/sign_up_services.dart';
import 'package:cleverhire/authentication/model/sign_up/sign_up_req_model.dart';
import 'package:flutter/material.dart';

class SignUpProvider with ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassWordController = TextEditingController();
  final userNameController = TextEditingController();

  bool isLoading = false;
  Future<String> checkUserSignUp(BuildContext context) async {
    isLoading = true;
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final userName = userNameController.text.trim();

    final signUpUser =
        SignUpReqModel(email: email, password: password, username: userName);
    String result =
        await SignUpServicesApi().signUpVerification(signUpUser, context);
    return result;
  }

  void disposeTextField() {
    emailController.clear();
    passwordController.clear();
    confirmPassWordController.clear();
    userNameController.clear();
  }
}
