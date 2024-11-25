import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/controller/fetch_doctors_data_provider.dart';
import 'package:flutter_application_1/view/screens/doctor_details_screen.dart';
import 'package:provider/provider.dart';

class DoctorsListScreen extends StatefulWidget {
  const DoctorsListScreen({super.key});

  @override
  State<DoctorsListScreen> createState() => _DoctorsListScreenState();
}

class _DoctorsListScreenState extends State<DoctorsListScreen> {
  // Set to keep track of favorite items
  final Set<int> _favoriteIndices = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'الأطباء',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Consumer<FetchDoctorsDataProvider>(
        builder: (context, doctorsProvider, child) {
          // Check if the data is still being fetched
          if (doctorsProvider.doctorsResponse == null) {
            return const Center(
              child: CircularProgressIndicator(), // Show loading spinner
            );
          }

          // Get the list of doctors from the provider
          final doctors = doctorsProvider.doctorsResponse!.data;

          // If no doctors available
          if (doctors.isEmpty) {
            return const Center(
              child: Text('لا يوجد أطباء حاليا'), // No doctors message
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doctor = doctors[index];
              final isFavorite = _favoriteIndices.contains(index);

              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Favorite Icon
                            IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite
                                    ? backgroundColor
                                    : backgroundColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (isFavorite) {
                                    _favoriteIndices.remove(index);
                                  } else {
                                    _favoriteIndices.add(index);
                                  }
                                });
                              },
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            // Doctor's Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${doctor.fname} ${doctor.lname}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    doctor.speciality,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Doctor's Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                doctor.image,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: backgroundColor,
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 100),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DoctorDetailsScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "عرض الملف الشخصي",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
