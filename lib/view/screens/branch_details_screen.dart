import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';

class BranchDetailsScreen extends StatelessWidget {
  const BranchDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Image
            Image.asset(
              'assets/images/place.png', // Replace with your image URL
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Title
                  Text(
                    'منطقة الرياض - فرع الدائري الجنوبي',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: backgroundColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  // Working Hours
                  const Text(
                    'ساعات العمل',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Schedule
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ScheduleItem(day: 'السبت', time: '00:00 - 00:00'),
                      ScheduleItem(day: 'الأحد', time: '00:00 - 00:00'),
                      ScheduleItem(day: 'الاثنين', time: '00:00 - 00:00'),
                      ScheduleItem(day: 'الثلاثاء', time: '00:00 - 00:00'),
                      ScheduleItem(day: 'الأربعاء', time: '00:00 - 00:00'),
                      ScheduleItem(day: 'الخميس', time: '00:00 - 00:00'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Book Appointment Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: backgroundColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 90),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'حجز موعد',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleItem extends StatelessWidget {
  final String day;
  final String time;

  const ScheduleItem({super.key, required this.day, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            time,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
          Text(
            day,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
