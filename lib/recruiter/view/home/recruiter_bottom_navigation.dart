import 'package:cleverhire/core/color/color.dart';
import 'package:cleverhire/recruiter/controller/provider/local_functions_recruiter.dart';
import 'package:cleverhire/recruiter/view/application/application_screen.dart';
import 'package:cleverhire/recruiter/view/chat/recruiter_chat_screen.dart';
import 'package:cleverhire/recruiter/view/home/recruiter_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../profile/recruiter_edit_screen.dart';

class RecruiterBottomNavigation extends StatelessWidget {
  RecruiterBottomNavigation({super.key});

  final screens = [
    const RecruiterHomeScreen(),
    const RecruiterApplicationScreen(),
    const RecruiterChatScreen(),
    const RecruiterProfileEditingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalFunctionsRecruiter>(context);
    return Scaffold(
      body: screens[provider.index],
      bottomNavigationBar: NavigationBarTheme(
          data: const NavigationBarThemeData(indicatorColor: kMainColor),
          child: Consumer<LocalFunctionsRecruiter>(
            builder: (context, value, child) => NavigationBar(
                selectedIndex: provider.index,
                onDestinationSelected: (index) => value.changingIndex(index),
                destinations: const [
                  NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                  NavigationDestination(
                      icon: Icon(Icons.list_alt_sharp), label: 'Application'),
                  NavigationDestination(
                      icon: Icon(Icons.mark_chat_unread_rounded),
                      label: 'Chat'),
                  NavigationDestination(
                      icon: Icon(Icons.person_2_rounded), label: 'Profile')
                ]),
          )),
    );
  }
}
