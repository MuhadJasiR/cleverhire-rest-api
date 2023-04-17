import 'dart:developer';

import 'package:cleverhire/core/constraints/constraints.dart';

import 'package:cleverhire/job_seeker/model/get_chat_model.dart';
import 'package:cleverhire/recruiter/controller/provider/get_applied_people_provider.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../core/api/api_config.dart';

class RecruiterMessageScreen extends StatefulWidget {
  const RecruiterMessageScreen({super.key, required this.chatId});

  final String chatId;

  @override
  State<RecruiterMessageScreen> createState() => _RecruiterMessageScreenState();
}

IO.Socket? socket;
TextEditingController messageController = TextEditingController();

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

  void initSocket() {
    String baseUrl = ApiConfig.baseUrl;

    Map<String, dynamic> data = {
      "receiverId": "642cf3592eaa2a181bc2d0c1",
      "message": "hello",
    };

    socket = IO.io(baseUrl, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });

    socket!.onConnect((_) {
      log("connection established...");

      socket!.on("receive-message", (data) {
        log("received");
        log(data.toString());
        setState(() {
          GetChatModel model = GetChatModel(message: data);
        });
      });
    });

    socket!.onDisconnect((_) => log("connection disconnected"));
    socket?.onConnectError((err) => log(err.toString()));
    socket?.onError((err) => log(err.toString()));

    socket!.connect();
  }

  @override
  void initState() {
    initSocket();
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
                controller: messageController,
                decoration: InputDecoration(
                    suffixIcon: Consumer<GetAppliedPeoplesProvider>(
                      builder: (context, value, child) => IconButton(
                          onPressed: () {
                            String sendMessage = messageController.text.trim();
                            final messages = Message(
                                text: messageController.text.trim(),
                                date: DateTime.now(),
                                isSentByMe: true);
                            sentMessage(value.appliedPeoples![0].appliedBy.id,
                                sendMessage);
                            setState(() {
                              message.add(messages);
                            });
                          },
                          icon: Icon(
                            Icons.send,
                            color: Colors.green[500],
                          )),
                    ),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    contentPadding: const EdgeInsets.all(12),
                    hintText: "Type something here"),
                onSubmitted: (value) {},
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
}

sentMessage(String sentId, String message) {
  if (message.isEmpty) return;
  Map messageMap = {"receiverId": sentId, "message": message};
  socket!.emit("send-message", messageMap);
  messageController.clear();
}

getMessage() {
  socket!.on("receive-message", (data) {
    log("Emitted");
    GetChatModel model = GetChatModel(message: data);
  });
}

class Message {
  Message({required this.text, required this.date, required this.isSentByMe});
  String text;
  DateTime date;
  bool isSentByMe = false;
}
