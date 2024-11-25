import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40), // Top padding
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(Icons.arrow_back_ios, color: backgroundColor),
              ),
            ),
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                  'assets/images/person.png'), // Replace with your asset
            ),
            const SizedBox(height: 10),
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
            buildProfileMenuItem(
              icon: Icons.favorite,
              text: 'المفضلة',
              color: backgroundColor,
            ),
            buildProfileMenuItem(
              icon: Icons.settings,
              text: 'الاعدادات والخصوصية',
              color: backgroundColor,
            ),
            const SizedBox(height: 20),
            buildLogoutButton(),
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

  Widget buildLogoutButton() {
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
        trailing: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.logout, color: backgroundColor),
        ),
      ),
    );
  }
}
