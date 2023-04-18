import 'package:cleverhire/job_seeker/model/send_chat_model.dart';
import 'package:cleverhire/recruiter/controller/api_services/send_chat_message_services.dart';
import 'package:flutter/cupertino.dart';

class SendMessageProvider with ChangeNotifier {
  TextEditingController messageController = TextEditingController();
  bool isLoading = false;

  Future sentMessage(String receiverId) async {
    isLoading = true;
    final message = messageController.text.trim();
    final sendChatModel =
        SendChatModel(message: message, receiverId: receiverId);

    SendChatApiServices().sendChatMessage(sendChatModel);
  }
}
