import 'package:flutter/material.dart';
import 'package:flutter_application_1/interfaces/Project/detail-project.dart';

class DetailProjectPage extends StatelessWidget {
  final int? projectId;

  const DetailProjectPage({Key? key, required this.projectId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Project Detail'),
      ),
      body: Center(
        child: Text('Project ID: ${projectId ?? "Unknown"}'),
      ),
    );
  }
}

