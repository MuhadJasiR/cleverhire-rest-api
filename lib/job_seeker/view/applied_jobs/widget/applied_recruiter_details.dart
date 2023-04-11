import 'package:cleverhire/core/color/color.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/provider/get_applied_jobs_provider.dart';

// ignore: must_be_immutable
class AppliedRecruiterDetails extends StatelessWidget {
  AppliedRecruiterDetails({super.key, required this.index3});

  int index3;

  @override
  Widget build(BuildContext context) {
    return Consumer<GetAppliedJobsProvider>(
      builder: (context, value, child) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Salary :",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text(
                "${value.appliedJobs![index3].jobId!.salary} /- Monthly",
                style: const TextStyle(color: kMainColor),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Type :",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text(
                value.appliedJobs![index3].jobId!.position,
                style: const TextStyle(color: kMainColor),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Location type:",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text(
                value.appliedJobs![index3].jobId!.locationType,
                style: const TextStyle(color: kMainColor),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Position :",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text(
                value.appliedJobs![index3].jobId!.position,
                style: const TextStyle(color: kMainColor),
              )
            ],
          ),
        ],
      ),
    );
  }
}
