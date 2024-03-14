import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/global-service.dart';
import 'package:flutter_application_1/services/account-service.dart';
import 'package:flutter_application_1/interfaces/Account/account-details.dart';
import 'package:http/http.dart' as http;

/*class DetailAccountPage extends StatefulWidget {
  final int? userId;

  const DetailAccountPage({Key? key, required this.userId}) : super(key: key);

  @override
  _DetailAccountPageState createState() => _DetailAccountPageState();
}

class _DetailAccountPageState extends State<DetailAccountPage> {
  late Future<AccountDetails> _futureDetailAccount;

  @override
  void initState() {
    super.initState();
    _futureDetailAccount =
        fetchDetailAccount(widget.userId, GlobalService().accessToken);
  }

  Future<AccountDetails> fetchDetailAccount(int? userId, String token) async {
    if (userId == null) {
      throw Exception('User ID cannot be null');
    }

    final response = await http.get(
      AccountService.accountDetails(userId),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return AccountDetails.fromJson(jsonData);
    } else {
      throw Exception('Failed to load user details: ${response.statusCode}');
    }
  }

}
*/
class AccountDetailPage extends StatefulWidget {
  final userId;

  const AccountDetailPage({Key? key, required this.userId}) : super(key: key);

  @override
  _AccountDetailPageState createState() => _AccountDetailPageState();
}

class _AccountDetailPageState extends State<AccountDetailPage> {
  AccountDetails? _accountDetails;
  late String _token;

  @override
  void initState() {
    super.initState();
    _token = GlobalService().accessToken;
    fetchAccountDetails();
  }

  Future<void> fetchAccountDetails() async {
    try {
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
        });
      } else {
        throw Exception('Failed to load account details');
      }
    } catch (error) {
      print('Error: $error');
      // Handle error gracefully
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Details'),
      ),
      body: _accountDetails == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID: ${_accountDetails!.data!.id}'),
                  Text('Email: ${_accountDetails!.data!.email}'),
                  Text('Full Name: ${_accountDetails!.data!.fullName}'),
                  Text('Company Name: ${_accountDetails!.data!.companyName}'),
                  // Add more fields as needed
                ],
              ),
            ),
    );
  }
}