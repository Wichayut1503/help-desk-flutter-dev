import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final bool isEnabled;
  final String btnName;

  const MyButton(
      {super.key,
      required this.onTap,
      this.isEnabled = true,
      this.btnName = "เข้าสู่ระบบ"});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled
          ? onTap
          : null, //* ถ้าค่าเป็น false ปุ่มคลิกไม่ได้ ถ้า true ปุ่มคลิกได้
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isEnabled
              ? const Color.fromARGB(255, 0, 95, 188)
              : const Color.fromARGB(255, 234, 240, 245),
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Text(
            btnName,
            style: TextStyle(
              color: isEnabled
                  ? Colors.white
                  : const Color.fromARGB(255, 138, 159, 171),
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
