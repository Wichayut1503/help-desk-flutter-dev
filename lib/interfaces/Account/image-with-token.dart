import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImageWithToken extends StatefulWidget {
  final String imageUrl;
  final String token;

  const ImageWithToken(
      {super.key, required this.imageUrl, required this.token});

  @override
  _ImageWithTokenState createState() => _ImageWithTokenState();
}

class _ImageWithTokenState extends State<ImageWithToken> {
  late http.Response _response;
  late String _imageBase64;

  @override
  void initState() {
    super.initState();
    _fetchImage();
  }

  Future<void> _fetchImage() async {
    _response = await http.get(
      Uri.parse(widget.imageUrl),
      headers: {HttpHeaders.authorizationHeader: 'Bearer ${widget.token}'},
    );

    setState(() {
      _imageBase64 = base64Encode(_response.bodyBytes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _imageBase64.isNotEmpty
        ? Image.memory(
            base64Decode(_imageBase64),
          )
        : const CircularProgressIndicator();
  }
}
