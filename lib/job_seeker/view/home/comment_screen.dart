import 'package:cleverhire/core/constraints/constraints.dart';
import 'package:cleverhire/job_seeker/controller/apiServices/comment_api_services.dart';
import 'package:cleverhire/job_seeker/controller/provider/get_uploaded_post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatelessWidget {
  CommentScreen({super.key, required this.index1});

  final TextEditingController commentController = TextEditingController();
  final int index1;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetUploadedPostProvider>(context, listen: false)
          .fetchUploadedPost();
    });
    return Scaffold(
        appBar: AppBar(
          title: const Text("Comment Page"),
        ),
        bottomNavigationBar: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                CircleAvatar(
                  child: Image.asset("assets/profile.png"),
                ),
                kWidth(10),
                Expanded(
                    child: TextFormField(
                  controller: commentController,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: "Write a comment..."),
                )),
                Consumer<GetUploadedPostProvider>(
                  builder: (context, value, child) => IconButton(
                      onPressed: () async {
                        CommentApiServices().commentApiServices(
                            value.uploadedPost![index1].id,
                            commentController.text.trim());

                        value.uploadedPost![index1].comments;
                        commentController.clear();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) =>
                                CommentScreen(index1: index1)));
                      },
                      icon: const Icon(Icons.send)),
                )
              ],
            ),
          ),
        ),
        body: Consumer<GetUploadedPostProvider>(
          builder: (context, value, child) => value.isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 0.3,
                  ),
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: value
                                  .uploadedPost![index1]
                                  .comments[index]
                                  .user
                                  .profile
                                  .profileImage
                                  .isNotEmpty
                              ? NetworkImage(value.uploadedPost![index1]
                                  .comments[index].user.profile.profileImage)
                              : const AssetImage("assets/profile.png")
                                  as ImageProvider<Object>),
                      title: Text(value
                          .uploadedPost![index1].comments[index].user.username),
                      subtitle: Text(
                          value.uploadedPost![index1].comments[index].comment),
                    );
                  },
                  itemCount: value.uploadedPost![index1].comments.length,
                ),
        ));
  }
}
