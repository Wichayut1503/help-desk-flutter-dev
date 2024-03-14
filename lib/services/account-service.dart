import 'package:http/http.dart' as http;

class AccountService {
  String baseUrl = "http://dekdee2.informatics.buu.ac.th:8019/api/";
  static Uri authLogin =
      Uri.parse("http://dekdee2.informatics.buu.ac.th:8019/api/auth/login");

  static Uri myAccount =
      Uri.parse("http://dekdee2.informatics.buu.ac.th:8019/api/users/detail");

  static Uri accountDetails(int userId) {
    return Uri.parse("http://dekdee2.informatics.buu.ac.th:8019/api/users/$userId");
  }

  static Uri listUsers(int page, int size, String sort) {
    return Uri.parse(
        // "http://dekdee2.informatics.buu.ac.th:8019/api/users?page=$page&size=$size&sort=$sort");
        "http://dekdee2.informatics.buu.ac.th:8019/api/users?page=$page&size=$size&sort=$sort");
  }
}
