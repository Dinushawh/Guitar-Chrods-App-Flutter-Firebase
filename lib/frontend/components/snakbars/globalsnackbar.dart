import 'package:flutter/material.dart';

void globalSnackbar(
    {required String message, required context, required bgcolor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: bgcolor,
    ),
  );
}

void actionsnackbarwitherifiers(
    {required String message,
    required context,
    required bgcolor,
    required action,
    required email,
    required password}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: bgcolor,
      action: SnackBarAction(
        label: action,
        textColor: Colors.white,
        onPressed: () async {
          // action == 'Resend'
          // ? sendemailverifications(email: '', password: '')
          // : print('No Action');
        },
      ),
      duration: const Duration(seconds: 30),
    ),
  );
}

void actionsnackbar(
    {required String message,
    required context,
    required bgcolor,
    required action}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: bgcolor,
      action: SnackBarAction(
        label: action,
        textColor: Colors.white,
        onPressed: () async {
          // action == 'Resend'
          // ? sendemailverifications(email: '', password: '')
          // : print('No Action');
        },
      ),
      duration: const Duration(seconds: 10),
    ),
  );
}
