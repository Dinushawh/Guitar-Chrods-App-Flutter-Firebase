// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guitarchords/frontend/components/snakbars/globalsnackbar.dart';
import 'package:guitarchords/frontend/screens/home/home.dart';
import 'package:guitarchords/frontend/screens/login/login.dart';

Future firebaselogin(
  BuildContext context, {
  required String email,
  required String password,
}) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (credential.user!.emailVerified) {
      print("Email Verified");
      userSession(
        email: email,
        sessionType: 'firebase',
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(
            accountType: email,
            email: email,
          ),
        ),
      );
    } else {
      actionsnackbarwitherifiers(
        context: context,
        bgcolor: Colors.red,
        message:
            'Please verify your email please check your email and click on the link to verify your email',
        action: 'Resend',
        email: email,
        password: password,
      );

      print("Email Not Verified");
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      globalSnackbar(
        context: context,
        bgcolor: Colors.red,
        message: 'No user found for that email.',
      );
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      globalSnackbar(
        context: context,
        bgcolor: Colors.red,
        message: 'Wrong password provided for that user.',
      );
      print('Wrong password provided for that user.');
    }
  }
}
