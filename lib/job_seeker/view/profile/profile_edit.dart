import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../authentication/view/sign_in_screen.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({super.key});
  final FlutterSecureStorage signInStorage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text(
                        "Alert!",
                        style: TextStyle(color: Colors.red),
                      ),
                      content: const Text("Are to sure to sign out"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("No")),
                        TextButton(
                            onPressed: () {
                              signInStorage.delete(key: "access_token");
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInScreen()),
                                  (route) => false);
                            },
                            child: const Text(
                              "Yes",
                              style: TextStyle(color: Colors.red),
                            ))
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: Column());
  }
}
