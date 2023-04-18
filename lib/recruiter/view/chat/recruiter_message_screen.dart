import 'dart:developer';

import 'package:cleverhire/core/constraints/constraints.dart';
import 'package:cleverhire/job_seeker/model/chat_res_model.dart';

import 'package:cleverhire/job_seeker/model/get_chat_model.dart';
import 'package:cleverhire/recruiter/controller/provider/get_all_chats_provider.dart';
import 'package:cleverhire/recruiter/controller/provider/get_applied_people_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../core/api/api_config.dart';

class RecruiterMessageScreen extends StatefulWidget {
  RecruiterMessageScreen(
      {super.key,
      required this.chatId,
      required this.role,
      required this.index1,
      required this.receiverId});

  final String chatId;
  final String role;
  List<ChatResModel>? chatMessage;
  final int index1;
  final String receiverId;

  @override
  State<RecruiterMessageScreen> createState() => _RecruiterMessageScreenState();
}

IO.Socket? socket;
TextEditingController messageController = TextEditingController();

class _RecruiterMessageScreenState extends State<RecruiterMessageScreen> {
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

  String? receiverId;

  @override
  Widget build(BuildContext context) {
    print('::::::::::::::::::::${widget.receiverId}');
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        FlutterSecureStorage storage = const FlutterSecureStorage();
        receiverId = await storage.read(key: "_id");
        initSocket();

        await Provider.of<GetAllChatsProvider>(context, listen: false)
            .fetchPersonalChatProvider(widget.chatId);
      },
    );
    log('dfolkwjedlfikjsldfjsldkfjl;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;${receiverId}');
    return Scaffold(
      appBar: AppBar(
        title: Consumer<GetAllChatsProvider>(
          builder: (context, value, child) => Row(
            children: [
              CircleAvatar(
                radius: 20,
                child: Image.asset(
                  "assets/profile.png",
                ),
              ),
              kWidth(10),
              Column(
                children: [
                  Text(
                    widget.role == "seeker"
                        ? value.recruiterChats[widget.index1].username
                        : value.filteredChats[widget.index1].username,
                  ),
                  const Text(
                    "Online",
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Consumer<GetAllChatsProvider>(
          builder: (context, value, child) {
            return value.chatMessage == null
                ? SizedBox()
                : value.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          Expanded(
                              child: GroupedListView<ChatResModel, DateTime>(
                            elements: value.chatMessage!,
                            reverse: true,
                            order: GroupedListOrder.DESC,
                            floatingHeader: true,
                            groupBy: (ChatResModel message) => DateTime(
                              message.createdAt.year,
                              message.createdAt.month,
                              message.createdAt.day,
                            ),
                            groupHeaderBuilder: (ChatResModel message) =>
                                SizedBox(
                              height: 35,
                              child: Center(
                                child: Text(DateFormat.yMMMd()
                                    .format(message.createdAt)),
                              ),
                            ),
                            indexedItemBuilder:
                                (context, ChatResModel message, index) => Align(
                              alignment: widget.receiverId ==
                                      value.chatMessage![index].user
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: widget.receiverId ==
                                            value.chatMessage![index].user
                                        ? const BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(10),
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10)))
                                        : BoxDecoration(
                                            color: Colors.green[500],
                                            borderRadius: const BorderRadius
                                                    .only(
                                                bottomLeft: Radius.circular(10),
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          value.chatMessage![index].message),
                                    ),
                                  ),
                                  kHeight(10)
                                ],
                              ),
                            ),
                          )),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextField(
                              controller: messageController,
                              decoration: InputDecoration(
                                  suffixIcon:
                                      Consumer<GetAppliedPeoplesProvider>(
                                    builder: (context, value, child) =>
                                        IconButton(
                                            onPressed: () {
                                              String sendMessage =
                                                  messageController.text.trim();

                                              sentMessage(
                                                  value.appliedPeoples![0]
                                                      .appliedBy.id,
                                                  sendMessage);
                                              setState(() {
                                                // message.add(messages);
                                              });
                                            },
                                            icon: Icon(
                                              Icons.send,
                                              color: Colors.green[500],
                                            )),
                                  ),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  contentPadding: const EdgeInsets.all(12),
                                  hintText: "Type something here"),
                              onSubmitted: (value) {},
                            ),
                          )
                        ],
                      );
          },
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
