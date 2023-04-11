import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecruiterChatScreen extends StatelessWidget {
  const RecruiterChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => GestureDetector(
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              child: Image.asset(
                                "assets/profile.png",
                              ),
                            ),
                            title: const Text("Jasir"),
                            subtitle: const Text("FLutter developer"),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Text(
                                  "2:40 PM",
                                  style: TextStyle(fontSize: 12),
                                ),
                                CircleAvatar(
                                  radius: 10,
                                  child: Center(
                                      child: Text(
                                    "2",
                                    style: TextStyle(fontSize: 10),
                                  )),
                                )
                              ],
                            ),
                          ),
                        ),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: 5)
              ],
            )
          ]),
        ));
  }
}
