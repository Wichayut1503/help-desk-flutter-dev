// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/components/textfield.dart';

// class MyForgotPassword extends StatelessWidget {
//   const MyForgotPassword({super.key});

//   @override

//   Widget build(BuildContext context) {
// return Scaffold(
//   backgroundColor: Colors.white,
//   appBar: AppBar(
//     leading: IconButton(
//       icon: const Icon(
//         Icons.arrow_back_ios_new_rounded,
//         color: Colors.black,
//       ),
//       onPressed: () => Navigator.of(context).pop(),
//     ),
//     title: const Text(
//       "ลืมรหัสผ่าน",
//       style: TextStyle(fontWeight: FontWeight.w700),
//     ),
//   ),
//   body: SafeArea(
//     child: Center(
//       child: Column(
//         children: [
//           MyTextField(
//             controller: usernameController,
//             hintText: 'กรุณากรอกข้อมูล',
//             obscureText: false,
//             statusHttp: status,
//             updateStatus: (newStatus) {
//               setState(() {
//                 status = newStatus;
//               });
//             },
//             showErrorMessage: false,
//           ),
//           const SizedBox(height: 24),
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 25.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(bottom: 8),
//                   child: Text(
//                     'รหัสผ่าน',
//                     style: TextStyle(fontWeight: FontWeight.w700),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           MyTextField(
//             controller: passwordController,
//             hintText: 'กรุณากรอกข้อมูล',
//             obscureText: true,
//             statusHttp: status,
//             updateStatus: (newStatus) {
//               setState(() {
//                 status = newStatus;
//               });
//             },
//           ),
//           const SizedBox(height: 10),
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 25.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(
//                   'Are you a admin ?',
//                   style:
//                       TextStyle(color: Color.fromARGB(255, 117, 117, 117)),
//                 ),
//                 Text(
//                   ' Login',
//                   style: TextStyle(
//                     color: Color.fromARGB(255, 255, 84, 68),
//                     fontWeight: FontWeight.w700,
//                   ),
//                 )
//               ],
//             ),
//           ),
//           const SizedBox(height: 25),
//           MyButton(
//             onTap: () => signUserIn(context),
//             isEnabled: isButtonActive,
//           ),
//           const SizedBox(height: 16),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Divider(
//                     thickness: 0.5,
//                     color: Colors.grey[400],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 24),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Text('ลืมรหัสผ่าน ?',
//               //     style: TextStyle(
//               //         color: Color.fromARGB(255, 0, 95, 188),
//               //         fontWeight: FontWeight.bold))
//               TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) =>
//                                 const MyForgotPassword()));
//                   },
//                   child: const Text("ลืมรหัสผ่าน ?",
//                       style: TextStyle(
//                           color: Color.fromARGB(255, 0, 95, 188),
//                           fontWeight: FontWeight.bold)))
//             ],
//           )
//         ],
//       ),
//     ),
//   ),
// );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_button.dart';
import 'package:flutter_application_1/components/textfield.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final usernameController = TextEditingController();
  int status = 200;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "ลืมรหัสผ่าน",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 32),
              MyTextField(
                controller: usernameController,
                hintText: 'กรุณากรอกข้อมูล',
                obscureText: false,
                statusHttp: status,
                updateStatus: (newStatus) {
                  setState(() {
                    status = newStatus;
                  });
                },
                showErrorMessage: false,
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        'กรุณากรอกอีเมลของคุณ เพื่อเปลี่ยนรหัสผ่าน ',
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
