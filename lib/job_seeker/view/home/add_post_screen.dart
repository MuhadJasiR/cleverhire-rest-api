// ignore_for_file: use_build_context_synchronously

import 'package:cleverhire/core/color/color.dart';
import 'package:cleverhire/core/constraints/constraints.dart';
import 'package:cleverhire/job_seeker/controller/provider/get_uploaded_post_provider.dart';
import 'package:cleverhire/job_seeker/controller/provider/local_functions_provider.dart';
import 'package:cleverhire/job_seeker/controller/provider/upload_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          Consumer3<UploadImageProvider, LocalFunctionProvider,
              GetUploadedPostProvider>(
            builder: (context, value, value2, value3, child) => ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() &&
                      value2.imageFromGallery != null) {
                    await value.uploadImageProviderFunction(context);
                    value.notifyListeners();
                    await value3.fetchUploadedPost();
                    toast("success");
                    value.disposeTextField(context);
                    Navigator.pop(context);
                  } else {
                    showSimpleNotification(
                        const Text(
                          "Please select an image!",
                          style: TextStyle(color: kWhiteColor),
                        ),
                        background: Colors.red);
                  }
                },
                child: const Text("Post")),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer3<LocalFunctionProvider, UploadImageProvider,
            GetUploadedPostProvider>(
          builder: (context, value, value2, value3, child) => Column(
            children: [
              Row(
                children: [
                  kWidth(5),
                  CircleAvatar(child: Image.asset("assets/profile.png")),
                  kWidth(10),
                  const Text(
                    "Jasir ali",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )
                ],
              ),
              kHeight(15),
              Form(
                key: _formKey,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: value2.descriptionController,
                      minLines: 7,
                      maxLines: 7,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "What you want to talk about?"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please add any description";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
              ),
              kHeight(10),
              value.imageFromGallery != null
                  ? Card(
                      child: SizedBox(
                        height: size.height / 3,
                        width: size.width,
                        child: Image.file(
                          value.imageFromGallery!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : const SizedBox(),
              kHeight(10),
              ElevatedButton.icon(
                  onPressed: () {
                    value.pickImage();
                  },
                  icon: const Icon(Icons.photo_size_select_actual_rounded),
                  label: value3.isLoading || value2.isLoading
                      ? LoadingAnimationWidget.waveDots(
                          color: kMainColor, size: 35)
                      : Text(value.imageFromGallery != null
                          ? "Change image"
                          : "add image"))
            ],
          ),
        ),
      ),
    );
  }
}
