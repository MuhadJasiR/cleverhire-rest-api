import 'package:cleverhire/core/color/color.dart';
import 'package:cleverhire/core/constraints/constraints.dart';
import 'package:cleverhire/job_seeker/controller/provider/get_applied_jobs_provider.dart';

import 'package:cleverhire/job_seeker/view/applied_jobs/widget/applied_recruiter_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ViewAppliedJobsDetails extends StatelessWidget {
  ViewAppliedJobsDetails({
    super.key,
    required this.index2,
  });

  int index2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Applied Job details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Consumer<GetAppliedJobsProvider>(
          builder: (context, value, child) => Column(
            children: [
              Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                            value.appliedJobs![index2].jobId!.position,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const Text("IBM")
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const Divider(),
              kHeight(20),
              AppliedRecruiterDetails(
                index3: index2,
              ),
              kHeight(20),
              const Divider(),
              kHeight(20),
              Row(
                children: const [
                  Text(
                    "Requirements",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              kHeight(20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      value.appliedJobs![index2].jobId!.description,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                  width: 200,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    label: const Text(
                      "Send Message ",
                      style: TextStyle(fontSize: 18, color: kWhiteColor),
                    ),
                    icon: const Icon(Icons.message),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
