import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/view/screens/Auth/forget_password/forget_password_screen.dart';
import 'package:flutter_application_1/view/screens/Auth/sign_up_screen.dart';
import 'package:flutter_application_1/view/screens/home_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isChecked = false;
  int _selectedButtonIndex = -1;
  bool _isPasswordVisible =
      false; // State variable to toggle password visibility

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
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.end,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'ادخل اسمك بالكامل',
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: const Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Rounded border
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.5),
                  ),
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
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.end,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                textAlign: TextAlign.right,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  hintText: "●●●●●●●",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible =
                            !_isPasswordVisible; // Toggle the state
                      });
                    },
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Rounded border
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.5),
                  ),
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
                      const Text("تذكرني"),
                      Checkbox(
                          value: _isChecked,
                          onChanged: (val) {
                            setState(() {
                              _isChecked = val!;
                            });
                          }),
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     IconButton(
                  //       icon: Image.asset('assets/images/google.png'),
                  //       onPressed: () {
                  //         // Handle Google login
                  //       },
                  //     ),
                  //     IconButton(
                  //       icon: Image.asset('assets/images/apple.png'),
                  //       onPressed: () {
                  //         // Handle Apple login
                  //       },
                  //     ),
                  //     IconButton(
                  //       icon: Image.asset(
                  //         'assets/images/Facebook.png',
                  //         height: 25,
                  //       ),
                  //       onPressed: () {
                  //         // Handle Facebook login
                  //       },
                  //     ),
                  //   ],
                  // ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSelectableButton(String text, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Rounded corners
        border: Border.all(
          color: _selectedButtonIndex == index
              ? Colors.transparent
              : backgroundColor,
          width: 2,
        ),
        color: _selectedButtonIndex == index ? backgroundColor : Colors.white,
      ),
      child: ElevatedButton(
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
                MaterialPageRoute(builder: (context) => const HomePage()));
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          }
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
              vertical: 15), // Increased padding for height
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10), // Match container's border radius
          ),
          elevation: 0, // Remove shadow
          backgroundColor: Colors.transparent, // Transparent for better control
        ),
        child: Text(
          text,
          style: TextStyle(
            color: _selectedButtonIndex == index ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
