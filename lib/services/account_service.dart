class AccountService {
  static const String baseUrl = "http://dekdee2.informatics.buu.ac.th:8019/api";
  static const String defaultImageUrl =
      "https://isobarscience-1bfd8.kxcdn.com/wp-content/uploads/2020/09/default-profile-picture1.jpg";

  static Uri authLogin = Uri.parse("$baseUrl/auth/login");
  static Uri myAccount = Uri.parse("$baseUrl/users/detail");

  static Uri accountDetails(int userId) {
    return Uri.parse("$baseUrl/users/$userId");
  }

  static String getDefaultImageUrl() {
    return defaultImageUrl;
  }

  static String? userImage(String? imagePath) {
    if (imagePath != null &&
        imagePath.isNotEmpty &&
        imagePath != defaultImageUrl) {
      return "$baseUrl/images/$imagePath";
    }
    return imagePath;
  }

  static Uri listUsers(int page, int size, String sort) {
    return Uri.parse("$baseUrl/users?page=$page&size=$size&sort=$sort");
  }
}
