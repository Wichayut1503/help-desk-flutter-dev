import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/authentication/login-page.dart';
import 'package:flutter_application_1/pages/splash-page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'IBMPlexSans',
      ),
    );
  }
}
