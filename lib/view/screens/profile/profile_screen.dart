import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/controller/Auth/logout_provider.dart';
import 'package:flutter_application_1/view/screens/appointments/my_appointments_screen.dart';
import 'package:flutter_application_1/view/screens/contact_us_screen.dart';
import 'package:flutter_application_1/view/screens/my_favourites_screen.dart';
import 'package:flutter_application_1/view/screens/profile/my_profile_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreens extends StatelessWidget {
  const ProfileScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40), // Top padding
            const Text(
              'محمد جابر',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
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
            // buildProfileMenuItem(
            //   icon: Icons.work_history,
            //   text: ' من نحن',
            //   color: backgroundColor,
            //   onTap: () {
            //     // Add navigation or functionality here
            //   },
            // ),
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
      trailing: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(icon, color: color),
      ),
      title: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildLogoutButton(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Text(
          'تسجيل الخروج',
          style: TextStyle(
            color: backgroundColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    'تسجيل الخروج',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: const Text(
                    'هل انت متأكد انك تريد تسجيل الخروج من حسابك؟',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Trigger the logout process
                            Provider.of<LogoutProvider>(context, listen: false)
                                .logOut(
                                    token: loginProvider.token!,
                                    context: context);
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                backgroundColor, // Red color for the button
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // Rounded corners
                            ),
                          ),
                          child: const SizedBox(
                            height: 50, // Set the desired height
                            child: Center(
                              child: Text(
                                'نعم، الخروج',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                color: Colors.grey), // Border color
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // Rounded corners
                            ),
                          ),
                          child: const SizedBox(
                            height: 50, // Set the desired height
                            child: Center(
                              child: Text(
                                'لا، الغاء',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 16),
                              ),
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
      ),
    );
  }
}
