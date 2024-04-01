import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/modal_sheet.dart';
import 'package:flutter_application_1/components/textfield.dart';
import 'package:flutter_application_1/components/my_button.dart';
import 'package:flutter_application_1/services/account_service.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final apiUrl = AccountService.forgetPassword;
  final usernameController = TextEditingController();
  int status = 200;
  bool isButtonActive = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    usernameController.addListener(_checkInput);
  }

  void _checkInput() {
    setState(() {
      isButtonActive = usernameController.text.isNotEmpty &&
          EmailValidator.validate(usernameController.text);
    });
  }

  Future<void> postEmail() async {
    var response = await http.post(
      apiUrl,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": usernameController.text,
      }),
    );

    print(response.body);
    if (response.statusCode == 202) {
      showModalBottomSheet<void>(
        backgroundColor: Colors.white,
        context: _scaffoldKey.currentContext!,
        builder: (BuildContext context) {
          return ModalSheet(isSuccess: true, email: usernameController.text);
        },
      );
    } else {
      showModalBottomSheet<void>(
        backgroundColor: Colors.white,
        context: _scaffoldKey.currentContext!,
        builder: (BuildContext context) {
          return ModalSheet(
            isSuccess: false,
            email: usernameController.text,
          );
        },
      );
    }
    setState(() {
      status = response.statusCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          'กรุณากรอกอีเมลของคุณ เพื่อเปลี่ยนรหัสผ่าน',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              MyButton(
                onTap: () => postEmail(),
                isEnabled: isButtonActive,
                btnName: "ยืนยัน",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
