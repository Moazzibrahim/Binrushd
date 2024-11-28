import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                            Center(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  const CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        AssetImage('assets/profile.jpg'),
                                  ),
                                  Positioned(
                                    bottom: -10,
                                    right: -4,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.camera_alt,
                                        color: backgroundColor,
                                      ),
                                      onPressed: () {},
                                      iconSize: 28,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            buildTextField(
                              label: 'الاسم بالكامل',
                              hint: 'محمد جابر',
                              icon: Icons.person,
                            ),
                            const SizedBox(height: 10),
                            buildTextField(
                              label: 'الإيميل',
                              hint: 'example@mail.com',
                              icon: Icons.email,
                            ),
                            const SizedBox(height: 10),
                            buildTextField(
                              label: 'رقم الهاتف',
                              hint: '+20123456789',
                              icon: Icons.phone,
                            ),
                            const SizedBox(height: 10),
                            buildTextField(
                              label: 'العنوان',
                              hint: 'المدينة - المنطقة',
                              icon: Icons.location_on,
                            ),
                            const SizedBox(height: 10),
                            buildTextField(
                              label: 'كلمة السر',
                              hint: '******',
                              icon: Icons.lock,
                              obscureText: true,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: backgroundColor,
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text(
                            'حفظ التغييرات',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
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
