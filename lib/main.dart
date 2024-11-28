import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/Auth/check_forget_pass_provider.dart';
import 'package:flutter_application_1/controller/Auth/forget_password_provider.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/controller/Auth/logout_provider.dart';
import 'package:flutter_application_1/controller/Auth/reset_password_provider.dart';
import 'package:flutter_application_1/controller/Auth/send_otp_provider.dart';
import 'package:flutter_application_1/controller/Auth/sign_up_provider.dart';
import 'package:flutter_application_1/controller/about_us_provider.dart';
import 'package:flutter_application_1/controller/add_to_favourites_provider.dart';
import 'package:flutter_application_1/controller/branches/fetch_branches_provider.dart';
import 'package:flutter_application_1/controller/branches/fetch_individual_branch_provider.dart';
import 'package:flutter_application_1/controller/doctors/fetch_doctors_data_provider.dart';
import 'package:flutter_application_1/controller/doctors/fetch_individual_doctor_provider.dart';
import 'package:flutter_application_1/controller/fetch_departments_provider.dart';
import 'package:flutter_application_1/controller/fetch_offers_provider.dart';
import 'package:flutter_application_1/controller/fetch_posts_provider.dart';
import 'package:flutter_application_1/controller/make_report_provider.dart';
import 'package:flutter_application_1/controller/make_reservation_provider.dart';
import 'package:flutter_application_1/controller/profile_provider.dart';
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
        ChangeNotifierProvider(create: (_) => AddToFavouritesProvider()),
        ChangeNotifierProvider(create: (_) => FetchIndividualDoctorProvider()),
        ChangeNotifierProvider(create: (_) => FetchIndividualBranchProvider()),
        ChangeNotifierProvider(create: (_) => AboutUsProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ResetPasswordProvider()),
        ChangeNotifierProvider(create: (_) => ForgetPasswordProvider()),
        ChangeNotifierProvider(create: (_) => CheckForgetPassProvider()),
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
