import 'package:cleverhire/authentication/view/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/color/color.dart';

import 'package:cleverhire/recruiter/controller/provider/company_login_provider.dart';

import 'package:provider/provider.dart';

import '../../../core/constraints/constraints.dart';

class RecruiterProfileEditingScreen extends StatelessWidget {
  const RecruiterProfileEditingScreen({super.key});
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text("Profile"),
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
                              storage.delete(key: "access_token");
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Consumer<CompanyLoginProvider>(
              builder: (context, value, child) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  kHeight(10),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: kMainColor,
                        child: ClipOval(
                            child: Image.asset("assets/BeFunky-collage.jpg")),
                      ),
                      Positioned(
                          bottom: -13,
                          right: -12,
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.edit_square)))
                    ],
                  ),
                  kHeight(15),
                  const Text("Upload Company Logo"),
                  kHeight(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Name of Company"),
                      kHeight(5),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: value.companyNameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: kMainColor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            isDense: true),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter company name";
                          } else {
                            return null;
                          }
                        },
                      ),
                      kHeight(15),
                      const Text("Email"),
                      kHeight(5),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: value.emailController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: kMainColor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            isDense: true),
                      ),
                      kHeight(15),
                      const Text("Established date"),
                      kHeight(5),
                      TextFormField(
                        keyboardType: TextInputType.none,
                        controller: value.dateController,
                        onTap: () async {
                          value.datePick(context);
                        },
                        decoration: InputDecoration(
                            hintText: value.selectedDate ?? "select date",
                            suffixIcon: Icon(
                              Icons.calendar_month_rounded,
                              size: 25,
                              color: kTextFieldColor,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: kMainColor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            isDense: true),
                      ),
                      kHeight(15),
                      const Text("Country"),
                      kHeight(5),
                      TextFormField(
                        controller: value.countryController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: kMainColor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            isDense: true),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your country";
                          } else {
                            return null;
                          }
                        },
                      ),
                      kHeight(15),
                      const Text("Company Address"),
                      kHeight(5),
                      TextFormField(
                          keyboardType: TextInputType.streetAddress,
                          controller: value.addressController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: kMainColor),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              isDense: true),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter Company address";
                            } else {
                              return null;
                            }
                          }),
                      kHeight(10),
                    ],
                  ),
                  SizedBox(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: kMainColor),
                      onPressed: () {},
                      child: const Text(
                        "Confirm",
                        style: TextStyle(fontSize: 17, color: kWhiteColor),
                      ),
                    ),
                  ),
                  kHeight(20)
                ],
              ),
            ),
          ),
        ));
  }
}
