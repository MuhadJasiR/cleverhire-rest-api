import 'package:cleverhire/authentication/controller/apiServices/otp_services.dart';
import 'package:cleverhire/authentication/controller/provider/sign_up_provider.dart';
import 'package:cleverhire/authentication/model/sign_up/otp_model.dart';
import 'package:cleverhire/authentication/model/sign_up/sign_up_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class OtpVerificationProvider with ChangeNotifier {
  FlutterSecureStorage signUpStorage = const FlutterSecureStorage();
  String? otp;
  bool isLoading = false;
  Future<String> otpVerificationChecking(BuildContext context) async {
    final provider = Provider.of<SignUpProvider>(context, listen: false);
    isLoading = true;
    notifyListeners();

    final email = provider.emailController.text.trim();

    final verifiedOtp = SignUpOtpModel(email: email, otp: int.parse(otp!));
    SignUpResModel? signUpResModel =
        await OtpServicesApi().otpVerification(verifiedOtp, context);
    if (signUpResModel != null) {
      signUpStorage.write(
          key: 'access_token', value: signUpResModel.accessToken);
      return "success";
    } else {
      isLoading = false;
      notifyListeners();
      return "Invalid OTP sent";
    }
  }

  disposeOtpTextField() {}
}
