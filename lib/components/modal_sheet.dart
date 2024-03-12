import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_button.dart';
import 'package:flutter_application_1/pages/authentication/login-page.dart';

class ModalSheet extends StatelessWidget {
  final bool isSuccess;
  final String email;

  const ModalSheet({Key? key, required this.isSuccess, required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imagePath =
        isSuccess ? "assets/images/correct.png" : "assets/images/cancel.png";
    String title = isSuccess ? "ตรวจสอบอีเมล" : "ไม่พบอีเมลในระบบ";
    String subTitle = isSuccess
        ? '''ระบบได้ส่งข้อความไปยังอีเมล $email
กรุณาตรวจสอบอีเมล เพื่อเปลี่ยนรหัสผ่าน'''
        : "อีเมล $email ไม่พบในระบบ กรุณาลองใหม่อีกครั้ง";
    final titleText = Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
    );

    final subTitleText = Text(
      subTitle,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
    );
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 48),
          Image.asset(
            imagePath,
            height: 72,
            width: 72,
          ),
          const SizedBox(height: 32),
          titleText,
          const SizedBox(height: 32),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: subTitleText),
          const SizedBox(height: 32),
          MyButton(
            onTap: () => isSuccess
                ? Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  )
                : Navigator.pop(context),
            btnName: "ยืนยัน",
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
