import 'package:cleverhire/core/color/color.dart';
import 'package:cleverhire/core/constraints/constraints.dart';
import 'package:cleverhire/job_seeker/controller/apiServices/delete_post_services.dart';
import 'package:cleverhire/job_seeker/controller/provider/get_uploaded_post_provider.dart';
import 'package:cleverhire/job_seeker/controller/provider/local_functions_provider.dart';
import 'package:cleverhire/job_seeker/view/home/add_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import 'comment_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<GetUploadedPostProvider>(context, listen: false)
          .fetchUploadedPost();
    });
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddPostScreen()));
              },
              icon: const Icon(Icons.add_to_photos)),
          kWidth(5)
        ],
        title: const Text("Home"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Consumer2<GetUploadedPostProvider, LocalFunctionProvider>(
        builder: (context, value, value2, child) {
          return value.uploadedPost == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  controller: ScrollController(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                      value.uploadedPost![index].user.username),
                                  subtitle: Text(
                                    DateFormat('MMMM d, y h:mm a').format(
                                        value.uploadedPost![index].createdAt),
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  leading: CircleAvatar(
                                      child: Image.asset("assets/profile.png")),
                                  trailing: IconButton(
                                      onPressed: () async {
                                        showDialog(
                                            context: context,
                                            builder: ((context) {
                                              return AlertDialog(
                                                title: const Text("Confirm!."),
                                                content: const Text(
                                                    "Are you sure to delete this post?.."),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text("No")),
                                                  TextButton(
                                                      onPressed: () async {
                                                        await DeletePostApiServices()
                                                            .deletePostServices(
                                                                value
                                                                    .uploadedPost![
                                                                        index]
                                                                    .id);

                                                        await value
                                                            .fetchUploadedPost();
                                                        // ignore: use_build_context_synchronously
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        "Yes",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ))
                                                ],
                                              );
                                            }));
                                      },
                                      icon:
                                          const Icon(Icons.clear_all_outlined)),
                                ),
                                // ignore: unnecessary_null_comparison
                                value.uploadedPost![index].image == null ||
                                        value.uploadedPost![index].image.isEmpty
                                    ? Image.network(
                                        "https://cdn.sanity.io/images/s7xbv9bz/production/1562d4dae8dc03456edca898e89c0f39ae086a8f-1600x1000.png",
                                        height: 300,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        value.uploadedPost![index].image,
                                        height: 300,
                                        fit: BoxFit.cover,
                                      ),
                                const Divider(),
                                SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ReadMoreText(
                                        value.uploadedPost![index].description,
                                        trimLines: 1,
                                        trimMode: TrimMode.Line,
                                        trimCollapsedText: "Show More",
                                        trimExpandedText: " Show Less",
                                        moreStyle:
                                            const TextStyle(color: kMainColor),
                                        lessStyle:
                                            const TextStyle(color: kMainColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    LikeButton(
                                      isLiked: value2.isLiked,
                                      likeCount: value2.likedCount,
                                      likeBuilder: (isLiked) => Icon(
                                        Icons.thumb_up_alt,
                                        color: isLiked ? kMainColor : null,
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const CommentScreen()));
                                        },
                                        icon: const Icon(Icons.chat_outlined)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.share_outlined))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => kHeight(5),
                  itemCount: value.uploadedPost!.length);
        },
      ),
    );
  }
}
