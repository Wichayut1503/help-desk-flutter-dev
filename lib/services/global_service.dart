class GlobalService {
  static final GlobalService _instance = GlobalService._internal();

  factory GlobalService() {
    return _instance;
  }

  GlobalService._internal();

  String accessToken = '';

}
