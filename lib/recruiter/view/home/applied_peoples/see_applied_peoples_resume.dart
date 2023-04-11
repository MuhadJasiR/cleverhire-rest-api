import 'package:cleverhire/recruiter/controller/provider/get_applied_people_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// ignore: must_be_immutable
class ViewAppliedPeopleResumeScreen extends StatelessWidget {
  ViewAppliedPeopleResumeScreen({super.key, required this.index});

  int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resume"),
      ),
      body: SizedBox(
        child: Consumer<GetAppliedPeoplesProvider>(
            builder: (context, value, child) =>
                SfPdfViewer.network(value.appliedPeoples![index].resume)),
      ),
    );
  }
}
