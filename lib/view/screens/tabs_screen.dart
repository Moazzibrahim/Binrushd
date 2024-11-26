import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/view/screens/all_articles_screen.dart';
import 'package:flutter_application_1/view/screens/appointments/my_appointments_screen.dart';
import 'package:flutter_application_1/view/screens/home_screen.dart';
import 'package:flutter_application_1/view/screens/profile_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  var _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: const [
                HomePage(),
                ProfileScreen(),
                MyAppointmentsScreen(),
                AllArticlesScreen(),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20, // This sets the floating effect
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 70, // Increased height to accommodate labels
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _bottomNavBarIcon(
                        iconOn: Icons.person,
                        iconOff: Icons.person_outline,
                        index: 1,
                        label: 'حسابي',
                      ),
                      _bottomNavBarIcon(
                        iconOn: Icons.article,
                        iconOff: Icons.article_outlined,
                        index: 3,
                        label: 'المقالات',
                      ),
                      _bottomNavBarIcon(
                        iconOn: Icons.calendar_today,
                        iconOff: Icons.calendar_today_outlined,
                        index: 2,
                        label: 'الحجوزات',
                      ),
                      _bottomNavBarIcon(
                        iconOn: Icons.home,
                        iconOff: Icons.home_outlined,
                        index: 0,
                        label: 'الرئيسية',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomNavBarIcon({
    required IconData iconOff,
    required int index,
    IconData? iconOn,
    String? label,
  }) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? backgroundColor : Colors.black;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
          _pageController.jumpToPage(index);
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected ? iconOn ?? iconOff : iconOff,
            color: color,
          ),
          if (label != null)
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }
}
