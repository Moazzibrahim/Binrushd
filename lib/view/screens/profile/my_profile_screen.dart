import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/controller/profile_provider.dart';
import 'package:provider/provider.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch the ProfileProvider
    final profileProvider = Provider.of<ProfileProvider>(context);
    final logprov = Provider.of<LoginProvider>(context, listen: false);
    final token = logprov.token;

    // Call the API to fetch profile data when the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (profileProvider.authUserResponse == null) {
        profileProvider.fetchProfile(
          token: token!, // Replace with the actual token
          context: context,
        );
      }
    });

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'البيانات الشخصية',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            // Build text fields with fetched data
                            if (profileProvider.authUserResponse != null) ...[
                              buildTextField(
                                label: 'الاسم بالكامل',
                                hint:
                                    '${profileProvider.authUserResponse!.data.fname} ${profileProvider.authUserResponse!.data.lname}',
                                icon: Icons.person,
                              ),
                              const SizedBox(height: 10),
                              buildTextField(
                                label: 'الإيميل',
                                hint: profileProvider
                                    .authUserResponse!.data.email,
                                icon: Icons.email,
                              ),
                              const SizedBox(height: 10),
                              buildTextField(
                                label: 'رقم الهاتف',
                                hint: profileProvider
                                    .authUserResponse!.data.mobile,
                                icon: Icons.phone,
                              ),
                            ] else
                              const Center(
                                child: CircularProgressIndicator(),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          enabled: false, // Makes the TextField read-only
          obscureText: obscureText,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintText: hint,
            hintTextDirection: TextDirection.rtl,
            prefixIcon: Icon(icon, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ],
    );
  }
}
