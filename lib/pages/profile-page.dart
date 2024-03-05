import 'package:flutter/material.dart';

import 'package:flutter_application_1/components/profile_menu.dart';
import 'package:flutter_application_1/components/profile_pic.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: "assets/images/profile.png",
              press: () => {},
            ),
            ProfileMenu(
              text: "Settings",
              icon: "assets/images/setting.png",
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/images/logout.png",
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}