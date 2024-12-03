import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/controller/Auth/logout_provider.dart';
import 'package:flutter_application_1/controller/profile_provider.dart';
import 'package:flutter_application_1/view/screens/appointments/my_appointments_screen.dart';
import 'package:flutter_application_1/view/screens/contact_us_screen.dart';
import 'package:flutter_application_1/view/screens/my_favourites_screen.dart';
import 'package:flutter_application_1/view/screens/privacy_policy_screen.dart';
import 'package:flutter_application_1/view/screens/profile/my_profile_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreens extends StatelessWidget {
  const ProfileScreens({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch the ProfileProvider
    final profileProvider = Provider.of<ProfileProvider>(context);
    final logprov = Provider.of<LoginProvider>(context, listen: false);
    final token = logprov.token;

    // Call the API to fetch profile data when the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (profileProvider.authUserResponse == null) {
        profileProvider.fetchProfile(
          token: token!, // Replace with the actual token
          context: context,
        );
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40), // Top padding
            Text(
              ' ${profileProvider.authUserResponse!.data.fname} ${profileProvider.authUserResponse!.data.lname}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            buildProfileMenuItem(
              icon: Icons.person,
              text: 'البيانات الشخصية',
              color: backgroundColor,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyProfileScreen()),
                );
              },
            ),
            buildProfileMenuItem(
              icon: Icons.phone,
              text: 'تواصل معنا',
              color: backgroundColor,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ContactUsScreen()),
                );
              },
            ),
            buildProfileMenuItem(
              icon: Icons.calendar_today,
              text: 'الحجوزات',
              color: backgroundColor,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyAppointmentsScreen()),
                );
              },
            ),
            buildProfileMenuItem(
              icon: Icons.favorite,
              text: 'المفضلة',
              color: backgroundColor,
              onTap: () {
                // Add navigation or functionality here
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyFavouritesScreen()),
                );
              },
            ),
            buildProfileMenuItem(
              icon: Icons.settings,
              text: ' سياسة الخصوصية',
              color: backgroundColor,
              onTap: () {
                // Add navigation or functionality here
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget buildProfileMenuItem({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(Icons.arrow_back_ios, color: color),
      trailing: SizedBox(
        width: 150, // Adjust width as needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 8), // Add spacing between text and icon
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(icon, color: color),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLogoutButton(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end, // Adjusts alignment
        children: [
          Text(
            'تسجيل الخروج',
            style: TextStyle(
              color: backgroundColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'تسجيل الخروج',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    content: const Text(
                      'هل انت متأكد انك تريد تسجيل الخروج من حسابك؟',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: ElevatedButton(
                              onPressed: () {
                                Provider.of<LogoutProvider>(context,
                                        listen: false)
                                    .logOut(
                                        token: loginProvider.token!,
                                        context: context);
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                ),
                                backgroundColor: backgroundColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'نعم، الخروج',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.grey),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'لا، الغاء',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.logout, color: backgroundColor),
            ),
          ),
        ],
      ),
    );
  }
}
