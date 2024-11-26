import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/view/screens/onboarding/appointments_details_screen.dart';
import 'package:provider/provider.dart';

class MyAppointmentsScreen extends StatelessWidget {
  const MyAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch appointments from the provider
    final reservations = Provider.of<LoginProvider>(context, listen: false)
        .loginResponse!
        .data
        .user
        .reservations;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'حجوزاتي',
          style: TextStyle(
            fontFamily: 'Arial', // Change to your preferred Arabic font
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: reservations.length,
        itemBuilder: (context, index) {
          final reservation = reservations[index];
          return Column(
            children: [
              _buildDoctorCard(
                context,
                name: reservation.branch.name, // Doctor's name from branch
                location: reservation.branch.address, // Branch address
                isFavorite: false, // Default value for favorite
              ),
              const SizedBox(height: 16.0),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDoctorCard(
    BuildContext context, {
    required String name,
    required String location,
    required bool isFavorite,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Favorite Button
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? backgroundColor : Colors.grey,
                ),
                onPressed: () {
                  // Handle favorite action
                },
              ),
              // Doctor Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            location,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),
            ],
          ),
          const SizedBox(height: 12),
          // View Details Button
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor, // Use your defined color
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Navigate to appointment details
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const AppointmentDetailsScreen(), // Pass reservation if needed
                  ),
                );
              },
              icon: const Icon(
                Icons.keyboard_arrow_down,
                size: 20,
                color: Colors.white,
              ),
              label: const Text(
                "عرض التفاصيل",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
