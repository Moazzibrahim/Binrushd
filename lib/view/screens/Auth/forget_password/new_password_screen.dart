import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'انشاء كلمة سر جديدة',
          style: TextStyle(color: backgroundColor, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/newpassword.png"),
            const SizedBox(height: 20),
            const Text(
              'إنشاء كلمة سر جديدة',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            buildLabeledTextField(' ادخل كلمة سر جديدة', '●●●●●●●', Icons.lock,
                obscureText: true),
            const SizedBox(height: 20),
            buildLabeledTextField(' تأكيد كلمة السر', '●●●●●●●', Icons.lock,
                obscureText: true),
            const SizedBox(height: 180),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: backgroundColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 150, vertical: 10),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text(
                'حفظ',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLabeledTextField(String label, String hintText, IconData icon,
      {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          textAlign: TextAlign.right,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            suffixIcon: Icon(icon),
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
