import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CircularImageWithToken extends StatefulWidget {
  final String imageUrl;
  final String token;
  final double radius;

  const CircularImageWithToken(
      {super.key,
      required this.imageUrl,
      required this.token,
      required this.radius});

  @override
  State<CircularImageWithToken> createState() => _CircularImageWithTokenState();
}

class _CircularImageWithTokenState extends State<CircularImageWithToken> {
  String? _imageBase64;
  bool _loadingFailed = false;

  @override
  void initState() {
    super.initState();
    _fetchImage();
  }

  Future<void> _fetchImage() async {
    try {
      final response = await http.get(
        Uri.parse(widget.imageUrl),
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${widget.token}'},
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        setState(() {
          _imageBase64 = base64Encode(response.bodyBytes);
        });
      } else {
        print('Failed to load image: ${response.statusCode}');
        setState(() {
          _loadingFailed = true;
        });
      }
    } catch (e) {
      print('Error fetching image: $e');
      setState(() {
        _loadingFailed = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: widget.radius * 2,
        height: widget.radius * 2,
        child: _loadingFailed // Fail to load image
            ? Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.person,
                  size: widget.radius * 2,
                  color: Colors.white,
                ),
              )
            : _imageBase64 != null
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    child: Image.memory(
                      base64Decode(_imageBase64!),
                      fit: BoxFit.cover,
                    ),
                  )
                : const CircularProgressIndicator(),
      ),
    );
  }
}
