import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/global_service.dart';
import 'package:flutter_application_1/services/account_service.dart';
import 'package:flutter_application_1/interfaces/Account/account_details.dart';
import 'package:flutter_application_1/components/image_with_token.dart';
import 'package:http/http.dart' as http;

class ShowDetailAccountPage extends StatefulWidget {
  final dynamic userId;

  const ShowDetailAccountPage({super.key, required this.userId});

  @override
  _ShowDetailAccountPageState createState() => _ShowDetailAccountPageState();
}

class _ShowDetailAccountPageState extends State<ShowDetailAccountPage> {
  final bool _status = true;
  AccountDetails? _accountDetails;
  late String _token;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _token = GlobalService().accessToken;
    fetchAccountDetails();
  }

  Future<void> fetchAccountDetails() async {
    try {
      if (widget.userId == null) {
        throw Exception('User ID cannot be null');
      }
      print(_token);
      final response = await http.get(
        AccountService.accountDetails(widget.userId),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_token",
        },
      );
      if (response.statusCode == 200) {
        setState(() {
          _accountDetails = AccountDetails.fromJson(json.decode(response.body));
          _errorMessage = null;
        });
      } else {
        throw Exception('Failed to load account details');
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'Failed to load user details';
      });
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'รายละเอียดผู้ใช้',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: _errorMessage != null
          ? Center(child: Text(_errorMessage!))
          : _accountDetails == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: _accountDetails!.data!.imagePath != null
                              ? CircularImageWithToken(
                                  imageUrl: AccountService.userImage(
                                          _accountDetails!.data!.imagePath!) ??
                                      '',
                                  token: _token,
                                  radius: 90,
                                )
                              : const CircleAvatar(
                                  radius: 90,
                                  child: Icon(Icons.person, size: 90),
                                ),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _accountDetails!.data!.fullName ?? '-',
                              style: const TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _accountDetails!.data!.companyName ?? '-',
                              style: const TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        const Row(
                          children: [
                            Icon(
                              Icons.person_outline,
                              size: 18.0,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'ข้อมูลส่วนตัว',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'First Name',
                            hintText: _accountDetails!.data!.firstName ?? '-',
                            enabled: !_status,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 59, 57, 57)),
                            contentPadding: const EdgeInsets.fromLTRB(
                                12.0, 20.0, 12.0, 12.0),
                            border: InputBorder.none,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                            hintText: _accountDetails!.data!.lastName ?? '-',
                            enabled: !_status,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 59, 57, 57)),
                            contentPadding: const EdgeInsets.fromLTRB(
                                12.0, 20.0, 12.0, 12.0),
                            border: InputBorder.none,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Phone',
                            hintText: _accountDetails!.data!.phone ?? '-',
                            enabled: !_status,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 59, 57, 57)),
                            contentPadding: const EdgeInsets.fromLTRB(
                                12.0, 20.0, 12.0, 12.0),
                            border: InputBorder.none,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Company Name',
                            hintText: _accountDetails!.data!.companyName ?? '-',
                            enabled: !_status,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 59, 57, 57)),
                            contentPadding: const EdgeInsets.fromLTRB(
                                12.0, 20.0, 12.0, 12.0),
                            border: InputBorder.none,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Role Name',
                            hintText: _accountDetails!.data!.roleName ?? '-',
                            enabled: !_status,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 59, 57, 57)),
                            contentPadding: const EdgeInsets.fromLTRB(
                                12.0, 20.0, 12.0, 12.0),
                            border: InputBorder.none,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Department',
                            hintText: _accountDetails!.data!.department ?? '-',
                            enabled: !_status,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 59, 57, 57)),
                            contentPadding: const EdgeInsets.fromLTRB(
                                12.0, 20.0, 12.0, 12.0),
                            border: InputBorder.none,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Position',
                            hintText: _accountDetails!.data!.position ?? '-',
                            enabled: !_status,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 59, 57, 57)),
                            contentPadding: const EdgeInsets.fromLTRB(
                                12.0, 20.0, 12.0, 12.0),
                            border: InputBorder.none,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Created At',
                            hintText: _accountDetails!.data!.createdAt ?? '-',
                            enabled: !_status,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 59, 57, 57)),
                            contentPadding: const EdgeInsets.fromLTRB(
                                12.0, 20.0, 12.0, 12.0),
                            border: InputBorder.none,
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        const Row(
                          children: [
                            Icon(
                              Icons.security,
                              size: 18.0,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'ความปลอดภัย',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: _accountDetails!.data!.email ?? '-',
                            enabled: !_status,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 59, 57, 57)),
                            contentPadding: const EdgeInsets.fromLTRB(
                                12.0, 20.0, 12.0, 12.0),
                            border: InputBorder.none,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        const Row(
                          children: [
                            Icon(
                              Icons.work,
                              size: 18.0,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'โครงการที่เข้าร่วม',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),
    );
  }
}
