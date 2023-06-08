import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guitarchords/firebase_options.dart';
import 'package:guitarchords/frontend/components/theme/apptheme.dart';
import 'package:guitarchords/frontend/screens/splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appThemeData.lightTheme,
      darkTheme: appThemeData.darkTheme,
      themeMode: ThemeMode.dark,
      home: const Splash(),
    );
  }
}
