import 'package:cleverhire/job_seeker/controller/provider/get_seeker_details_provider.dart';
import 'package:cleverhire/job_seeker/controller/provider/update_seeker_details_provider.dart';
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
                                    builder: (context) => const SignInScreen()),
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
      body: SizedBox(
        child: Consumer<GetSeekerDetailsProvider>(
          builder: (context, value, child) {
            return value.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child:
                        Consumer2<LocalFunctionProvider, SeekerLoginProvider>(
                      builder: (context, provider1, provider, child) {
                        return Column(
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
                                    child: value.seekerDetails == null
                                        ? SizedBox()
                                        : Image.network(
                                            value.seekerDetails!.profile
                                                .profileImage,
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
                                      hintText: provider.selectedDate ??
                                          "select date",
                                      suffixIcon: Icon(
                                        Icons.calendar_month_rounded,
                                        size: 25,
                                        color: kTextFieldColor,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: kMainColor),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      isDense: true),
                                ),
                                kHeight(15),
                                const Text("address"),
                                kHeight(5),
                                TextFormField(
                                  controller: provider.addressController,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: kMainColor),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
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
                                        borderSide:
                                            const BorderSide(color: kMainColor),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
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
                            Consumer<UpdateSeekerDetailsProvider>(
                              builder: (context, value, child) => SizedBox(
                                width: 200,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: kMainColor),
                                  onPressed: () async {
                                    await value
                                        .updateSeekerDetailsProvider(context);
                                  },
                                  child: const Text(
                                    "Update",
                                    style: TextStyle(
                                        fontSize: 17, color: kWhiteColor),
                                  ),
                                ),
                              ),
                            ),
                            kHeight(20)
                          ],
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
