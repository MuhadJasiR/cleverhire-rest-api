import 'dart:developer';

import 'package:cleverhire/core/color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../authentication/view/sign_in_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              onTap: () {},
              leading: Icon(Icons.assignment_late_sharp,
                  color: kMainColor.withOpacity(0.8)),
              title: const Text("About"),
            ),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              onTap: () {},
              leading: Icon(Icons.share, color: kMainColor.withOpacity(0.8)),
              title: const Text("share"),
            ),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              onTap: () {},
              leading: Icon(Icons.privacy_tip_rounded,
                  color: kMainColor.withOpacity(0.8)),
              title: const Text("Privacy policy"),
            ),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              onTap: () {},
              leading:
                  Icon(Icons.dark_mode, color: kMainColor.withOpacity(0.8)),
              title: const Text("Theme"),
            ),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              onTap: () {
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
                          onPressed: () async {
                            final token =
                                await storage.read(key: "access_token");

                            storage.delete(key: "access_token");
                            log(token!);
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const SignInScreen()),
                                (route) => false);
                          },
                          child: const Text(
                            "Yes",
                            style: TextStyle(color: Colors.red),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "No",
                          ))
                    ],
                  ),
                );
              },
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout"),
            ),
          ),
          const Spacer(),
          Text(
            "version 1.0.0",
            style: TextStyle(color: Colors.grey[600]),
          )
        ]),
      ),
    );
  }
}
