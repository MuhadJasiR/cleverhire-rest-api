// ignore_for_file: invalid_use_of_visible_for_testing_member, use_build_context_synchronously, must_be_immutable, invalid_use_of_protected_member

import 'package:cleverhire/recruiter/controller/provider/create_vacancy_provider.dart';
import 'package:cleverhire/recruiter/controller/provider/update_vacancy_provider.dart';
import 'package:cleverhire/recruiter/view/home/recruiter_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/color/color.dart';
import '../../../core/constraints/constraints.dart';
import '../../controller/provider/get_created_vacancy_provider.dart';

List<String> jobType = ["full-time", "part-time", "freelance"];
List<String> locationType = ["onsite", "remote", "hybrid"];

class CreateNewVacancyAndUpdateScreen extends StatelessWidget {
  CreateNewVacancyAndUpdateScreen({super.key, this.vacancyId, this.index});

  final formkey = GlobalKey<FormState>();

  String? vacancyId;
  int? index;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final getProvider =
          Provider.of<GetCreatedVacancyProvider>(context, listen: false);
      final createProvider =
          Provider.of<CreateVacancyProvider>(context, listen: false);
      if (vacancyId != null) {
        getProvider.fetchCreatedVacancies();

        createProvider.openPositionController = TextEditingController(
            text: getProvider.createdVacancies![index!].position);
        createProvider.salaryController = TextEditingController(
            text: "${getProvider.createdVacancies![index!].salary}");
        createProvider.selectedJobType =
            getProvider.createdVacancies![index!].type;

        createProvider.selectedLocationType =
            getProvider.createdVacancies![index!].locationType;
        createProvider.requirementsController = TextEditingController(
            text: getProvider.createdVacancies![index!].description);
      } else {
        createProvider.disposeTextField();
      }
    });
    return WillPopScope(
      onWillPop: () async {
        final shouldPopUP = await showMyDialog(context);
        return shouldPopUP ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(vacancyId != null ? "Update Vacancy" : "Create Vacancy"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Consumer3<CreateVacancyProvider, GetCreatedVacancyProvider,
                UpdateVacancyProvider>(
              builder: (context, value, value2, value3, child) => Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Open position"),
                    kHeight(5),
                    TextFormField(
                      controller: value.openPositionController,
                      decoration: InputDecoration(
                          hintText: "Name of the position",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: kMainColor),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          isDense: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter position";
                        } else {
                          return null;
                        }
                      },
                    ),
                    kHeight(15),
                    const Text("Salary"),
                    kHeight(5),
                    TextFormField(
                        controller: value.salaryController,
                        decoration: InputDecoration(
                            hintText: "Salary per month",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: kMainColor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            isDense: true),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter Salary";
                          } else {
                            return null;
                          }
                        }),
                    kHeight(15),
                    const Text("Location"),
                    kHeight(5),
                    SizedBox(
                      child: Center(
                        child: DropdownButtonFormField(
                          hint: const Text("Select Location type"),
                          isDense: true,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      const BorderSide(color: kMainColor)),
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: kMainColor),
                                  borderRadius: BorderRadius.circular(30))),
                          items: locationType
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (selectedLocation) {
                            value.selectedLocationType = selectedLocation;
                            value2.notifyListeners();
                          },
                          value: value.selectedLocationType,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please select location";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    kHeight(15),
                    const Text("Type"),
                    kHeight(5),
                    SizedBox(
                      child: Center(
                        child: DropdownButtonFormField(
                          hint: const Text("Select job type"),
                          isDense: true,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      const BorderSide(color: kMainColor)),
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: kMainColor),
                                  borderRadius: BorderRadius.circular(30))),
                          items: jobType
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (selectedJob) {
                            value.selectedJobType = selectedJob;
                          },
                          value: value.selectedJobType,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please select job type";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    kHeight(15),
                    const Text("Requirements"),
                    kHeight(10),
                    SizedBox(
                      child: TextFormField(
                          controller: value.requirementsController,
                          minLines: 5,
                          maxLines: 5,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: kMainColor)),
                              hintText: "add your requirements "),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter requirements";
                            } else {
                              return null;
                            }
                          }),
                    ),
                    kHeight(40),
                    Center(
                      child: SizedBox(
                        width: 200,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kMainColor),
                            onPressed: () async {
                              if (vacancyId != null) {
                                await value3.updateVacancyProvider(
                                    vacancyId!, context);
                                Navigator.pop(context);
                              } else {
                                if (formkey.currentState!.validate()) {
                                  await value.createVacancy();

                                  value.notifyListeners();
                                  value.disposeTextField();
                                  await value2.fetchCreatedVacancies();
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RecruiterBottomNavigation()));
                                }
                              }
                            },
                            child: Text(
                              vacancyId == null
                                  ? "Post job vacancy"
                                  : "Update vacancy",
                              style: const TextStyle(color: kWhiteColor),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> showMyDialog(context) => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text(
              "Discard Changes?",
              style: TextStyle(fontSize: 19),
            ),
            content: const Text("Your changes are not saved"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text("No")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text("Yes"))
            ],
          ));
}
