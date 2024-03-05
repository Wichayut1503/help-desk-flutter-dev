import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final int statusHttp;
  final Function(int) updateStatus;
  final bool showErrorMessage; 

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.statusHttp,
    required this.updateStatus,
    this.showErrorMessage = true,
    
  }) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late Color borderColor;

  @override
  void initState() {
    super.initState();
    _updateBorderColor();
  }

  @override
  void didUpdateWidget(MyTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateBorderColor();
  }

  void _updateBorderColor() {
    setState(() {
      borderColor = widget.statusHttp == 400 ? Colors.red : const Color.fromARGB(255, 188, 204, 214);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            controller: widget.controller,
            obscureText: widget.obscureText,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.statusHttp == 400
                        ? Color.fromARGB(255, 219, 0, 0)
                        : Color.fromARGB(255, 0, 95, 188)),
                borderRadius: BorderRadius.circular(10),
              ),
              fillColor: Colors.white,
              filled: true,
              hintText: widget.hintText,
              hintStyle: TextStyle(color: widget.statusHttp == 400
                        ? Color.fromARGB(255, 219, 0, 0)
                        : Color.fromARGB(255, 138, 159, 171),
                        fontWeight: FontWeight.w400),
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (widget.showErrorMessage && widget.statusHttp == 400)
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    "อีเมลหรือรหัสผ่านไม่ถูกต้อง",
                    style: TextStyle(color: Color.fromARGB(255, 219, 0, 0)),
                  ),
                ),
              ],
            )
      ],
    );
  }
}
