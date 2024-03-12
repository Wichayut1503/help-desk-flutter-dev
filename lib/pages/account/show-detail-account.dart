import 'package:flutter/material.dart';
import 'package:flutter_application_1/interfaces/Account/detail-account.dart';

class DetailAccountPage extends StatelessWidget {
  final int? userId;

  const DetailAccountPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('User Detail'),
      ),
      body: Center(
        child: Text('User ID: ${userId ?? "Unknown"}'),
      ),
    );
  }
}
