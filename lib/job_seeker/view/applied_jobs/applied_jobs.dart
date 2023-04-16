import 'package:cleverhire/core/color/color.dart';
import 'package:cleverhire/core/constraints/constraints.dart';
import 'package:cleverhire/job_seeker/controller/provider/get_applied_jobs_provider.dart';
import 'package:cleverhire/job_seeker/view/applied_jobs/view_applied_jobs_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppliedJobs extends StatelessWidget {
  const AppliedJobs({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetAppliedJobsProvider>(context, listen: false)
          .fetchingAppliedJobs();
    });
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Applied Jobs"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Consumer<GetAppliedJobsProvider>(
          builder: (context, value, child) => value.appliedJobs == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : value.appliedJobs!.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/asdfghj.gif",
                            height: 200,
                          ),
                          const Text(
                            "No applied jobs found..",
                            style: TextStyle(color: kMainColor),
                          )
                        ],
                      ),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ViewAppliedJobsDetails(
                                        index2: index,
                                      ))),
                          child: SizedBox(
                            height: size.height / 5,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            "https://pbs.twimg.com/profile_images/1493919551553167360/XIoPFoOK_400x400.jpg",
                                            height: 90,
                                          ),
                                        ),
                                        kWidth(10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              value.appliedJobs![index].jobId!
                                                  .position,
                                              style: const TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Text(
                                              "IBM",
                                              style: TextStyle(
                                                color: kMainColor,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    kHeight(5),
                                    const Divider(),
                                    value.appliedJobs![index].status ==
                                            "Selected"
                                        ? Card(
                                            color: kMainColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 25),
                                              child: Text(
                                                value
                                                    .appliedJobs![index].status,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          )
                                        : value.appliedJobs![index].status ==
                                                "Rejected"
                                            ? Card(
                                                color: Colors.red,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 5,
                                                      horizontal: 25),
                                                  child: Text(
                                                    value.appliedJobs![index]
                                                        .status,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              )
                                            : value.appliedJobs![index]
                                                        .status ==
                                                    "Scheduled for Interview"
                                                ? Card(
                                                    color: Colors.blue,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 5,
                                                          horizontal: 25),
                                                      child: Text(
                                                        value
                                                            .appliedJobs![index]
                                                            .status,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  )
                                                : Card(
                                                    color: Colors.amber,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 5,
                                                          horizontal: 25),
                                                      child: Text(
                                                        value
                                                            .appliedJobs![index]
                                                            .status,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return kHeight(10);
                      },
                      itemCount: value.appliedJobs!.length),
        ),
      ),
    );
  }
}
