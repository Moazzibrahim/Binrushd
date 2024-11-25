import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/view/screens/Auth/login_screen.dart';

class ThirdOnboarding extends StatelessWidget {
  const ThirdOnboarding({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Red Card with Text and Elements
              Image.asset('assets/images/third.png'),
              const SizedBox(
                height: 20,
              ),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  // Main Card
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    decoration: BoxDecoration(
                      color: backgroundColor, // Red background color
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                            height: 40), // Space for the arrow button
                        // Title
                        const Text(
                          'أطباؤنا متخصصون',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Subtitle
                        const Text(
                          'ابحث عن طبيبك الذي يقدم لك الرعاية الكاملة',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Pagination Dots and Skip Button
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Pagination Dots
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                3,
                                (index) => Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  width: index == 2
                                      ? 20
                                      : 8, // Wide for active, small for inactive
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: index == 2
                                        ? Colors.white
                                        : Colors
                                            .white38, // Highlight active dot
                                    borderRadius: BorderRadius.circular(
                                        20), // Rounded corners for all
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // Skip Button
                            GestureDetector(
                              onTap: () {
                                // Handle Skip Action
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                              },
                              child: const Text(
                                'تخطى',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Arrow Button
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () {
                        // Handle Arrow Button Action
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Color(0xFF950000),
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
