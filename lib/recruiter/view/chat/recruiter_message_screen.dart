import 'dart:developer';

import 'package:cleverhire/core/constraints/constraints.dart';
import 'package:cleverhire/job_seeker/model/chat_res_model.dart';

import 'package:cleverhire/recruiter/controller/provider/get_all_chats_provider.dart';
import 'package:cleverhire/recruiter/controller/provider/get_applied_people_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../core/api/api_config.dart';
import '../../controller/provider/send_message_provider.dart';

// ignore: must_be_immutable
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

late IO.Socket socket;
TextEditingController messageController = TextEditingController();

class _RecruiterMessageScreenState extends State<RecruiterMessageScreen> {
  void initSocket() {
    String baseUrl = ApiConfig.baseUrl;

    socket = IO.io(baseUrl, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket.connect();
    socket.onConnect((data1) {
      log("connection established...${socket.connected}");
      socket.emit("new-user-add", (widget.receiverId));
      setState(() {
        socket.on(
            "get-users", (data) => log(data.toString(), name: "get User"));
        socket.on("receive-message", (data) {
          log("received");
          log(data.toString(), name: 'Data');

          Provider.of<GetAllChatsProvider>(context, listen: false)
              .updateMessage(data["message"]);
        });
        log('received..message', name: 'received');
      });
    });
    socket.onDisconnect((_) => log("connection disconnected"));
    socket.onConnectError((err) => log(err.toString()));
    socket.onError((err) => log(err.toString()));
  }

  String? receiverId;
  String? newRole;

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        initSocket();
        FlutterSecureStorage storage = const FlutterSecureStorage();
        receiverId = await storage.read(key: "_id");

        // ignore: use_build_context_synchronously
        await Provider.of<GetAllChatsProvider>(context, listen: false)
            .fetchPersonalChatProvider(widget.chatId);
      },
    );
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
              Text(
                widget.role == "seeker"
                    ? value.recruiterChats[widget.index1].username
                    : value.filteredChats[widget.index1].username,
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
                ? const SizedBox()
                : value.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          Expanded(
                              child: GroupedListView<ChatResModel, DateTime>(
                            elements: value.chatMessage!,
                            // reverse: true,
                            // order: GroupedListOrder.DESC,
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
                          Form(
                            key: formkey,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: TextFormField(
                                controller: Provider.of<SendMessageProvider>(
                                        context,
                                        listen: false)
                                    .messageController,
                                decoration: InputDecoration(
                                    suffixIcon:
                                        Consumer<GetAppliedPeoplesProvider>(
                                      builder: (context, value, child) =>
                                          IconButton(
                                              onPressed: () {
                                                // setState(() {
                                                if (formkey.currentState!
                                                    .validate()) {
                                                  Provider.of<SendMessageProvider>(
                                                          context,
                                                          listen: false)
                                                      .sentMessage(
                                                          widget.receiverId);

                                                  sendMessageSocket(Provider.of<
                                                              SendMessageProvider>(
                                                          context,
                                                          listen: false)
                                                      .messageController
                                                      .text
                                                      .trim());
                                                  Provider.of<SendMessageProvider>(
                                                          context,
                                                          listen: false)
                                                      .messageController
                                                      .clear();
                                                }
                                                FocusScope.of(context)
                                                    .unfocus();
                                                // });
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "please enter something";
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      );
          },
        ),
      ),
    );
  }

  void sendMessageSocket(String message) {
    log('message sending...');
    socket.emit(
        "send-message", {"receiverId": widget.receiverId, "message": message});
    socket.on("receive-message", (data) {
      log(data.toString());
      log(data.toString(), name: 'Data');
      // GetChatModel model = GetChatModel(message: data);
    });
    log('message sent');
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }
}
