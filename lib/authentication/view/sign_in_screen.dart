import 'package:cleverhire/core/color/color.dart';
import 'package:cleverhire/core/constraints/constraints.dart';
import 'package:cleverhire/authentication/controller/provider/sign_in_provider.dart';
import 'package:cleverhire/authentication/view/sign_up_screen.dart';

import 'package:cleverhire/widgets/main_logo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

GlobalKey<FormState> formKey = GlobalKey<FormState>();
bool _passwordVisible = false;

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignInProvider>(context);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              kHeight(80),
              const MainLogo(),
              kHeight(20),
              Card(
                child: SizedBox(
                  height: 550,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: formKey,
                      child: provider.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                kHeight(5),
                                Text(
                                  "Sign In",
                                  style: GoogleFonts.lato(
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold),
                                ),
                                kHeight(5),
                                const Text(
                                  "Get update on your career",
                                  style: TextStyle(fontSize: 13),
                                ),
                                kHeight(20),
                                const Text("Email"),
                                kHeight(13),
                                TextFormField(
                                  controller: provider.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.email,
                                        size: 25,
                                        color: kMainColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              color: kMainColor)),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: kMainColor),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      errorBorder: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      isDense: true),
                                  validator: (email) {
                                    bool validatedEmail = validateEmail(email);
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
                                kHeight(13),
                                TextFormField(
                                  controller: provider.passwordController,
                                  obscureText: _passwordVisible,
                                  decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.password_outlined,
                                        size: 25,
                                        color: kMainColor,
                                      ),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _passwordVisible =
                                                  !_passwordVisible;
                                            });
                                          },
                                          icon: Icon(
                                            _passwordVisible
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            size: 25,
                                            color: kMainColor,
                                          )),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: kMainColor),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      errorBorder: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      isDense: true),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter Your Password";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                kHeight(5),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Forget Password?",
                                      style: TextStyle(color: kMainColor),
                                    )),
                                kHeight(12),
                                SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        height: 50,
                                        child: Consumer<SignInProvider>(
                                          builder: (context, value, child) =>
                                              ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: kMainColor),
                                            onPressed: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                value.checkUserSignIn(context);
                                              }
                                            },
                                            child: const Text(
                                              "Sign in",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: kWhiteColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                      kHeight(10),
                                      const Text("or"),
                                      kHeight(10),
                                      SizedBox(
                                        width: 200,
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: kBlackColor),
                                          onPressed: () {},
                                          child: const Text(
                                            "Sign in with Google",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: kWhiteColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                    ),
                  ),
                ),
              ),
              kHeight(18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("New to CleverHire?"),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(builder: (ctx) {
                          return SignUpScreen();
                        }));
                      },
                      child: const Text(
                        "Join now",
                        style: TextStyle(color: kMainColor),
                      ))
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
