// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cleverhire/authentication/view/sign_in_screen.dart';
import 'package:cleverhire/authentication/view/starting_screen.dart';
import 'package:cleverhire/recruiter/view/home/recruiter_bottom_navigation.dart';
import 'package:cleverhire/widgets/main_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../job_seeker/view/home/bottom_navigation_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(seconds: 1));
      FlutterSecureStorage storage = const FlutterSecureStorage();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool seen = (prefs.getBool("seen") ?? false);
      String? token = await storage.read(key: 'access_token');
      log(token.toString(), name: "token splash screen");
      String? roleChecking = await storage.read(key: 'role');
      // log(roleChecking!);
      final String? role = roleChecking;
      if (token == null) {
        splashScreen(context);
      } else if (seen) {
        if (role == '"recruiter"') {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: ((ctx) => RecruiterBottomNavigation())));
        } else if (role == '"seeker"') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: ((ctx) => BottomNavigation())));
        }
      } else {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const StartingScreen()));
      }
    });
    return const Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: MainLogo(),
      ),
    );
  }

  Future<void> splashScreen(context) async {
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: ((ctx) => const SignInScreen())));
  }
}
