// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/controller/make_report_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/controller/branches/fetch_branches_provider.dart';
import 'package:flutter_application_1/controller/doctors/fetch_doctors_data_provider.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _fileNumberController = TextEditingController();
  String? _selectedBranchId; // Store branch ID here
  String? _selectedDoctorId;

  @override
  void initState() {
    super.initState();
    Provider.of<FetchBranchesProvider>(context, listen: false)
        .fetchBranches(context);
    Provider.of<FetchDoctorsDataProvider>(context, listen: false)
        .fetchDoctorsData(context);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _fileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final branchesProvider = Provider.of<FetchBranchesProvider>(context);
    final branches = branchesProvider.branchResponse?.data ?? [];
    final doctorsProvider = Provider.of<FetchDoctorsDataProvider>(context);
    final doctors = doctorsProvider.doctorsResponse?.data ?? [];
    final makeReportProvider =
        Provider.of<MakeReportProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "تواصل معنا",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "مرحبا بك 👋",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                "نسعد بتواصلك معنا. يرجى ملء النموذج أدناه وسنحاول الاتصال بك في أقرب وقت ممكن.",
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 24),
              _buildTextField(
                controller: _nameController,
                label: "الاسم بالكامل",
                hintText: "ادخل اسمك بالكامل",
                icon: Icons.person,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _phoneController,
                label: "رقم الهاتف",
                hintText: "ادخل الرقم الخاص بك",
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              _buildDropdown(
                label: "اختار الفرع",
                value: _selectedBranchId,
                onChanged: (value) {
                  setState(() {
                    _selectedBranchId = value;
                  });
                },
                items: branches.map((branch) {
                  return DropdownMenuItem<String>(
                    value: branch.id.toString(),
                    child: Text(branch.name),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              _buildDropdown(
                label: "اختار الطبيب",
                value: _selectedDoctorId,
                onChanged: (value) {
                  setState(() {
                    _selectedDoctorId = value;
                  });
                },
                items: doctors.map((doctor) {
                  return DropdownMenuItem<String>(
                    value: doctor.id.toString(),
                    child: Text("${doctor.fname} ${doctor.lname}"),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              // Message Title Field
              const Text(
                "عنوان الرسالة",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                items: const [
                  DropdownMenuItem(
                    value: "استفسار",
                    child: Text("استفسار"),
                  ),
                  DropdownMenuItem(
                    value: "مشكلة",
                    child: Text("مشكلة"),
                  ),
                  DropdownMenuItem(
                    value: "اقتراح",
                    child: Text("اقتراح"),
                  ),
                ],
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: "اختر عنوان الرسالة",
                  prefixIcon: const Icon(Icons.message),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Message Field
              const Text(
                "الرسالة",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _fileNumberController,
                textAlign: TextAlign.right,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "ادخل نص رسالتك هنا...",
                  suffixIcon: const Icon(Icons.chat),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: backgroundColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    if (_nameController.text.isEmpty ||
                        _phoneController.text.isEmpty ||
                        _fileNumberController.text.isEmpty ||
                        _selectedBranchId == null ||
                        _selectedDoctorId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("يرجى ملء جميع الحقول")),
                      );
                      return;
                    }
                    try {
                      final loginprovider =
                          Provider.of<LoginProvider>(context, listen: false);
                      final token =
                          loginprovider.token; // Replace with actual token
                      await makeReportProvider.sendReportRequest(
                        name: _nameController.text,
                        phone: _phoneController.text,
                        fileNumber: _fileNumberController.text,
                        doctorId: int.parse(_selectedDoctorId!),
                        branchId: int.parse(_selectedBranchId!),
                        token: token!,
                        context: context,
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("حدث خطأ: $e")),
                      );
                    }
                  },
                  child: const Text(
                    "إرسال",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: Icon(icon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required Function(String?) onChanged,
    required List<DropdownMenuItem<String>> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          hint: const Align(
            alignment: Alignment.centerRight,
            child: Text(
              "اختر",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          items: items,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
