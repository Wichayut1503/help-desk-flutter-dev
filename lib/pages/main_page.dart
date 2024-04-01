import 'package:flutter_application_1/pages/account/show_account_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/account/profile_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MyMainPage extends StatefulWidget {
  const MyMainPage({super.key});
  static const title = 'salomon_bottom_bar';
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
            const ShowAccountList(),

            // หน้า Profile
            const ProfilePage(),
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
              selectedColor: const Color.fromARGB(255, 0, 95, 188)
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.person),
              title: const Text("Profile"),
              selectedColor: const Color.fromARGB(255, 0, 95, 188),
            ),
          ],
        ),
      ),
    );
  }
}
