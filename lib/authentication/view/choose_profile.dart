import 'package:cleverhire/job_seeker/view/profile/job_seeker_profile.dart';
import 'package:cleverhire/recruiter/view/profile/recruiter_profile.dart';
import 'package:flutter/material.dart';

import '../../core/color/color.dart';

class ChooseProfile extends StatelessWidget {
  const ChooseProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Choose your role",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 150,
                child: Image(
                    image: AssetImage(
                  'assets/jobSeeker.png',
                )),
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: kMainColor),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => JobSeekerProfile()));
                  },
                  child: const Text(
                    "I am Job Seeker",
                    style: TextStyle(fontSize: 17, color: kWhiteColor),
                  ),
                ),
              ),
              Row(
                children: const [
                  Expanded(
                      child: Divider(
                    thickness: 2,
                  )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("or"),
                  ),
                  Expanded(
                      child: Divider(
                    thickness: 2,
                  )),
                ],
              ),
              const SizedBox(
                height: 150,
                child: Image(
                    image: AssetImage(
                  'assets/recruiter.png',
                )),
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: kMainColor),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RecruiterProfile()));
                  },
                  child: const Text(
                    "I am Recruiter",
                    style: TextStyle(fontSize: 17, color: kWhiteColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
