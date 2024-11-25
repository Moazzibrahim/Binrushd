import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/controller/sign_up_provider.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);

    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'انشاء حساب جديد',
          style: TextStyle(color: backgroundColor, fontWeight: FontWeight.w700),
        ),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildLabeledTextField(
                  'الاسم الاول',
                  'محمد',
                  Icons.person,
                  controller: firstNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الاسم الأول مطلوب';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                buildLabeledTextField(
                  'الاسم التاني',
                  'ابراهيم',
                  Icons.person,
                  controller: lastNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الاسم الثاني مطلوب';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                buildLabeledTextField(
                  'الإيميل',
                  'abd223@gmail.com',
                  Icons.email,
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الإيميل مطلوب';
                    }
                    final emailRegex =
                        RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
                    if (!emailRegex.hasMatch(value)) {
                      return 'يرجى إدخال إيميل صحيح';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                buildLabeledTextField(
                  'رقم الهاتف',
                  '+2200115556667',
                  Icons.phone,
                  controller: phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'رقم الهاتف مطلوب';
                    }
                    if (!RegExp(r'^\d+$').hasMatch(value)) {
                      return 'يرجى إدخال رقم هاتف صحيح';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                buildLabeledTextField(
                  'كلمة السر',
                  '●●●●●●●',
                  Icons.lock,
                  controller: passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'كلمة السر مطلوبة';
                    }
                    if (value.length < 6) {
                      return 'كلمة السر يجب أن تكون 6 أحرف أو أكثر';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                buildLabeledTextField(
                  'تاكيد كلمة السر',
                  '●●●●●●●',
                  Icons.lock,
                  controller: confirmPasswordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'تأكيد كلمة السر مطلوب';
                    }
                    if (value != passwordController.text) {
                      return 'كلمة السر وتأكيد كلمة السر غير متطابقين';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                signUpProvider.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await signUpProvider.signUpUser(
                              fName: firstNameController.text,
                              lName: lastNameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              password: passwordController.text,
                              confPassword: confirmPasswordController.text,
                              context: context,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: backgroundColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 130, vertical: 15),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        child: const Text(
                          'انشاء حساب',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLabeledTextField(
    String label,
    String hintText,
    IconData icon, {
    bool obscureText = false,
    TextEditingController? controller,
    String? Function(String?)? validator,
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
        TextFormField(
          controller: controller,
          textAlign: TextAlign.right,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            suffixIcon: Icon(icon),
            border: const OutlineInputBorder(),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
