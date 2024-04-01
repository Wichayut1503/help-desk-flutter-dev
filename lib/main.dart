import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/splash_page.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'IBMPlexSans',
      ),
    );
  }
}
