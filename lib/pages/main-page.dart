import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/profile-page.dart';
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
            
            // หน้า Home
            Container(
              color: Colors.purple,
              child: const Center(
                child: Text("Home Page",
                    style: TextStyle(color: Colors.white, fontSize: 24.0)),
              ),
            ),

            // หน้า Likes
            Container(
              color: Colors.pink,
              child: const Center(
                child: Text("Likes Page",
                    style: TextStyle(color: Colors.white, fontSize: 24.0)),
              ),
            ),

            // หน้า Search
            Container(
              color: Colors.orange,
              child: const Center(
                child: Text("Search Page",
                    style: TextStyle(color: Colors.white, fontSize: 24.0)),
              ),
            ),

            // หน้า Profile
            const ProfileScreen(),
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
              selectedColor: Colors.purple,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.favorite_border),
              title: const Text("Likes"),
              selectedColor: Colors.pink,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.search),
              title: const Text("Search"),
              selectedColor: Colors.orange,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.person),
              title: const Text("Profile"),
              selectedColor: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}
