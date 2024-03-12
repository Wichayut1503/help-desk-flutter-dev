import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_button.dart';
import 'package:flutter_application_1/components/textfield.dart';
import 'package:flutter_application_1/pages/authentication/forgot-password-page.dart';
import 'package:flutter_application_1/pages/main-page.dart';
import 'package:flutter_application_1/services/account-service.dart';
import 'package:flutter_application_1/services/global-service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  int status = 200;
  bool isButtonActive = false;

//! เอาไว้เช็คค่าของช่องกรอกข้อมูล
  @override
  void initState() {
    super.initState();
    usernameController.addListener(_checkInput);
    passwordController.addListener(_checkInput);
  }

  //! เอาไว้เช็คค่าของช่องกรอกข้อมูล
  void _checkInput() {
    setState(() {
      isButtonActive = usernameController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          EmailValidator.validate(usernameController.text) &&
          passwordController.text.length >= 8;
    });
  }

  Future<void> signUserIn(BuildContext context) async {
    var response = await http.post(
      AccountService.AuthLogin,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": usernameController.text,
        "password": passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      String jsonString = response.body;

      Map<String, dynamic> data = json.decode(jsonString);

      String accessToken = data['data']['accessToken'];
      GlobalService().accessToken = accessToken;
      setState(() {
        status = response.statusCode;
      });
      Fluttertoast.showToast(
          msg: "Login successfully!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color.fromARGB(255, 99, 190, 0));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyMainPage(),
        ),
      );
    } else {
      setState(() {
        status = response.statusCode;
      });
      Fluttertoast.showToast(
          msg: "Failed to Login !",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 219, 0, 0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Image.asset('assets/images/logo_evt.png'),
                const SizedBox(height: 50),
                const SizedBox(height: 25),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          'อีเมล',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
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
                const SizedBox(height: 24),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          'รหัสผ่าน',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
                MyTextField(
                  controller: passwordController,
                  hintText: 'กรุณากรอกข้อมูล',
                  obscureText: true,
                  statusHttp: status,
                  updateStatus: (newStatus) {
                    setState(() {
                      status = newStatus;
                    });
                  },
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Are you an admin ?',
                        style: TextStyle(
                            color: Color.fromARGB(255, 117, 117, 117)),
                      ),
                      Text(
                        ' Login',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 84, 68),
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                MyButton(
                  onTap: () => signUserIn(context),
                  isEnabled: isButtonActive,
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPassword()));
                        },
                        child: const Text("ลืมรหัสผ่าน ?",
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 95, 188),
                                fontWeight: FontWeight.bold)))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
