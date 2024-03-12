import 'package:http/http.dart' as http;

class AccountService {
  String baseUrl = "http://dekdee2.informatics.buu.ac.th:8019/api/";
  static Uri AuthLogin =
      Uri.parse("http://dekdee2.informatics.buu.ac.th:8019/api/auth/login");

  static Uri MyAccount =
      Uri.parse("http://dekdee2.informatics.buu.ac.th:8019/api/users/detail");

  static Uri ListUsers(int page, int size, String sort) {
    return Uri.parse(
        // "http://dekdee2.informatics.buu.ac.th:8019/api/users?page=$page&size=$size&sort=$sort");
        "http://dekdee2.informatics.buu.ac.th:8019/api/users?page=$page&size=$size&sort=$sort");
  }
}
