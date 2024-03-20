class AccountService {
  static const String baseUrl = "http://dekdee2.informatics.buu.ac.th:8019/api";

  static Uri authLogin = Uri.parse("$baseUrl/auth/login");
  static Uri myAccount = Uri.parse("$baseUrl/users/detail");

  static Uri accountDetails(int userId) {
    return Uri.parse("$baseUrl/users/$userId");
  }

  static String? userImage(String? imagePath) {
    if (imagePath != null && imagePath.isNotEmpty) {
      return "$baseUrl/images/$imagePath";
    }
    return imagePath;
  }

  static Uri listUsers(int page, int size, String sort) {
    return Uri.parse("$baseUrl/users?page=$page&size=$size&sort=$sort");
  }
}
