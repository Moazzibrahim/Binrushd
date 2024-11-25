import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/view/screens/Auth/forget_password/email_verification_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  int? _selectedOption; // Holds the selected card index (0 for phone, 1 for email)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        title: Text(
          'نسيت كلمة السر؟',
          style: TextStyle(color: backgroundColor, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            // Lock Icon
            Image.asset("assets/images/forget.png"),
            const SizedBox(height: 20),
            // Instruction Text
            Text(
              'قم بتحديد الطريقة التي تريد أن تسترد بها كلمة السر الخاصة بك.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 30),
            // Phone Option Card
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedOption = 0; // Select the phone option
                });
              },
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: _selectedOption == 0 ? backgroundColor : Colors.white,
                child: ListTile(
                  leading: Icon(Icons.sms,
                      color: _selectedOption == 0 ? Colors.white : backgroundColor),
                  title: Text(
                    'إرسال رمز عبر رسالة هاتفية',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _selectedOption == 0 ? Colors.white : Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    '+966 92 0000 181',
                    style: TextStyle(
                        color:
                            _selectedOption == 0 ? Colors.white70 : Colors.grey[700]),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Email Option Card
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedOption = 1; // Select the email option
                });
              },
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: _selectedOption == 1 ? backgroundColor : Colors.white,
                child: ListTile(
                  leading: Icon(Icons.email,
                      color: _selectedOption == 1 ? Colors.white : backgroundColor),
                  title: Text(
                    'إرسال رمز عبر الإيميل الخاص بك',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _selectedOption == 1 ? Colors.white : Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    'aa23@gmail.com',
                    style: TextStyle(
                        color:
                            _selectedOption == 1 ? Colors.white70 : Colors.grey[700]),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            // Send Button
            ElevatedButton(
              onPressed: _selectedOption != null
                  ? () {
                      // Navigate to the next screen (add logic based on selection if needed)
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const EmailConfirmationScreen()));
                    }
                  : null, // Disable button if no option is selected
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 150),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'إرسال',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
