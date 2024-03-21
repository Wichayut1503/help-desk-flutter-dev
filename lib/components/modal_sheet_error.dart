import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_button.dart';
import 'package:flutter_application_1/pages/main_page.dart';

class ModalSheetError extends StatelessWidget {
  final String errorMessage;

  const ModalSheetError({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyMainPage()),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 48),
            const Icon(
              Icons.error,
              color: Colors.red,
              size: 72,
            ),
            const SizedBox(height: 32),
            const Text(
              'เกิดข้อผิดพลาด',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 32),
            MyButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyMainPage()),
                );
              },
              btnName: "ย้อนกลับ",
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
