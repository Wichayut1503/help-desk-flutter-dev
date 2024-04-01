import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/global_service.dart';
import 'package:flutter_application_1/services/account_service.dart';
import 'package:flutter_application_1/interfaces/Account/account_details.dart';
import 'package:flutter_application_1/interfaces/Account/user_project.dart';
import 'package:flutter_application_1/components/image_token.dart';
import 'package:flutter_application_1/components/modal_sheet_error.dart';
import 'package:http/http.dart' as http;

class ShowDetailAccountPage extends StatefulWidget {
  final dynamic userId;

  const ShowDetailAccountPage({Key? key, required this.userId})
      : super(key: key);

  @override
  State<ShowDetailAccountPage> createState() => _ShowDetailAccountPageState();
}

class _ShowDetailAccountPageState extends State<ShowDetailAccountPage> {
  final bool _status = true;
  AccountDetails? _accountDetails;
  List<UserProject> _userProjects = [];
  late String _token;
  String? _errorMessage;
  static const double _radius = 90;
  bool _isErrorModalShown = false;

  @override
  void initState() {
    super.initState();
    _token = GlobalService().accessToken;
    fetchAccountDetails();
    fetchUserProjects();
  }

  Future<void> fetchAccountDetails() async {
    try {
      if (widget.userId == null) {
        throw Exception('User ID cannot be null');
      }
      final response = await http.get(
        AccountService.getAccountDetails(widget.userId),
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
    }
  }

  Future<void> fetchUserProjects() async {
    try {
      final response = await http.get(
        AccountService.getUserProjects(widget.userId),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_token",
        },
      );

      if (response.statusCode == 200) {
        String responseBody =
            utf8.decode(response.bodyBytes); // แก้ให้แสดงภาษาไทยถูกต้อง
        Map<String, dynamic> decodedData = json.decode(responseBody);
        List<dynamic> projectsJson = decodedData['content'];
        setState(() {
          _userProjects =
              projectsJson.map((json) => UserProject.fromJson(json)).toList();
        });
      } else {
        throw Exception('Failed to load user projects');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Widget _buildErrorModal(BuildContext context) {
    if (!_isErrorModalShown) {
      _isErrorModalShown = true;
      Future.delayed(Duration.zero, () {
        showModalBottomSheet(
          enableDrag: false,
          context: context,
          builder: (BuildContext context) {
            return ModalSheetError(errorMessage: _errorMessage!);
          },
        );
      });
    }
    return Container();
  }

  Widget _buildUserHeader() {
    return Center(
      child: Column(
        children: [
          _accountDetails!.data!.imagePath != null
              ? CircularImageWithToken(
                  imageUrl: AccountService.getUserImage(
                          _accountDetails!.data!.imagePath!) ??
                      '',
                  token: _token,
                  radius: _radius,
                )
              : Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.person,
                    size: _radius * 2,
                    color: Colors.white,
                  ),
                ),
          const SizedBox(height: 20.0),
          Text(
            _accountDetails!.data!.fullName ?? '-',
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            _accountDetails!.data!.companyName ?? '-',
            style: const TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 202, 202, 202),
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget _buildPersonalInfo() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5, 
            offset: const Offset(0, 2), 
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                    fontFamily: 'IBMPlexSans',
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
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 59, 57, 57)),
                contentPadding:
                    const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 12.0),
                border: InputBorder.none,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Last Name',
                hintText: _accountDetails!.data!.lastName ?? '-',
                enabled: !_status,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 59, 57, 57)),
                contentPadding:
                    const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 12.0),
                border: InputBorder.none,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Phone',
                hintText: _accountDetails!.data!.phone ?? '-',
                enabled: !_status,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 59, 57, 57)),
                contentPadding:
                    const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 12.0),
                border: InputBorder.none,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Company Name',
                hintText: _accountDetails!.data!.companyName ?? '-',
                enabled: !_status,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 59, 57, 57)),
                contentPadding:
                    const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 12.0),
                border: InputBorder.none,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Role Name',
                hintText: _accountDetails!.data!.roleName ?? '-',
                enabled: !_status,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 59, 57, 57)),
                contentPadding:
                    const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 12.0),
                border: InputBorder.none,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Department',
                hintText: _accountDetails!.data!.department ?? '-',
                enabled: !_status,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 59, 57, 57)),
                contentPadding:
                    const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 12.0),
                border: InputBorder.none,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Position',
                hintText: _accountDetails!.data!.position ?? '-',
                enabled: !_status,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 59, 57, 57)),
                contentPadding:
                    const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 12.0),
                border: InputBorder.none,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Created At',
                hintText: _accountDetails!.data!.createdAt ?? '-',
                enabled: !_status,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 59, 57, 57)),
                contentPadding:
                    const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 12.0),
                border: InputBorder.none,
              ),
            ),
            // ส่วนอื่น ๆ ของข้อมูลส่วนตัว
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityInfo() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2), 
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: _accountDetails!.data!.email ?? '-',
                enabled: !_status,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 59, 57, 57)),
                contentPadding:
                    const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 12.0),
                border: InputBorder.none,
              ),
            ),
            // ส่วนอื่น ๆ ของความปล
          ],
        ),
      ),
    );
  }

  Widget _buildProjectInfo() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2), 
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
            const SizedBox(height: 10.0),
            _userProjects.isEmpty
                ? const Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Text(
                      'ไม่มีโครงการที่เข้าร่วม',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _userProjects.length,
                    itemBuilder: (context, index) {
                      final project = _userProjects[index];
                      Icon statusIcon;
                      String statusDescription;
                      switch (project.status) {
                        case 'ACTIVE':
                          statusIcon = const Icon(Icons.check_circle,
                              color: Colors.green);
                          statusDescription = 'เข้าร่วม';
                          break;
                        case 'IN_ACTIVE':
                          statusIcon = const Icon(Icons.remove_circle,
                              color: Colors.grey);
                          statusDescription = 'สิ้นสุด';
                          break;
                        default:
                          statusIcon =
                              const Icon(Icons.info, color: Colors.grey);
                          statusDescription = 'Unknown';
                      }
                      return ListTile(
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            statusIcon,
                          ],
                        ),
                        title: Text(project.name),
                        subtitle: Text(statusDescription),
                        onTap: () {
                          // Handle project tap
                        },
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'รายละเอียดผู้ใช้',
          style: TextStyle(color: Colors.black, fontFamily: 'IBMPlexSans', ),
        ),
      ),
      body: _errorMessage != null
          ? _buildErrorModal(context)
          : _accountDetails == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildUserHeader(),
                        _buildPersonalInfo(),
                        const SizedBox(height: 20),
                        _buildSecurityInfo(),
                        const SizedBox(height: 20),
                        _buildProjectInfo(),
                      ],
                    ),
                  ),
                ),
    );
  }
}
