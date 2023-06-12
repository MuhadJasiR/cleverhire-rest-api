// ignore_for_file: use_build_context_synchronously, invalid_use_of_protected_member

import 'package:cleverhire/core/color/color.dart';
import 'package:cleverhire/core/constraints/constraints.dart';
import 'package:cleverhire/authentication/controller/provider/otp_verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:overlay_support/overlay_support.dart';
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
                      Form(
                          key: otpFormKey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    // color: kMainColor,
                                    borderRadius: BorderRadius.circular(10)),
                                width: 50,
                                child: TextFormField(
                                  controller: provider.textEditingController1,
                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: kMainColor)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          borderSide:
                                              BorderSide(color: kMainColor)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red)),
                                      // fillColor: kMainColor,
                                      // filled: false,
                                      border: InputBorder.none),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    // color: kMainColor,
                                    borderRadius: BorderRadius.circular(10)),
                                width: 50,
                                child: TextFormField(
                                  controller: provider.textEditingController2,
                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: kMainColor)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          borderSide:
                                              BorderSide(color: kMainColor)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red)),
                                      // fillColor: kMainColor,
                                      // filled: false,
                                      border: InputBorder.none),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    // color: kMainColor,
                                    borderRadius: BorderRadius.circular(10)),
                                width: 50,
                                child: TextFormField(
                                  controller: provider.textEditingController3,
                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: kMainColor)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          borderSide:
                                              BorderSide(color: kMainColor)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red)),
                                      // fillColor: kMainColor,
                                      // filled: false,
                                      border: InputBorder.none),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    // color: kMainColor,
                                    borderRadius: BorderRadius.circular(10)),
                                width: 50,
                                child: TextFormField(
                                  controller: provider.textEditingController4,
                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: kMainColor)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          borderSide:
                                              BorderSide(color: kMainColor)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red)),
                                      // fillColor: kMainColor,
                                      // filled: false,
                                      border: InputBorder.none),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    // color: kMainColor,
                                    borderRadius: BorderRadius.circular(10)),
                                width: 50,
                                child: TextFormField(
                                  controller: provider.textEditingController5,
                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: kMainColor)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          borderSide:
                                              BorderSide(color: kMainColor)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red)),
                                      // fillColor: kMainColor,
                                      // filled: false,
                                      border: InputBorder.none),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    // color: kMainColor,
                                    borderRadius: BorderRadius.circular(10)),
                                width: 50,
                                child: TextFormField(
                                  controller: provider.textEditingController6,
                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: kMainColor)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          borderSide:
                                              BorderSide(color: kMainColor)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red)),
                                      // fillColor: kMainColor,
                                      // filled: false,
                                      border: InputBorder.none),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          )),
                      kHeight(40),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kMainColor),
                          onPressed: () async {
                            if (otpFormKey.currentState!.validate()) {
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
