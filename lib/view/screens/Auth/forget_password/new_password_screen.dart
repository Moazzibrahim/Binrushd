import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/controller/Auth/reset_password_provider.dart';
import 'package:provider/provider.dart';

class NewPasswordScreen extends StatelessWidget {
  final String? tokens;
  const NewPasswordScreen({super.key, this.tokens});

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

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
            buildLabeledTextField(
              label: 'ادخل كلمة سر جديدة',
              controller: passwordController,
              icon: Icons.lock,
              obscureText: true,
            ),
            const SizedBox(height: 20),
            buildLabeledTextField(
              label: 'تأكيد كلمة السر',
              controller: confirmPasswordController,
              icon: Icons.lock,
              obscureText: true,
            ),
            const SizedBox(height: 120),
            ElevatedButton(
              onPressed: () async {
                final password = passwordController.text.trim();
                final confirmPassword = confirmPasswordController.text.trim();

                if (password.isEmpty || confirmPassword.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('يرجى إدخال كلمة المرور وتأكيدها.'),
                    ),
                  );
                  return;
                }

                if (password != confirmPassword) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('كلمتا المرور غير متطابقتين.'),
                    ),
                  );
                  return;
                }

                // Call ResetPasswordProvider
                await Provider.of<ResetPasswordProvider>(context, listen: false)
                    .resetPasswordP(
                  password: password,
                  confPassword: confirmPassword,
                  token: tokens,
                  context: context,
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: backgroundColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 140, vertical: 10),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text(
                'حفظ',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLabeledTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool obscureText = false,
  }) {
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
          controller: controller,
          textAlign: TextAlign.right,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: '●●●●●●●',
            hintStyle: const TextStyle(color: Colors.grey),
            suffixIcon: Icon(icon),
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
