import 'package:http/http.dart' as http;

class AccountService {
  static String baseUrl = "http://dekdee2.informatics.buu.ac.th:8019/api/";
  static Uri AuthLogin =
      Uri.parse("${baseUrl}auth/login");

  static Uri MyAccount =
      Uri.parse("${baseUrl}users/detail");

  static Uri ListUsers(int page, int size, String sort, String keyword, String roleID) {
    return Uri.parse("${baseUrl}users?page=$page&size=$size&sort=$sort&keyword=$keyword&roleId=$roleID");
        
  }
}
