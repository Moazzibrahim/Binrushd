import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/fetch_branches_provider.dart';
import 'package:flutter_application_1/controller/fetch_departments_provider.dart';
import 'package:flutter_application_1/controller/fetch_doctors_data_provider.dart';
import 'package:flutter_application_1/controller/fetch_offers_provider.dart';
import 'package:flutter_application_1/controller/fetch_posts_provider.dart';
import 'package:flutter_application_1/controller/login_provider.dart';
import 'package:flutter_application_1/controller/logout_provider.dart';
import 'package:flutter_application_1/controller/make_report_provider.dart';
import 'package:flutter_application_1/controller/make_reservation_provider.dart';
import 'package:flutter_application_1/controller/send_otp_provider.dart';
import 'package:flutter_application_1/controller/sign_up_provider.dart';
import 'package:flutter_application_1/view/screens/onboarding/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => SendOtpProvider()),
        ChangeNotifierProvider(create: (_) => FetchDoctorsDataProvider()),
        ChangeNotifierProvider(create: (_) => FetchBranchesProvider()),
        ChangeNotifierProvider(create: (_) => FetchDepartmentsProvider()),
        ChangeNotifierProvider(create: (_) => FetchPostsProvider()),
        ChangeNotifierProvider(create: (_) => FetchOffersProvider()),
        ChangeNotifierProvider(create: (_) => MakeReservationProvider()),
        ChangeNotifierProvider(create: (_) => LogoutProvider()),
        ChangeNotifierProvider(create: (_) => MakeReportProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812), // Base design dimensions
        builder: (context, child) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
