import 'dart:developer';

import 'package:cleverhire/core/color/color.dart';
import 'package:cleverhire/core/constraints/constraints.dart';
import 'package:cleverhire/job_seeker/controller/firebase/storage_services.dart';
import 'package:cleverhire/job_seeker/controller/provider/applying_for_vacancy_provider.dart';
import 'package:cleverhire/job_seeker/controller/provider/local_functions_provider.dart';
import 'package:cleverhire/job_seeker/view/Explore/view_resume.dart';
import 'package:cleverhire/recruiter/controller/provider/get_created_vacancy_provider.dart';

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import '../home/bottom_navigation_screen.dart';

class ResumeUpload extends StatelessWidget {
  const ResumeUpload({super.key, required this.index4});

  final int index4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Job Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer3<LocalFunctionProvider, GetCreatedVacancyProvider,
            FirebaseStorageProvider>(
          builder: (context, value, value2, value3, child) => Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          "https://pbs.twimg.com/profile_images/1493919551553167360/XIoPFoOK_400x400.jpg",
                          height: 90,
                        ),
                      ),
                      kWidth(15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value2.createdVacancies![index4].position,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text("${value2.createdVacancies![index4].company}")
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              kHeight(5),
              Row(
                children: const [
                  Text(
                    "Upload Resume/CV",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              kHeight(10),
              Row(
                children: const [
                  Text(
                      "Upload your CV or Resume to apply for the job vacancy."),
                ],
              ),
              kHeight(20),
              value.pdfFile != null
                  ? GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ViewResumeScreen()));
                      },
                      child: Card(
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/pdf_Icon_logo.png",
                                height: 50,
                              ),
                              Expanded(
                                child: Text(
                                  "${value.pdfName}",
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                              title: const Text(
                                                "Alert!",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              content: const Text(
                                                  "Are to sure to delete"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("No")),
                                                TextButton(
                                                    onPressed: () async {
                                                      await Provider.of<
                                                                  FirebaseStorageProvider>(
                                                              context,
                                                              listen: false)
                                                          .deleteFileFromFirebase(
                                                              value3.downloadUrl
                                                                  .toString());
                                                      // ignore: use_build_context_synchronously
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const ResumeUpload(
                                                                      index4:
                                                                          0)));
                                                    },
                                                    child: const Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ))
                                              ],
                                            ));
                                  },
                                  icon: const Icon(Icons.clear_outlined))
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              kHeight(15),
              GestureDetector(
                onTap: () async {
                  value.pickFile(context);
                },
                child: const Card(
                  child: SizedBox(
                    height: 180,
                    child: Center(
                      child: CircleAvatar(
                        radius: 40,
                        child: Icon(
                          Icons.cloud_upload_rounded,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: kMainColor),
                      onPressed: () {
                        if (value.pdfFile != null) {
                          final provider =
                              Provider.of<ApplyingForVacancyProvider>(context,
                                  listen: false);
                          provider.applyingForVacancy(
                              context, value2.createdVacancies![index4].id);
                          log("Checking the id is changing or not ${value2.createdVacancies![index4].id}");
                          provider.isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BottomNavigation()));
                          toast("Success");
                        } else {
                          showSimpleNotification(
                              const Text(
                                "Upload your Resume!",
                                style: TextStyle(color: kWhiteColor),
                              ),
                              background: Colors.red);
                        }
                      },
                      child: const Text(
                        "Apply",
                        style: TextStyle(fontSize: 18, color: kWhiteColor),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
