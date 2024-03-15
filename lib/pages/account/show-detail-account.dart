import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/global-service.dart';
import 'package:flutter_application_1/services/account-service.dart';
import 'package:flutter_application_1/interfaces/Account/account-details.dart';
import 'package:http/http.dart' as http;

class AccountDetailPage extends StatefulWidget {
  final dynamic userId;

  const AccountDetailPage({Key? key, required this.userId}) : super(key: key);

  @override
  _AccountDetailPageState createState() => _AccountDetailPageState();
}

class _AccountDetailPageState extends State<AccountDetailPage> {
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
          _errorMessage = null; // Reset error message if successful
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
        title: const Text('Account Details'),
      ),
      body: _errorMessage != null
          ? Center(child: Text(_errorMessage!))
          : _accountDetails == null
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${_accountDetails!.data!.id}'),
                      Text('Email: ${_accountDetails!.data!.email}'),
                      Text('Full Name: ${_accountDetails!.data!.fullName}'),
                      Text('First Name: ${_accountDetails!.data!.firstName}'),
                      Text('Last Name: ${_accountDetails!.data!.lastName}'),
                      Text('Phone: ${_accountDetails!.data!.phone}'),
                      Text('Image Path: ${_accountDetails!.data!.imagePath}'),
                      Text('Company ID: ${_accountDetails!.data!.companyId}'),
                      Text('Company Name: ${_accountDetails!.data!.companyName}'),
                      Text('Role Name: ${_accountDetails!.data!.roleName}'),
                      Text('Department: ${_accountDetails!.data!.department}'),
                      Text('Position: ${_accountDetails!.data!.position}'),
                      Text('Created At: ${_accountDetails!.data!.createdAt}'),
                    ],
                  ),
                ),
    );
  }
}
