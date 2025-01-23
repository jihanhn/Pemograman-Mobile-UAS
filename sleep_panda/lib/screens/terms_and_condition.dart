import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        backgroundColor: Color(0xff009090),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Terms and Conditions',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 20),
              Text(
                '1. Introduction\n\n'
                'These terms and conditions govern your use of this app and its features. By using this app, you agree to abide by the following terms and conditions.\n\n'
                '2. User Responsibility\n\n'
                'You are responsible for maintaining the confidentiality of your account and ensuring that your usage of the app complies with applicable laws.\n\n'
                '3. Privacy Policy\n\n'
                'Your personal data will be handled according to our privacy policy, which is available on our website.\n\n'
                '4. Limitation of Liability\n\n'
                'We are not liable for any damages arising from your use of the app.\n\n'
                '5. Termination\n\n'
                'We may suspend or terminate your access to the app at any time if you violate these terms.\n\n'
                '6. Governing Law\n\n'
                'These terms and conditions are governed by the laws of the jurisdiction in which the app is operating.\n\n'
                'By using this app, you acknowledge that you have read and agree to these terms.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
