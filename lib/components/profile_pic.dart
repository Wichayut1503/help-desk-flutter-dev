import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  final String imageUrl;
  final double width; // เปลี่ยนประเภทเป็น double
  final double height; // เปลี่ยนประเภทเป็น double

  const ProfilePic({
    Key? key,
    required this.imageUrl,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
        ],
      ),
    );
  }
}