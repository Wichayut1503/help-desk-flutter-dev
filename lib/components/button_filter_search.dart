import 'package:flutter/material.dart';
import 'package:flutter_application_1/style/colors.dart';

class ButtonFilterSearch extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  final bool isActive;

  const ButtonFilterSearch({
    required this.onTap,
    required this.text,
    required this.isActive,
    Key? key,
  }) : super(key: key);

  @override
  _ButtonFilterSearchState createState() => _ButtonFilterSearchState();
}

class _ButtonFilterSearchState extends State<ButtonFilterSearch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: widget.isActive ? Colors.transparent : primary,
              width: 1.5,
            ),
            color: widget.isActive ? primary : Colors.transparent,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            widget.text,
            style: TextStyle(
              color: widget.isActive ? Colors.white : primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
