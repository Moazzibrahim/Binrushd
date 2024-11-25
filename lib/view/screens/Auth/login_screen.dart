import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/view/screens/Auth/forget_password/forget_password_screen.dart';
import 'package:flutter_application_1/view/screens/Auth/sign_up_screen.dart';
import 'package:flutter_application_1/view/screens/tabs_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isChecked = false;
  int _selectedButtonIndex = -1;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey, // Wrap form for validation
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 50),
              Image.asset(
                'assets/images/login.png',
                height: 200,
              ),
              const SizedBox(height: 20),
              const Text(
                'اسم المستخدم',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w800),
                textAlign: TextAlign.end,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                  hintText: 'ادخل اسمك بالكامل',
                  suffixIcon: Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال اسم المستخدم';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'كلمة السر',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w800),
                textAlign: TextAlign.end,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                textAlign: TextAlign.right,
                obscureText: true,
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.visibility,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال كلمة السر';
                  } else if (value.length < 6) {
                    return 'يجب أن تكون كلمة السر مكونة من 6 أحرف على الأقل';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ForgetPasswordScreen()));
                    },
                    child: Text(
                      'نسيت كلمة السر؟',
                      style: TextStyle(
                          fontSize: 16,
                          color: backgroundColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: _isChecked,
                          onChanged: (val) {
                            setState(() {
                              _isChecked = val!;
                            });
                          }),
                      const Text('تذكرني'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Buttons as Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildSelectableButton('تسجيل الدخول', 0),
                  const SizedBox(height: 10),
                  buildSelectableButton('الدخول كزائر', 1),
                  const SizedBox(height: 10),
                  buildSelectableButton('إنشاء حساب', 2),
                ],
              ),
              const SizedBox(height: 16),
              const Center(child: Text('أو من خلال')),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Image.asset(
                      'assets/images/google.png',
                    ),
                    onTap: () {},
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  IconButton(
                    icon: const Icon(Icons.apple, color: Colors.black),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.facebook, color: Colors.blue),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSelectableButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedButtonIndex = index;
        });

        if (index == 0) {
          // Validate form before proceeding
          if (_formKey.currentState!.validate()) {
            final email = _emailController.text;
            final password = _passwordController.text;

            // Call the login function from LoginProvider
            Provider.of<LoginProvider>(context, listen: false)
                .login(email, password, context);
          }
        } else if (index == 1) {
          // Guest login action
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TabsScreen()));
        } else if (index == 2) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()));
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            _selectedButtonIndex == index ? backgroundColor : Colors.white,
        side: BorderSide(color: backgroundColor),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: _selectedButtonIndex == index ? Colors.white : Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
