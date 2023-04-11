import 'package:cleverhire/job_seeker/controller/provider/local_functions_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewResumeScreen extends StatelessWidget {
  const ViewResumeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resume"),
      ),
      body: SizedBox(
        child: Consumer<LocalFunctionProvider>(
            builder: (context, value, child) =>
                SfPdfViewer.file(value.pdfFile!)),
      ),
    );
  }
}
