import 'package:cleverhire/core/constraints/constraints.dart';
import 'package:flutter/material.dart';

class RecruiterMessageScreen extends StatelessWidget {
  const RecruiterMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              child: Image.asset(
                "assets/profile.png",
              ),
            ),
            kWidth(10),
            const Text(
              "Jasir",
            ),
          ],
        ),
      ),
    );
  }
}
