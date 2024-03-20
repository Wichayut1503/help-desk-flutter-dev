class MyAccount {
  int? status;
  String? message;
  Data? data;

  MyAccount({this.status, this.message, this.data});

  MyAccount.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? email;
  String? fullName;
  String? firstName;
  String? lastName;
  Null? phone;
  String? imagePath;
  int? companyId;
  String? companyName;
  String? roleName;
  String? createdAt;

  Data(
      {this.id,
      this.email,
      this.fullName,
      this.firstName,
      this.lastName,
      this.phone,
      this.imagePath,
      this.companyId,
      this.companyName,
      this.roleName,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    fullName = json['fullName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    imagePath = json['imagePath'];
    companyId = json['companyId'];
    companyName = json['companyName'];
    roleName = json['roleName'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['fullName'] = fullName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phone'] = phone;
    data['imagePath'] = imagePath;
    data['companyId'] = companyId;
    data['companyName'] = companyName;
    data['roleName'] = roleName;
    data['createdAt'] = createdAt;
    return data;
  }
}
