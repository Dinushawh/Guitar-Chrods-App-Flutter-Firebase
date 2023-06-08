import 'package:firebase_auth/firebase_auth.dart';

Future sendemailverifications(
    {required String email, required String password}) async {
  await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password)
      .then((value) =>
          FirebaseAuth.instance.currentUser!.sendEmailVerification());
}
