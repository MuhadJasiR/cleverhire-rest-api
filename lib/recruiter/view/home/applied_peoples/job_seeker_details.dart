// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:cleverhire/core/color/color.dart';
import 'package:cleverhire/recruiter/controller/api_services/job_status_changing_services.dart';
import 'package:cleverhire/recruiter/controller/provider/get_all_chats_provider.dart';
import 'package:cleverhire/recruiter/controller/provider/get_applied_people_provider.dart';
import 'package:cleverhire/recruiter/view/chat/recruiter_message_screen.dart';
import 'package:cleverhire/recruiter/view/home/applied_peoples/see_applied_peoples_resume.dart';
import 'package:cleverhire/recruiter/view/home/widget/seeker_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

const List<String> seekerStatus = [
  "Pending",
  "Selected",
  "Scheduled for Interview",
  "Rejected",
];

class JobSeekerDetails extends StatelessWidget {
  JobSeekerDetails(
      {super.key, required this.index, required this.seekerDetailsId});

  int index;
  String? newRole;
  String seekerDetailsId;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      FlutterSecureStorage storage = const FlutterSecureStorage();
      final role = await storage.read(key: "role");
      newRole = role!.replaceAll('"', '');
      Provider.of<GetAppliedPeoplesProvider>(context);
    });
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Applicants"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Consumer2<GetAppliedPeoplesProvider, GetAllChatsProvider>(
          builder: (context, value, value2, child) => Card(
            child: SizedBox(
              height: height / 1.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        child: value.appliedPeoples == null ||
                                index >= value.appliedPeoples!.length ||
                                value.appliedPeoples![index].profile.isEmpty
                            ? Image.asset(
                                "assets/profile.png",
                              )
                            : CircleAvatar(
                                radius: 30,
                                backgroundImage: Image.network(
                                  value.appliedPeoples![index].profile[0]
                                      .profileImage,
                                ).image)),
                    title: Text(
                      value.appliedPeoples![index].appliedBy.username,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    subtitle: const Text("Flutter developer"),
                    trailing: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RecruiterMessageScreen(
                                  chatId: value2.chatId!,
                                  role: newRole!,
                                  index1: index,
                                  receiverId: newRole == "seeker"
                                      ? value2.recruiterChats[index].id
                                      : value2.filteredChats[index].id)));
                        },
                        icon: Icon(
                          Icons.chat,
                          color: kTextFieldColor,
                        )),
                  ),
                  const Divider(),
                  Expanded(
                    child: SeekerDetails(
                      seekerDetailsId: seekerDetailsId,
                      index: index,
                    ),
                  ),
                  SizedBox(
                      width: 250,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kMainColor),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ViewAppliedPeopleResumeScreen(
                                      index: index,
                                    )));
                          },
                          child: const Text("See Resume",
                              style: TextStyle(
                                  fontSize: 15, color: kWhiteColor)))),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: DropdownButtonFormField(
                          hint: const Text("Mark status as"),
                          isDense: true,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: kMainColor)),
                              isDense: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: kMainColor),
                              )),
                          items: seekerStatus
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (seekerStatus) async {
                            await JobStatusChangingApiServices()
                                .jobStatusChangingServices(
                                    value.appliedPeoples![index].id,
                                    seekerStatus)
                                .then((value) =>
                                    log("successfully changed status"));
                          },
                          value: value.appliedPeoples![index].status,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
