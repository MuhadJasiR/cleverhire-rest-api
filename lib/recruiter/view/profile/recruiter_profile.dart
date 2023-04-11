import 'dart:developer';

import 'package:cleverhire/recruiter/controller/provider/company_login_provider.dart';
import 'package:cleverhire/recruiter/controller/provider/local_functions_recruiter.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/color/color.dart';
import '../../../core/constraints/constraints.dart';
import '../home/recruiter_bottom_navigation.dart';

class RecruiterProfile extends StatelessWidget {
  RecruiterProfile({super.key});

  final userRecruiterKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalFunctionsRecruiter>(context);
    // final provider2 = Provider.of<CompanyLoginProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Form(
            key: userRecruiterKey,
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
                            child: provider.image == null
                                ? Image.asset("assets/BeFunky-collage.jpg")
                                : Image.file(
                                    provider.image!,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  )),
                      ),
                      Positioned(
                          bottom: -13,
                          right: -12,
                          child: IconButton(
                              onPressed: () {
                                provider.imagePickingRecruiter();
                              },
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
                        validator: (email) {
                          bool validatedEmail = validateEmail(email);
                          if (email == null || email.isEmpty) {
                            return "Please Enter Email";
                          } else if (validatedEmail == false) {
                            return "Enter valid Email";
                          } else {
                            return null;
                          }
                        },
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
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return "Please select date";
                        //   } else {
                        //     return null;
                        //   }
                        // },
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
                      kHeight(20),
                    ],
                  ),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: kMainColor),
                      onPressed: () {
                        if (userRecruiterKey.currentState!.validate()) {
                          final result = value.companyLogin();
                          log(result.toString());
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RecruiterBottomNavigation()),
                              (route) => false);
                        }
                      },
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
        ),
      ),
    );
  }

  // String parseDate(DateTime date) {
  //   // return DateFormat("yyy");
  // }

  bool validateEmail(String? email) {
    bool emailResult = EmailValidator.validate(email.toString());
    return emailResult;
  }
}
