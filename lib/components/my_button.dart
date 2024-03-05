import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final bool isEnabled;

  const MyButton({Key? key, required this.onTap, this.isEnabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null, //* ถ้าค่าเป็น false ปุ่มคลิกไม่ได้ ถ้า true ปุ่มคลิกได้
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
            "เข้าสู่ระบบ",
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
