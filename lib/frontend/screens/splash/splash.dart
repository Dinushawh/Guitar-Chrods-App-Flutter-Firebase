// ignore_for_file: avoid_print, unused_local_variable, unrelated_type_equality_checks

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guitarchords/backend/login/loginsession.dart';
import 'package:guitarchords/frontend/screens/home/home.dart';
import 'package:guitarchords/frontend/screens/login/login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

Future logginWithPreviosData() async {
  if (FirebaseAuth.instance.currentUser != null) {
    print('${FirebaseAuth.instance.currentUser!.email} already signed In');
    return 'signed-in';
  } else {
    print('No user signed In using this device');
    return 'signed-out';
  }
}

navigateToLoggin({required BuildContext context}) {
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return const Login();
      },
    ),
  );
}

navigateToHome(
    {required BuildContext context,
    required String accountType,
    required String email}) {
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Home(
          accountType: accountType,
          email: email,
        );
      },
    ),
  );
}

class _SplashState extends State<Splash> {
  late final Timer _runsplash;
  Timer getTimer() {
    return Timer(
      const Duration(seconds: 5),
      () {
        getMapList('userLoggedInToken').then(
          (value) => print(value),
        );
        sessionManager().then((result) {
          bool isUserLoggedIn = result['isUserLoggedIn'];
          List<Map<String, dynamic>>? userLoggedInData =
              result['userLoggedInData'];
          print(userLoggedInData);
          isUserLoggedIn == false
              ? navigateToLoggin(context: context)
              : userLoggedInData![0]['userLoggedInData'] == 'local'
                  ? navigateToHome(
                      context: context, accountType: 'local', email: 'guest')
                  : logginWithPreviosData().then(
                      (value) => (value == 'signed-out')
                          ? navigateToLoggin(context: context)
                          : navigateToHome(
                              context: context,
                              accountType: 'user',
                              email: FirebaseAuth.instance.currentUser!.email
                                  .toString()),
                    );
        });
      },
    );
  }

  @override
  void initState() {
    _runsplash = getTimer();
    super.initState();
  }

  @override
  void dispose() {
    _runsplash.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Image.asset('assets/logos/logo.png')
                : Image.asset('assets/logos/logo.png'),
          ),
        ],
      )),
    );
  }
}
