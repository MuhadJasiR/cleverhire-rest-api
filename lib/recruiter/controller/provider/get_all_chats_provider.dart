import 'dart:developer';

import 'package:cleverhire/job_seeker/model/chat_res_model.dart';
import 'package:cleverhire/job_seeker/model/chat_user_model.dart';
import 'package:cleverhire/recruiter/controller/api_services/getServices/get_all_chat_services.dart';
import 'package:flutter/material.dart';

class GetAllChatsProvider with ChangeNotifier {
  List<ChatResModel>? chatMessage;
  List<Member>? fetchedChats;
  String? chatId;
  List<Member> filteredChats = [];
  List<Member> recruiterChats = [];
  bool isLoading = false;
  Future<void> fetchingAllChats() async {
    isLoading = true;
    notifyListeners();
    final getAllChatsApiServices = GetAllChatApiServices();

    await getAllChatsApiServices.fetchAllChatServices().then((value) {
      fetchedChats = value!.members;
      notifyListeners();
      chatId = value.id;
      notifyListeners();
      filteredChats.clear();
      notifyListeners();
      recruiterChats.clear();
      notifyListeners();
      for (var element in fetchedChats!) {
        if (element.role == 'seeker') {
          filteredChats.add(element);
          notifyListeners();
        } else {
          recruiterChats.add(element);
          notifyListeners();
          log(recruiterChats.toString());
        }
      }
      notifyListeners();
      isLoading = false;
      notifyListeners();
    });
    isLoading = false;
    notifyListeners();
    log(fetchedChats.toString());
  }

  Future<void> fetchPersonalChatProvider(String chatId) async {
    isLoading = true;
    notifyListeners();
    await GetAllChatApiServices()
        .fetchPersonalChatServices(chatId)
        .then((value) {
      chatMessage = value;
      notifyListeners();
      isLoading = false;
      notifyListeners();
    });
    isLoading = false;
    notifyListeners();
    log(chatMessage.toString(), name: 'chat message');
  }
}
