import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/controller/Auth/logout_provider.dart';
import 'package:flutter_application_1/view/screens/my_favourites_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
            ),
            buildProfileMenuItem(
              icon: Icons.phone,
              text: 'تواصل معنا',
              color: backgroundColor,
            ),
            buildProfileMenuItem(
              icon: Icons.calendar_today,
              text: 'الحجوزات',
              color: backgroundColor,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyFavouritesScreen()));
              },
              child: buildProfileMenuItem(
                icon: Icons.favorite,
                text: 'المفضلة',
                color: backgroundColor,
              ),
            ),
            buildProfileMenuItem(
              icon: Icons.settings,
              text: 'الاعدادات والخصوصية',
              color: backgroundColor,
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
  }) {
    return ListTile(
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
          onTap: () async {
            await Provider.of<LogoutProvider>(context, listen: false)
                .logOut(token: loginProvider.token!, context: context);
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
