import 'dart:developer';

import 'package:cleverhire/core/color/color.dart';
import 'package:cleverhire/core/constraints/constraints.dart';
import 'package:cleverhire/job_seeker/controller/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../core/api/api_config.dart';
import '../../../job_seeker/model/chat_model.dart';

class RecruiterMessageScreen extends StatefulWidget {
  const RecruiterMessageScreen({super.key, required this.usersId});

  final String usersId;

  @override
  State<RecruiterMessageScreen> createState() => _RecruiterMessageScreenState();
}

IO.Socket? socket;

class _RecruiterMessageScreenState extends State<RecruiterMessageScreen> {
  final List<Message> message = [
    Message(
        text: "hy",
        date: DateTime.now().subtract(const Duration(minutes: 1)),
        isSentByMe: false),
    Message(
        text: "Hello",
        date: DateTime.now().subtract(const Duration(minutes: 1)),
        isSentByMe: true),
    Message(
        text: "how are you",
        date: DateTime.now().subtract(const Duration(minutes: 1)),
        isSentByMe: false),
    Message(
        text: "Fine good",
        date: DateTime.now().subtract(const Duration(minutes: 1)),
        isSentByMe: true),
  ];
  @override
  void initState() {
    // Provider.of<ChatProvider>(context, listen: false)
    //     .connect("642519e0643d6f0ca5803823");
    // connect("64251a42643d6f0ca5803829");
    connect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              child: Image.asset(
                "assets/profile.png",
              ),
            ),
            kWidth(10),
            Column(
              children: const [
                Text(
                  "Jasir",
                ),
                Text(
                  "Online",
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Expanded(
                child: GroupedListView<Message, DateTime>(
              elements: message,
              reverse: true,
              order: GroupedListOrder.DESC,
              floatingHeader: true,
              groupBy: (message) => DateTime(
                message.date.year,
                message.date.month,
                message.date.day,
              ),
              groupHeaderBuilder: (Message message) => SizedBox(
                height: 35,
                child: Center(
                  child: Text(DateFormat.yMMMd().format(message.date)),
                ),
              ),
              itemBuilder: (context, Message message) => Align(
                alignment: message.isSentByMe
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  decoration: message.isSentByMe
                      ? BoxDecoration(
                          color: Colors.green[500],
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)))
                      : const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(message.text),
                  ),
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextField(
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.send,
                          color: Colors.green[500],
                        )),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    contentPadding: const EdgeInsets.all(12),
                    hintText: "Type something here"),
                onSubmitted: (value) {
                  final messages = Message(
                      text: value, date: DateTime.now(), isSentByMe: true);

                  setState(() {
                    message.add(messages);
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    socket!.dispose();
    super.dispose();
  }

  // void connect(String userId) {
  //   List<ChatModel>? chatModelList;
  //   String baseUrl = ApiConfig.baseUrl;

  //   log(baseUrl);
  //   socket = IO.io(baseUrl, <String, dynamic>{
  //     "transports": ["websocket"],
  //     "autoConnect": false,
  //   });
  //   socket!.connect();
  //   // setState(() {
  //   socket!.onConnect((data) {
  //     log("connected...$data");
  //     // });
  //   });
  //   socket!.onConnectError(
  //       (data) => log(data.toString(), name: 'onConnectionError'));
  //   socket!.onError((data) {
  //     log(data.toString(), name: "onError");
  //   });
  // }
}

void connect() {
  String baseUrl = ApiConfig.baseUrl;
  socket = IO.io(baseUrl, <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false,
  });
  socket!.connect();
  log("connected");
  socket!.emit("send-message", "642519e0643d6f0ca5803823");
  socket!.on("receive-message", (data) {
    log("Emitted");
    SentChatModel model =
        SentChatModel(message: data, receiverId: "642519e0643d6f0ca5803823");
  });
}

class Message {
  Message({required this.text, required this.date, required this.isSentByMe});
  String text;
  DateTime date;
  bool isSentByMe = false;
}
