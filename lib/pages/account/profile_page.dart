import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/image_token.dart';
import 'package:flutter_application_1/interfaces/Account/my_account.dart';
import 'package:flutter_application_1/services/account_service.dart';
import 'package:flutter_application_1/services/global_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/components/profile_menu.dart';
import 'package:flutter_application_1/components/profile_pic.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<MyAccount> myAccount;
  static const double _radius = 90;

  @override
  void initState() {
    super.initState();
    myAccount = getDataAccount(GlobalService().accessToken);
  }

  Future<MyAccount> getDataAccount(String token) async {
    final response = await http.get(
      AccountService.myAccount,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return MyAccount.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception("Failed to load");
    }
  }

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
        child: FutureBuilder<MyAccount>(
          future: myAccount,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Show loading indicator while fetching data
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final email = snapshot.data?.data?.fullName ?? 'not found';
              return Column(
                children: [
                  const SizedBox(height: 16),
                  CircularImageWithToken(
                    imageUrl: AccountService.getUserImage(
                            snapshot.data?.data?.imagePath) ??
                        '',
                    token: GlobalService().accessToken,
                    radius: _radius,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      email,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
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
              );
            }
          },
        ),
      ),
    );
  }
}
