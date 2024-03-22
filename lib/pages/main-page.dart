import 'dart:convert';
import 'package:flutter_application_1/interfaces/Account/detail-account.dart';
import 'package:flutter_application_1/pages/account/show-list-account.dart';
import 'package:flutter_application_1/pages/project/show-list-project.dart';
import 'package:flutter_application_1/services/account-service.dart';
import 'package:flutter_application_1/services/global-service.dart';
import 'package:flutter_application_1/style/colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/account/profile-page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MyMainPage extends StatefulWidget {
  const MyMainPage({Key? key}) : super(key: key);
  static final title = 'salomon_bottom_bar';
  @override
  State<MyMainPage> createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            // หน้า ShowList
            const ShowListAccount(),

            // หน้า Likes
            Container(
              child: const ShowListProject(),
            ),

            // หน้า Search
            Container(
              color: primary,
              child: const Center(
                child: Text("Search Page",
                    style: TextStyle(color: Colors.white, fontSize: 24.0)),
              ),
            ),

            // หน้า Profile
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: SalomonBottomBar(
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text("Home"),
              selectedColor: primary
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.favorite_border),
              title: const Text("Likes"),
              selectedColor: primary
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.search),
              title: const Text("Search"),
              selectedColor: primary
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.person),
              title: const Text("Profile"),
              selectedColor: primary
            ),
          ],
        ),
      ),
    );
  }
}
