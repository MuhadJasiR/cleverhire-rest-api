import 'package:cleverhire/core/color/color.dart';
import 'package:cleverhire/job_seeker/controller/provider/local_functions_provider.dart';
import 'package:cleverhire/job_seeker/view/Explore/explore_screen.dart';
import 'package:cleverhire/job_seeker/view/applied_jobs/applied_jobs.dart';
import 'package:cleverhire/job_seeker/view/home/home_screen.dart';
import 'package:cleverhire/job_seeker/view/profile/profile_edit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({super.key});
  final screens = [
    const HomeScreen(),
    ExploreScreen(),
    const AppliedJobs(),
    const ProfileEdit(),
  ];
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalFunctionProvider>(context);
    return Scaffold(
      body: screens[provider.index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(indicatorColor: kTextFieldColor),
        child: Consumer<LocalFunctionProvider>(
          builder: (context, value, child) => NavigationBar(
              selectedIndex: value.index,
              onDestinationSelected: (index) {
                value.changeIndex(index);
              },
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: "Home"),
                NavigationDestination(
                    icon: Icon(Icons.cases_rounded), label: "Explore"),
                NavigationDestination(
                    icon: Icon(Icons.grid_view_rounded), label: "Applied Jobs"),
                NavigationDestination(
                    icon: Icon(Icons.person_3), label: "Profile"),
              ]),
        ),
      ),
    );
  }
}
