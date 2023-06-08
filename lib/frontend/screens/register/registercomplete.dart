import 'package:flutter/material.dart';

class RegisterComplete extends StatefulWidget {
  const RegisterComplete({super.key});

  @override
  State<RegisterComplete> createState() => _RegisterCompleteState();
}

class _RegisterCompleteState extends State<RegisterComplete> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Text(
                  'Register Complete we will send you an email to verify your account'),
            ),
          ],
        ),
      ),
    );
  }
}
