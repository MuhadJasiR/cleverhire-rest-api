import 'package:cleverhire/core/color/color.dart';
import 'package:cleverhire/core/constraints/constraints.dart';

import 'package:cleverhire/recruiter/controller/provider/get_created_vacancy_provider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'job_details_screen.dart';
import 'widget/shimmer_explore_screen.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        final provider =
            Provider.of<GetCreatedVacancyProvider>(context, listen: false);
        await provider.fetchCreatedVacancies();
        provider.createdVacancy = provider.createdVacancies;
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer<GetCreatedVacancyProvider>(
          builder: (context, value, child) {
            return value.createdVacancy == null
                ? const Center(
                    child: Text(
                      "Certainly! Please take your time and check back with us later to see if any job vacancies have been created. We look forward to potentially working with you in the future!",
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView(
                    children: [
                      Column(
                        children: [
                          CupertinoSearchTextField(
                            style: const TextStyle(color: kWhiteColor),
                            itemSize: 25,
                            itemColor: kMainColor,
                            onChanged: (searchQuery) {
                              value.runFilter(searchQuery);
                            },
                          ),
                          kHeight(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Job Recommendation",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Saved jobs",
                                    style: TextStyle(color: kMainColor),
                                  ))
                            ],
                          ),
                          kHeight(10),
                          value.isLoading
                              ? ShimmerExploreScreen(
                                  icons: const Icon(Icons.bookmark),
                                )
                              : value.createdVacancy == null
                                  ? const SizedBox()
                                  : ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (context, index) => GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              JobDetailsAndApply(
                                                                index2: index,
                                                              )));
                                                },
                                                child: Consumer<
                                                    GetCreatedVacancyProvider>(
                                                  builder:
                                                      (context, value, child) =>
                                                          SizedBox(
                                                    height: 130,
                                                    // width: 340,
                                                    child: Card(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          // kWidth(10),
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            child:
                                                                Image.network(
                                                              "https://pbs.twimg.com/profile_images/1493919551553167360/XIoPFoOK_400x400.jpg",
                                                              height: 90,
                                                            ),
                                                          ),
                                                          // kWidth(10),
                                                          SizedBox(
                                                            width: 200,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          SizedBox(
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            Text(
                                                                          value
                                                                              .createdVacancy![index]
                                                                              .position,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: const TextStyle(
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      value
                                                                          .createdVacancy![
                                                                              index]
                                                                          .company!
                                                                          .companyName,
                                                                    )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                        "${value.createdVacancies![index].locationType} ",
                                                                        style: const TextStyle(
                                                                            color:
                                                                                kMainColor)),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          IconButton(
                                                              onPressed: () {},
                                                              icon: const Icon(
                                                                Icons
                                                                    .bookmark_border_outlined,
                                                                color:
                                                                    kMainColor,
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      separatorBuilder: (context, index) =>
                                          kHeight(5),
                                      itemCount: value.createdVacancy!.length)
                        ],
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }
}
