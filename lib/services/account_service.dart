class AccountService {
  static const String baseUrl = "http://dekdee2.informatics.buu.ac.th:8019/api";

  static Uri authLogin = Uri.parse("$baseUrl/auth/login");
  static Uri myAccount = Uri.parse("$baseUrl/users/detail");
  static Uri forgetPassword = Uri.parse("$baseUrl/auth/forget-password");

  static Uri getAccountDetails(int userId) {
    return Uri.parse("$baseUrl/users/$userId");
  }

  static String? getUserImage(String? imagePath) {
    if (imagePath != null && imagePath.isNotEmpty) {
      return "$baseUrl/images/$imagePath";
    }
    return imagePath;
  }

  static Uri getUserProjects(int userId) {
    return Uri.parse("$baseUrl/projects/user-project/$userId");
  }

  static Uri getUserList(int page, int size, String sort) {
    return Uri.parse("$baseUrl/users?page=$page&size=$size&sort=$sort");
  }
}
