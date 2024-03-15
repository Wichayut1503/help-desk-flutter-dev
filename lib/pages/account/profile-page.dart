import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/interfaces/Account/my-account.dart';
import 'package:flutter_application_1/services/account-service.dart';
import 'package:flutter_application_1/services/global-service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/components/profile_menu.dart';
import 'package:flutter_application_1/components/profile_pic.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<MyAccount> myAccount;

  @override
  void initState() {
    super.initState();
    myAccount = getDataAccount(GlobalService().accessToken);
  }

  Future<MyAccount> getDataAccount(String token) async {
    final response = await http.get(
      AccountService.MyAccount,
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
              return CircularProgressIndicator(); // Show loading indicator while fetching data
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final fullName = snapshot.data?.data?.fullName ?? 'not found';
              return Column(
                children: [
                  const SizedBox(height: 16),
                  ProfilePic(
                    imageUrl: 'https://scontent.futp1-2.fna.fbcdn.net/v/t1.6435-1/107668505_910667609453715_3947543465436588929_n.jpg?stp=dst-jpg_p480x480&_nc_cat=109&ccb=1-7&_nc_sid=5f2048&_nc_ohc=aVOiVL5W0GYAX8CoXYI&_nc_ht=scontent.futp1-2.fna&oh=00_AfAkcU019ueVtn9PpccAkX9F8Elyj0b4Y8sTxYfI8Aiwlw&oe=6617EEB0',
                    width: 176,
                    height: 176,
                    
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      fullName,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
