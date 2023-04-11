import 'package:cleverhire/core/color/color.dart';
import 'package:cleverhire/core/constraints/constraints.dart';
import 'package:cleverhire/job_seeker/controller/provider/local_functions_provider.dart';
import 'package:cleverhire/job_seeker/controller/provider/seeker_login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobSeekerProfile extends StatelessWidget {
  JobSeekerProfile({super.key});

  final validateKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: validateKey,
          child: Consumer2<LocalFunctionProvider, SeekerLoginProvider>(
            builder: (context, provider1, provider, child) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: kMainColor,
                  child: GestureDetector(
                    onTap: () {
                      provider1.pickImage();
                    },
                    child: ClipOval(
                        child: provider1.imageFromGallery == null
                            ? Image.asset("assets/profile.png")
                            : Image.file(
                                provider1.imageFromGallery!,
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              )),
                  ),
                ),
                kHeight(15),
                const Text("Upload profile photo"),
                kHeight(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kHeight(15),
                    const Text("Date of birth"),
                    kHeight(5),
                    TextFormField(
                      keyboardType: TextInputType.none,
                      // controller: value.dateController,
                      onTap: () async {
                        provider.datePick(context);
                      },
                      decoration: InputDecoration(
                          hintText: provider.selectedDate ?? "select date",
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
                    const Text("address"),
                    kHeight(5),
                    TextFormField(
                      controller: provider.addressController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: kMainColor),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          isDense: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter address";
                        } else {
                          return null;
                        }
                      },
                    ),
                    kHeight(15),
                    const Text("Occupation"),
                    kHeight(5),
                    TextFormField(
                      controller: provider.occupationController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: kMainColor),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          isDense: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter occupation";
                        } else {
                          return null;
                        }
                      },
                    ),
                    kHeight(20),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: kMainColor),
                    onPressed: () {
                      if (validateKey.currentState!.validate()) {
                        provider.seekerLogin(context);
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
    );
  }
}
