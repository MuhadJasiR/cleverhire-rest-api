import 'package:cleverhire/core/color/color.dart';
import 'package:cleverhire/core/constraints/constraints.dart';
import 'package:cleverhire/recruiter/controller/provider/get_all_chats_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'recruiter_message_screen.dart';

class RecruiterChatScreen extends StatelessWidget {
  const RecruiterChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Provider.of<GetAllChatsProvider>(context, listen: false)
            .fetchingAllChats();
      },
    );

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text("Chat Box"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(children: [
            Column(
              children: [
                const CupertinoSearchTextField(),
                kHeight(10),
                Consumer<GetAllChatsProvider>(builder: (context, value, child) {
                  return value.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RecruiterMessageScreen(
                                              chatId: value.chatId!,
                                            ))),
                                child: Card(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 30,
                                      child: Image.asset(
                                        "assets/profile.png",
                                      ),
                                    ),
                                    title: Text(
                                        value.filteredChats[index].username),
                                    subtitle: const Text("FLutter developer"),
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text(
                                          "2:40 PM",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        CircleAvatar(
                                          backgroundColor:
                                              kMainColor.withOpacity(0.8),
                                          radius: 10,
                                          child: const Center(
                                              child: Text(
                                            "2",
                                            style: TextStyle(fontSize: 10),
                                          )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          separatorBuilder: (context, index) => const Divider(
                                thickness: 0.3,
                              ),
                          itemCount: value.filteredChats.length);
                })
              ],
            )
          ]),
        ));
  }
}
