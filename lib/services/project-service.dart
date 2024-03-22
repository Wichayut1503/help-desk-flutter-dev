import 'package:http/http.dart' as http;

class ProjectService {
  static String baseUrl = "http://dekdee2.informatics.buu.ac.th:8019/api/";
  static Uri ProjectDetail =
      Uri.parse("${baseUrl}projects");

  //static Uri MyAccount =
      //Uri.parse("${baseUrl}users/detail");

  static Uri ListProjects(int page, int size, String sort, String keyword) {
    return Uri.parse("${baseUrl}projects?page=$page&size=$size&sort=$sort");

  }
}
