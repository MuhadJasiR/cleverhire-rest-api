import 'package:cleverhire/core/constraints/constraints.dart';
import 'package:cleverhire/job_seeker/view/Explore/widget/shimmer_explore_screen.dart';
import 'package:cleverhire/recruiter/controller/api_services/delete_vacancy_services.dart';
import 'package:cleverhire/recruiter/controller/provider/get_created_vacancy_provider.dart';
import 'package:cleverhire/recruiter/view/application/create_new_vacancy.dart';
import 'package:cleverhire/recruiter/view/home/recruiter_bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecruiterApplicationScreen extends StatelessWidget {
  const RecruiterApplicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<GetCreatedVacancyProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.fetchCreatedVacancies();
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Application"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer<GetCreatedVacancyProvider>(
            builder: (context, value, child) {
          if (value.createdVacancies!.isEmpty) {
            return Column(
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
                )
              ],
            );
          } else {
            return ListView(
              children: [
                Column(
                  children: [
                    CupertinoSearchTextField(
                      onChanged: (searchQuery) {
                        value.runFilter(searchQuery);
                      },
                    ),
                    kHeight(20),
                    value.isLoading
                        ? Center(
                            child: ShimmerExploreScreen(
                              icons: const Icon(Icons.clear),
                            ),
                          )
                        : value.createdVacancy == null
                            ? const SizedBox()
                            : ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) => SizedBox(
                                      height: 130,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CreateNewVacancyAndUpdateScreen(
                                                        vacancyId: value
                                                            .createdVacancy![
                                                                index]
                                                            .id,
                                                        index: index,
                                                      )));
                                        },
                                        child: Card(
                                          child: Center(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.network(
                                                  "https://static.vecteezy.com/system/resources/previews/004/263/114/original/meta-logo-meta-by-facebook-icon-editorial-logo-for-social-media-free-vector.jpg",
                                                  height: 90,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 200,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            value
                                                                .createdVacancy![
                                                                    index]
                                                                .position,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          value
                                                              .createdVacancy![
                                                                  index]
                                                              .company!
                                                              .companyName,
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (ctx) =>
                                                                AlertDialog(
                                                                  content:
                                                                      const Text(
                                                                          "Are you sure to delete"),
                                                                  title:
                                                                      const Text(
                                                                    "Confirm..!",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red),
                                                                  ),
                                                                  actions: [
                                                                    TextButton(
                                                                        onPressed:
                                                                            () async {
                                                                          await DeleteJobVacancyApiServices().deleteJobVacancy(value
                                                                              .createdVacancy![index]
                                                                              .id);
                                                                          value
                                                                              .fetchCreatedVacancies();

                                                                          // ignore: use_build_context_synchronously
                                                                          Navigator.of(context)
                                                                              .pushReplacement(
                                                                            MaterialPageRoute(builder: (context) => RecruiterBottomNavigation()),
                                                                          );
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          "Yes",
                                                                          style:
                                                                              TextStyle(color: Colors.red),
                                                                        )),
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: const Text(
                                                                            "No"))
                                                                  ],
                                                                ));
                                                  },
                                                  icon: const Icon(
                                                    Icons
                                                        .delete_outline_rounded,
                                                    color: Colors.red,
                                                  ))
                                            ],
                                          )),
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
          }
        }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CreateNewVacancyAndUpdateScreen()));
        },
        icon: const Icon(Icons.add_to_photos_rounded),
        label: const Text("Create new vacancy"),
      ),
    );
  }
}
