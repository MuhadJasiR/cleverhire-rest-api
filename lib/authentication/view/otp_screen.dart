// ignore_for_file: use_build_context_synchronously, invalid_use_of_protected_member

import 'dart:developer';

import 'package:cleverhire/core/color/color.dart';
import 'package:cleverhire/core/constraints/constraints.dart';
import 'package:cleverhire/authentication/controller/provider/otp_verification.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import 'starting_screen.dart';

// ignore: must_be_immutable
class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({super.key});

  GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OtpVerificationProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              kHeight(170),
              Card(
                child: SizedBox(
                  height: 550,
                  width: double.infinity,
                  child: Column(
                    children: [
                      kHeight(70),
                      const Text(
                        "Enter the code that was sent to\nyour mail",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      kHeight(50),
                      const Text(
                        "To finish registering, please enter the verification code we gave you.\nit might take few minutes to receive you code",
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      kHeight(50),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Pinput(
                          onCompleted: (value) {
                            provider.otp = value;
                            log(provider.otp!);
                          },
                          length: 6,
                          showCursor: true,
                          defaultPinTheme: PinTheme(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: kMainColor)),
                            textStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      kHeight(40),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kMainColor),
                          onPressed: () async {
                            if (provider.otp != null) {
                              String result = await provider
                                  .otpVerificationChecking(context);

                              if (result == 'success') {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const StartingScreen()),
                                    (route) => false);
                              } else {
                                showSimpleNotification(Text(result),
                                    background: Colors.red,
                                    foreground: Colors.white);
                              }
                              provider.disposeOtpTextField();
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        "Enter 6-Digit code",
                                        style: TextStyle(color: Colors.white),
                                      )));
                            }
                          },
                          child: provider.isLoading
                              ? LoadingAnimationWidget.waveDots(
                                  color: kWhiteColor, size: 40)
                              : const Text(
                                  "Verify",
                                  style: TextStyle(
                                      fontSize: 20, color: kWhiteColor),
                                ),
                        ),
                      ),
                      kHeight(30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Didn't  receive the code?"),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Resend",
                                style: TextStyle(color: kMainColor),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
