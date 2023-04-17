import 'dart:developer';

import 'package:cleverhire/core/api/api_config.dart';
import 'package:cleverhire/job_seeker/model/send_chat_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  IO.Socket? socket;
  List<SendChatModel>? chatModelList;
  String baseUrl = "${ApiConfig.baseUrl}/socket";
  void connect(String userId) {
    socket = IO.io(baseUrl, <String, dynamic>{
      "transport": ["websocket"],
      "autoConnect": false,
    });

    socket!.connect();
    // notifyListeners();
    socket!.onConnect((data) {
      log("connected...");
    });
    // notifyListeners();

    socket!.emit("new-user-add", userId);
  }

  void sendMessage(String message, String senderId) {
    socket!.emit("send-message", {"receiverId": senderId, "message": message});
    socket!.on("receive-message", (data) {
      SendChatModel sentChatModel =
          SendChatModel(message: data, receiverId: senderId);
      chatModelList!.add(sentChatModel);
    });
  }
}
