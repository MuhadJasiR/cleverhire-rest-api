// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cleverhire/core/constraints/constraints.dart';
import 'package:cleverhire/authentication/controller/provider/sign_up_provider.dart';
import 'package:cleverhire/authentication/view/otp_screen.dart';
import 'package:cleverhire/authentication/view/sign_in_screen.dart';

import 'package:cleverhire/widgets/main_logo.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import '../../core/color/color.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Column(
                children: [
                  kHeight(80),
                  const MainLogo(),
                  kHeight(20),
                  Card(
                    child: SizedBox(
                      height: 560,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("User name"),
                                    kHeight(15),
                                    TextFormField(
                                      controller: provider.userNameController,
                                      decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.person,
                                            color: kMainColor,
                                            size: 25,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                  color: kMainColor)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          isDense: true),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your first name";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    kHeight(15),
                                    const Text("Email"),
                                    kHeight(15),
                                    TextFormField(
                                      controller: provider.emailController,
                                      decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.email,
                                            size: 25,
                                            color: kMainColor,
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                  color: kMainColor)),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          isDense: true),
                                      validator: (email) {
                                        bool validatedEmail =
                                            validateEmail(email);
                                        if (email == null || email.isEmpty) {
                                          return "Please Enter Email";
                                        } else if (validatedEmail == false) {
                                          return "Enter valid Email";
                                        }
                                        return null;
                                      },
                                    ),
                                    kHeight(15),
                                    const Text("Password"),
                                    kHeight(15),
                                    TextFormField(
                                      controller: provider.passwordController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.password_outlined,
                                            size: 25,
                                            color: kMainColor,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                  color: kMainColor)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          isDense: true),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your password";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    kHeight(15),
                                    const Text("Confirm Password"),
                                    kHeight(15),
                                    TextFormField(
                                      controller:
                                          provider.confirmPassWordController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.password_outlined,
                                            size: 25,
                                            color: kMainColor,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                  color: kMainColor)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          isDense: true),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your password";
                                        } else if (provider
                                                .passwordController.text !=
                                            provider.confirmPassWordController
                                                .text) {
                                          return "Password must be same";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    kHeight(10),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          const Text(
                                              "By clicking Agree and Join, You are agree to the"),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Text("CleverHire "),
                                              Text(
                                                "Privacy Policy ",
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                              Text("and "),
                                              Text(
                                                "User Agreement",
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              )
                                            ],
                                          ),
                                          kHeight(20),
                                          SizedBox(
                                            width: 200,
                                            height: 50,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: kMainColor),
                                              onPressed: () async {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  toast(
                                                      "     Loading\n\nSending OTP...");

                                                  String result = await provider
                                                      .checkUserSignUp(context);
                                                  // provider.disposeTextField();
                                                  log(result);
                                                  if (result == 'success') {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (ctc) {
                                                      return OtpVerificationScreen();
                                                    })).then((value) => provider
                                                        .disposeTextField());
                                                  } else {
                                                    showSimpleNotification(
                                                        Text(result));
                                                  }
                                                }
                                              },
                                              child: const Text(
                                                "Agree & join",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: kWhiteColor),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  kHeight(18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already join?"),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) {
                              return const SignInScreen();
                            }));
                          },
                          child: const Text(
                            "Sign in",
                            style: TextStyle(color: kMainColor),
                          ))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validateEmail(String? email) {
    bool emailResult = EmailValidator.validate(email.toString());
    return emailResult;
  }
}
