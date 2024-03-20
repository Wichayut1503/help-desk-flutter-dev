import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImageWithToken extends StatefulWidget {
  final String imageUrl;
  final String token;

  const ImageWithToken({super.key, required this.imageUrl, required this.token});

  @override
  _ImageWithTokenState createState() => _ImageWithTokenState();
}

class _ImageWithTokenState extends State<ImageWithToken> {
  late http.Response _response;
  String? _imageBase64;

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
    return _imageBase64 != null
        ? Image.memory(
            base64Decode(_imageBase64!),
          )
        : const CircularProgressIndicator();
  }
}

class CircularImageWithToken extends StatefulWidget {
  final String imageUrl;
  final String token;
  final double radius;

  const CircularImageWithToken({
    super.key,
    required this.imageUrl,
    required this.token,
    this.radius = 70.0,
  });

  @override
  _CircularImageWithTokenState createState() => _CircularImageWithTokenState();
}

class _CircularImageWithTokenState extends State<CircularImageWithToken> {
  late http.Response _response;
  String? _imageBase64;

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
    return ClipOval(
      child: SizedBox(
        width: widget.radius * 2,
        height: widget.radius * 2,
        child: _imageBase64 != null
            ? Image.memory(
                base64Decode(_imageBase64!),
                fit: BoxFit.cover,
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
