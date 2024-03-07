import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login-page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.scale(
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color.fromARGB(255, 46, 53, 121),
              Color.fromARGB(255, 0, 95, 188),
            ],
            //! พื้นหลังจะเอาสีไรดี น้ำเงินหรือขาว
            // colors: [
            //   Colors.white,
            //   Colors.white,
            // ],
            
          ),
          childWidget: SizedBox(
            height: 300,
            width: 300,
            child: Image.asset("assets/images/logo_evt.png"),
          ),
          duration: const Duration(milliseconds: 2600),
          animationDuration: const Duration(milliseconds: 2000),
          onAnimationEnd: () => debugPrint("On Scale End"),
          nextScreen: LoginPage(),
        );
  }
}