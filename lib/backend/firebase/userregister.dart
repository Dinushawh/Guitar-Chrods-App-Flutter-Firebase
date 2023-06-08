import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guitarchords/backend/firebase/sendemailverification.dart';
import 'package:guitarchords/frontend/components/snakbars/globalsnackbar.dart';

Future registerAccount(BuildContext context,
    {required String password,
    required String email,
    required fullname}) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    createaccount(email: email, fullname: fullname);
    sendemailverifications(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      globalSnackbar(
        context: context,
        bgcolor: Colors.orangeAccent,
        message: 'The password provided is too weak.',
      );
    } else if (e.code == 'email-already-in-use') {
      globalSnackbar(
        bgcolor: Colors.red,
        context: context,
        message: 'The password provided is too weak.',
      );
    }
  } catch (e) {
    globalSnackbar(
      bgcolor: Colors.red,
      context: context,
      message: e.toString(),
    );
  }
}

Future createaccount({required String email, required String fullname}) async {
  await FirebaseFirestore.instance.collection('users').add({
    'email': email,
    'full name': fullname,
    'account type': 'user',
    'subscription': 'free',
    'subscription date': 'null',
    'date created': DateTime.now(),
    'profile picture': '',
  });
}
