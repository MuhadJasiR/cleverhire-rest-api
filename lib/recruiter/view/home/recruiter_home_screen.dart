import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cleverhire/core/color/color.dart';
import 'package:cleverhire/core/constraints/constraints.dart';
import 'package:cleverhire/recruiter/controller/provider/get_applied_people_provider.dart';
import 'package:cleverhire/recruiter/controller/provider/get_created_vacancy_provider.dart';
import 'package:cleverhire/recruiter/view/home/widget/job_vacancies_card.dart';
import 'package:cleverhire/recruiter/view/home/widget/shimmer_loading.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widget/applied_people_card.dart';
import 'widget/shimmer_home_screen.dart';

class RecruiterHomeScreen extends StatelessWidget {
  const RecruiterHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<GetCreatedVacancyProvider>(context, listen: false);
    final provider2 =
        Provider.of<GetAppliedPeoplesProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await provider.fetchCreatedVacancies();
      await provider2.fetchingAppliedPeople(provider.createdVacancies![0].id);
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Home"),
      ),
      body: Consumer2<GetCreatedVacancyProvider, GetAppliedPeoplesProvider>(
        builder: (context, value, value2, child) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: value.createdVacancies == null
              ? const SizedBox()
              : value.createdVacancies!.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "assets/recruiter-hiring.gif",
                            height: 200,
                          ),
                        ),
                        kHeight(10),
                        const Text(
                          "Creating a job vacancy and hiring people can be a life-changing experience that provides an opportunity for individuals to improve their lives and contribute to society.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        kHeight(10),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Create vacancy"),
                            Icon(Icons.arrow_right_alt_rounded),
                          ],
                        )
                      ],
                    )
                  : ListView(
                      children: [
                        kHeight(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "My Vacancies",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {}, child: const Text("See all"))
                          ],
                        ),
                        value.isLoading
                            ? const ShimmerRecruiterPage()
                            : value.createdVacancies == null
                                ? const Text("create a vacancy")
                                : CarouselSlider.builder(
                                    carouselController: CarouselController(),
                                    itemBuilder: ((context, index, realIndex) =>
                                        JobVacanciesCard(
                                          index1: index,
                                        )),
                                    itemCount:
                                        provider.createdVacancies!.length,
                                    options: CarouselOptions(
                                      enableInfiniteScroll: false,
                                      autoPlay: false,
                                      enlargeCenterPage: true,
                                      aspectRatio: 2.7,
                                      viewportFraction: 0.83,
                                      enlargeFactor: 0.25,
                                      onPageChanged: (index, reason) {
                                        value.indexId = index;

                                        // ignore: invalid_use_of_protected_member
                                        value.notifyListeners();
                                        value2.fetchingAppliedPeople(value
                                            .createdVacancies![value.indexId!]
                                            .id);
                                        log("::::::::::${value.indexId.toString()}");
                                      },
                                    ),
                                  ),
                        kHeight(20),
                        Row(
                          children: const [
                            Text(
                              "Recently applied people",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        kHeight(10),
                        value2.isLoading
                            ? ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 3,
                                separatorBuilder: (context, index) =>
                                    kHeight(10),
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    const ShimmerLoading())
                            : value2.appliedPeoples!.isEmpty
                                ? Column(
                                    children: [
                                      kHeight(40),
                                      Image.asset(
                                        "assets/asdfghj.gif",
                                        height: 200,
                                      ),
                                      const Text(
                                        "No one applied for this vacancy...",
                                        style: TextStyle(color: kMainColor),
                                      )
                                    ],
                                  )
                                : value2.appliedPeoples == null
                                    ? const SizedBox()
                                    : ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            value2.appliedPeoples!.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) =>
                                            AppliedPeopleCard(
                                          index: index,
                                        ),
                                      ),
                      ],
                    ),
        ),
      ),
    );
  }
}
