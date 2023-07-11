import 'package:cleverhire/authentication/view/sign_in_screen.dart';
import 'package:cleverhire/job_seeker/controller/firebase/storage_services.dart';
import 'package:cleverhire/job_seeker/controller/provider/applying_for_vacancy_provider.dart';
import 'package:cleverhire/job_seeker/controller/provider/get_applied_jobs_provider.dart';
import 'package:cleverhire/job_seeker/controller/provider/get_uploaded_post_provider.dart';
import 'package:cleverhire/job_seeker/controller/provider/search_vacancy_provider.dart';
import 'package:cleverhire/job_seeker/controller/provider/seeker_login_provider.dart';
import 'package:cleverhire/job_seeker/controller/provider/update_seeker_details_provider.dart';
import 'package:cleverhire/job_seeker/controller/provider/upload_image_provider.dart';
import 'package:cleverhire/recruiter/controller/provider/company_login_provider.dart';
import 'package:cleverhire/recruiter/controller/provider/create_vacancy_provider.dart';
import 'package:cleverhire/recruiter/controller/provider/get_all_chats_provider.dart';
import 'package:cleverhire/recruiter/controller/provider/get_applied_people_provider.dart';
import 'package:cleverhire/recruiter/controller/provider/get_created_vacancy_provider.dart';
import 'package:cleverhire/recruiter/controller/provider/send_message_provider.dart';
import 'package:cleverhire/recruiter/controller/provider/update_vacancy_provider.dart';
import 'package:cleverhire/theme/theme.dart';
import 'package:cleverhire/job_seeker/controller/provider/local_functions_provider.dart';
import 'package:cleverhire/authentication/controller/provider/sign_in_provider.dart';
import 'package:cleverhire/recruiter/controller/provider/local_functions_recruiter.dart';
import 'package:cleverhire/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'authentication/controller/provider/otp_verification.dart';
import 'authentication/controller/provider/sign_up_provider.dart';
import 'job_seeker/controller/provider/chat_provider.dart';
import 'job_seeker/controller/provider/get_seeker_details_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider(create: ((context) => LocalFunctionProvider())),
        ListenableProvider(create: ((context) => LocalFunctionsRecruiter())),
        ListenableProvider(create: ((context) => SignInProvider())),
        ListenableProvider(create: ((context) => SignUpProvider())),
        ListenableProvider(create: ((context) => OtpVerificationProvider())),
        ListenableProvider(create: ((context) => CompanyLoginProvider())),
        ListenableProvider(create: ((context) => FirebaseStorageProvider())),
        ListenableProvider(create: ((context) => CreateVacancyProvider())),
        ListenableProvider(create: ((context) => SeekerLoginProvider())),
        ListenableProvider(create: ((context) => GetCreatedVacancyProvider())),
        ListenableProvider(create: ((context) => ApplyingForVacancyProvider())),
        ListenableProvider(create: ((context) => GetAppliedPeoplesProvider())),
        ListenableProvider(create: ((context) => SearchJobVacancyProvider())),
        ListenableProvider(create: ((context) => GetAppliedJobsProvider())),
        ListenableProvider(create: ((context) => UpdateVacancyProvider())),
        ListenableProvider(create: ((context) => UploadImageProvider())),
        ListenableProvider(create: ((context) => GetUploadedPostProvider())),
        ListenableProvider(create: ((context) => GetSeekerDetailsProvider())),
        ListenableProvider(
            create: ((context) => UpdateSeekerDetailsProvider())),
        ListenableProvider(create: ((context) => ChatProvider())),
        ListenableProvider(create: ((context) => GetAllChatsProvider())),
        ListenableProvider(
          create: ((context) => SendMessageProvider()),
        ),
      ],
      child: OverlaySupport.global(
        child: MaterialApp(
          title: 'Flutter Demo',
          themeMode: ThemeMode.system,
          theme: MyTheme.lightTheme,
          darkTheme: MyTheme.darkTheme,
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
