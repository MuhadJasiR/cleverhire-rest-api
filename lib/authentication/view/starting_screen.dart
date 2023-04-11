import 'package:cleverhire/core/color/color.dart';
import 'package:cleverhire/core/constraints/constraints.dart';
import 'package:cleverhire/authentication/view/choose_profile.dart';
import 'package:cleverhire/widgets/main_logo.dart';
import 'package:flutter/material.dart';

class StartingScreen extends StatelessWidget {
  const StartingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            kHeight(170),
            const MainLogo(),
            Text(
              "Your One-Stop Shop for Job Opportunities -\nCleverHire",
              style: kSubFont,
              textAlign: TextAlign.center,
            ),
            kHeight(130),
            const Text(
              "Congrats!",
              style: TextStyle(
                  color: kMainColor, fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const Text("Your account is ready to use"),
            kHeight(170),
            SizedBox(
              width: 200,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: kMainColor),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return const ChooseProfile();
                  }));
                },
                child: const Text(
                  "Get started",
                  style: TextStyle(fontSize: 20, color: kWhiteColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
