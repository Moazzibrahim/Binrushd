// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/controller/branches/fetch_individual_branch_provider.dart';
import 'package:provider/provider.dart';

class BranchDetailsScreen extends StatefulWidget {
  final int? branchId;
  final String? image;
  const BranchDetailsScreen({super.key, this.branchId, this.image});

  @override
  _BranchDetailsScreenState createState() => _BranchDetailsScreenState();
}

class _BranchDetailsScreenState extends State<BranchDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch branch data when the screen is initialized
    if (widget.branchId != null) {
      Provider.of<FetchIndividualBranchProvider>(context, listen: false)
          .fetchInduividualBranches(context, widget.branchId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Image
            Image.network(
              widget.image!, // Replace with your image URL
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Title
                  Consumer<FetchIndividualBranchProvider>(
                    builder: (context, provider, child) {
                      // Check if the data is loaded
                      if (provider.branchResponse == null) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final branch = provider.branchResponse!.data;

                      return Text(
                        branch.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: backgroundColor,
                        ),
                        textAlign: TextAlign.center,
                      );
                    },
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
                  Consumer<FetchIndividualBranchProvider>(
                    builder: (context, provider, child) {
                      if (provider.branchResponse == null) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final worktimes = provider.branchResponse!.data.worktimes;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ScheduleItem(day: 'السبت', time: worktimes.saturday),
                          const SizedBox(
                            height: 8,
                          ),
                          ScheduleItem(day: 'الأحد', time: worktimes.sunday),
                          const SizedBox(
                            height: 8,
                          ),
                          ScheduleItem(day: 'الاثنين', time: worktimes.monday),
                          const SizedBox(
                            height: 8,
                          ),
                          ScheduleItem(
                              day: 'الثلاثاء', time: worktimes.tuesday),
                          const SizedBox(
                            height: 8,
                          ),
                          ScheduleItem(
                              day: 'الأربعاء', time: worktimes.wednesday),
                          const SizedBox(
                            height: 8,
                          ),
                          ScheduleItem(day: 'الخميس', time: worktimes.thursday),
                          const SizedBox(
                            height: 8,
                          ),
                          ScheduleItem(day: 'الجمعة', time: worktimes.friday),
                        ],
                      );
                    },
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
            style: const TextStyle(
                fontSize: 10, color: Colors.black, fontWeight: FontWeight.w400),
          ),
          Text(
            day,
            style: const TextStyle(fontSize: 10, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
