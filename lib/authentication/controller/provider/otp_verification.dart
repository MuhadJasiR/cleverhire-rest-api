import 'package:cleverhire/authentication/controller/apiServices/otp_services.dart';
import 'package:cleverhire/authentication/controller/provider/sign_up_provider.dart';
import 'package:cleverhire/authentication/model/sign_up/otp_model.dart';
import 'package:cleverhire/authentication/model/sign_up/sign_up_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class OtpVerificationProvider with ChangeNotifier {
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController textEditingController3 = TextEditingController();
  TextEditingController textEditingController4 = TextEditingController();
  TextEditingController textEditingController5 = TextEditingController();
  TextEditingController textEditingController6 = TextEditingController();
  FlutterSecureStorage signUpStorage = const FlutterSecureStorage();

  bool isLoading = false;
  Future<String> otpVerificationChecking(BuildContext context) async {
    final provider = Provider.of<SignUpProvider>(context, listen: false);
    isLoading = true;
    String otp = textEditingController1.text +
        textEditingController2.text +
        textEditingController3.text +
        textEditingController4.text +
        textEditingController5.text +
        textEditingController6.text;
    final email = provider.emailController.text.trim();

    final verifiedOtp = SignUpOtpModel(email: email, otp: int.parse(otp));
    SignUpResModel? signUpResModel =
        await OtpServicesApi().otpVerification(verifiedOtp, context);
    if (signUpResModel != null) {
      signUpStorage.write(
          key: 'access_token', value: signUpResModel.accessToken);
      return "success";
    } else {
      return "Invalid OTP sent";
    }
  }
}
