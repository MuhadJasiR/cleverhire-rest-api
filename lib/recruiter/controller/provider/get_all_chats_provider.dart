import 'dart:developer';

import 'package:cleverhire/job_seeker/model/chat_user_model.dart';
import 'package:cleverhire/recruiter/controller/api_services/getServices/get_all_chat_services.dart';
import 'package:flutter/material.dart';

class GetAllChatsProvider with ChangeNotifier {
  List<Member>? fetchedChats;
  String? chatId;
  List<Member> filteredChats = [];
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
      for (var element in fetchedChats!) {
        if (element.role == 'seeker') {
          filteredChats.add(element);
          notifyListeners();
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
}
