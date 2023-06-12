import 'package:cleverhire/job_seeker/controller/provider/get_seeker_details_provider.dart';
import 'package:cleverhire/recruiter/view/profile/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

import '../../../authentication/view/sign_in_screen.dart';
import '../../../core/color/color.dart';
import '../../../core/constraints/constraints.dart';

import 'package:cleverhire/job_seeker/controller/provider/local_functions_provider.dart';
import 'package:cleverhire/job_seeker/controller/provider/seeker_login_provider.dart';

import 'package:provider/provider.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({super.key});
  final FlutterSecureStorage signInStorage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        final getSeekerDetails =
            Provider.of<GetSeekerDetailsProvider>(context, listen: false);
        final createSeekerLogin =
            Provider.of<SeekerLoginProvider>(context, listen: false);

        await getSeekerDetails.fetchSeekerDetails();

        DateTime dateTime = getSeekerDetails.seekerDetails!.profile.dateOfBirth;
        String dateTimes = DateFormat('yyy-MM-dd').format(dateTime);
        createSeekerLogin.selectedDate = dateTimes;
        createSeekerLogin.addressController = TextEditingController(
            text: getSeekerDetails.seekerDetails!.profile.address);
        createSeekerLogin.occupationController =
            TextEditingController(text: getSeekerDetails.seekerDetails!.email);
        createSeekerLogin.userName = TextEditingController(
            text: getSeekerDetails.seekerDetails!.username);
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingsScreen()));
                // showDialog(
                //   context: context,
                //   builder: (ctx) => AlertDialog(
                //     title: const Text(
                //       "Alert!",
                //       style: TextStyle(color: Colors.red),
                //     ),
                //     content: const Text("Are to sure to sign out"),
                //     actions: [
                //       TextButton(
                //           onPressed: () {
                //             Navigator.pop(context);
                //           },
                //           child: const Text("No")),
                //       TextButton(
                //           onPressed: () {
                //             signInStorage.delete(key: "access_token");
                //             Navigator.of(context).pushAndRemoveUntil(
                //                 MaterialPageRoute(
                //                     builder: (context) => const SignInScreen()),
                //                 (route) => false);
                //           },
                //           child: const Text(
                //             "Yes",
                //             style: TextStyle(color: Colors.red),
                //           ))
                //     ],
                //   ),
                // );
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: SizedBox(
        child: Consumer<GetSeekerDetailsProvider>(
          builder: (context, value, child) {
            return value.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child:
                        Consumer2<LocalFunctionProvider, SeekerLoginProvider>(
                      builder: (context, provider1, provider, child) {
                        return SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              kHeight(20),
                              CircleAvatar(
                                radius: 70,
                                backgroundColor: kMainColor,
                                child: ClipOval(
                                    child: value.seekerDetails == null
                                        ? const SizedBox()
                                        : Image.network(
                                            value.seekerDetails!.profile
                                                .profileImage,
                                            width: 150,
                                            height: 150,
                                            fit: BoxFit.cover,
                                          )),
                              ),
                              kHeight(15),
                              // const Text("Upload profile photo"),
                              kHeight(10),
                              SizedBox(
                                height: size.height / 2,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    kHeight(15),
                                    const Text("user name"),
                                    kHeight(5),
                                    TextFormField(
                                      keyboardType: TextInputType.none,
                                      controller: provider.userName,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: kMainColor),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          isDense: true),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter email";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
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
                                          hintText: provider.selectedDate ??
                                              "select date",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: kMainColor),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          isDense: true),
                                    ),
                                    kHeight(15),
                                    const Text("address"),
                                    kHeight(5),
                                    TextFormField(
                                      keyboardType: TextInputType.none,
                                      controller: provider.addressController,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: kMainColor),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                    const Text("Email"),
                                    kHeight(5),
                                    TextFormField(
                                      keyboardType: TextInputType.none,
                                      controller: provider.occupationController,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: kMainColor),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
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
                                          return "Please enter email";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              // Consumer<UpdateSeekerDetailsProvider>(
                              //   builder: (context, value, child) => SizedBox(
                              //     width: 200,
                              //     height: 50,
                              //     child: ElevatedButton(
                              //       style: ElevatedButton.styleFrom(
                              //           backgroundColor: kMainColor),
                              //       onPressed: () async {},
                              //       child: const Text(
                              //         "Update",
                              //         style: TextStyle(
                              //             fontSize: 17, color: kWhiteColor),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              kHeight(20)
                            ],
                          ),
                        );
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}
