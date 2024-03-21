class UserProject {
  final int id;
  final String name;
  final String status;
  final DateTime startDate;
  final DateTime dueDate;
  final int projectDays;
  final int maintainDays;

  UserProject({
    required this.id,
    required this.name,
    required this.status,
    required this.startDate,
    required this.dueDate,
    required this.projectDays,
    required this.maintainDays,
  });

  factory UserProject.fromJson(Map<String, dynamic> json) {
    return UserProject(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
      startDate: _parseDate(json['startDate'] as String),
      dueDate: _parseDate(json['dueDate'] as String),
      projectDays: json['projectDays'] as int,
      maintainDays: json['maintainDays'] as int,
    );
  }

  static DateTime _parseDate(String date) {
    // Split the date string into day, month, and year
    List<String> parts = date.split('/');
    if (parts.length != 3) {
      throw const FormatException('Invalid date format');
    }

    // Parse day, month, and year
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);

    // Return parsed DateTime
    return DateTime(year, month, day);
  }
}
