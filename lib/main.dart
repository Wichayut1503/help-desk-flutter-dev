import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login-page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'IBMPlexSans',
      ),
    );
  }
}


//! Form Send To Api
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter POST Request Example',
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final apiUrl = Uri.parse("https://jsonplaceholder.typicode.com/posts");
//   TextEditingController titleController = TextEditingController();
//   TextEditingController bodyController = TextEditingController();

//   Future<void> sendPostRequest() async {
//     var response = await http.post(apiUrl,
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({
//           "title": titleController.text,
//           "body": bodyController.text,
//           "userId": 1,
//         }));

//     if (response.statusCode == 201) {
//       print(response.body);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text("Post created successfully!"),
//       ));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text("Failed to create post!"),
//       ));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter POST Request Example'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             TextField(
//               controller: titleController,
//               decoration: InputDecoration(hintText: "Title"),
//             ),
//             TextField(
//               controller: bodyController,
//               decoration: InputDecoration(hintText: "Body"),
//             ),
//             ElevatedButton(
//               onPressed: sendPostRequest,
//               child: Text("Create Post"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
