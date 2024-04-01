class DetailProject {
  List<Content>? content;
  Pageable? pageable;
  int? totalElements;
  int? totalPages;
  bool? last;
  int? size;
  int? number;
  Sort? sort;
  int? numberOfElements;
  bool? first;
  bool? empty;

  DetailProject(
      {this.content,
      this.pageable,
      this.totalElements,
      this.totalPages,
      this.last,
      this.size,
      this.number,
      this.sort,
      this.numberOfElements,
      this.first,
      this.empty});

  DetailProject.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(new Content.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
    last = json['last'];
    size = json['size'];
    number = json['number'];
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    numberOfElements = json['numberOfElements'];
    first = json['first'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    data['totalElements'] = this.totalElements;
    data['totalPages'] = this.totalPages;
    data['last'] = this.last;
    data['size'] = this.size;
    data['number'] = this.number;
    if (this.sort != null) {
      data['sort'] = this.sort!.toJson();
    }
    data['numberOfElements'] = this.numberOfElements;
    data['first'] = this.first;
    data['empty'] = this.empty;
    return data;
  }
}

class Content {
  Null? countStatusOpen;
  Null? countStatusInProcess;
  Null? countStatusDone;
  Null? countStatusClose;
  Null? countStatusReturn;
  Null? countStatusReject;
  Null? countUserClient;
  Null? countUserAdmin;
  Null? colorStatusResponses;
  int? id;
  String? name;
  String? status;
  Company? company;
  String? startDate;
  String? dueDate;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  int? projectDays;
  int? maintainDays;
  int? countTicket;
  int? countUserProject;

  Content(
      {this.countStatusOpen,
      this.countStatusInProcess,
      this.countStatusDone,
      this.countStatusClose,
      this.countStatusReturn,
      this.countStatusReject,
      this.countUserClient,
      this.countUserAdmin,
      this.colorStatusResponses,
      this.id,
      this.name,
      this.status,
      this.company,
      this.startDate,
      this.dueDate,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.projectDays,
      this.maintainDays,
      this.countTicket,
      this.countUserProject});

  Content.fromJson(Map<String, dynamic> json) {
    countStatusOpen = json['countStatusOpen'];
    countStatusInProcess = json['countStatusInProcess'];
    countStatusDone = json['countStatusDone'];
    countStatusClose = json['countStatusClose'];
    countStatusReturn = json['countStatusReturn'];
    countStatusReject = json['countStatusReject'];
    countUserClient = json['countUserClient'];
    countUserAdmin = json['countUserAdmin'];
    colorStatusResponses = json['colorStatusResponses'];
    id = json['id'];
    name = json['name'];
    status = json['status'];
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
    startDate = json['startDate'];
    dueDate = json['dueDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    projectDays = json['projectDays'];
    maintainDays = json['maintainDays'];
    countTicket = json['countTicket'];
    countUserProject = json['countUserProject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countStatusOpen'] = this.countStatusOpen;
    data['countStatusInProcess'] = this.countStatusInProcess;
    data['countStatusDone'] = this.countStatusDone;
    data['countStatusClose'] = this.countStatusClose;
    data['countStatusReturn'] = this.countStatusReturn;
    data['countStatusReject'] = this.countStatusReject;
    data['countUserClient'] = this.countUserClient;
    data['countUserAdmin'] = this.countUserAdmin;
    data['colorStatusResponses'] = this.colorStatusResponses;
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    data['startDate'] = this.startDate;
    data['dueDate'] = this.dueDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['projectDays'] = this.projectDays;
    data['maintainDays'] = this.maintainDays;
    data['countTicket'] = this.countTicket;
    data['countUserProject'] = this.countUserProject;
    return data;
  }
}

class Company {
  int? id;
  String? name;
  String? nameTh;
  String? nameAlias;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;

  Company(
      {this.id,
      this.name,
      this.nameTh,
      this.nameAlias,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameTh = json['nameTh'];
    nameAlias = json['nameAlias'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['nameTh'] = this.nameTh;
    data['nameAlias'] = this.nameAlias;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    return data;
  }
}

class Pageable {
  Sort? sort;
  int? offset;
  int? pageNumber;
  int? pageSize;
  bool? paged;
  bool? unpaged;

  Pageable(
      {this.sort,
      this.offset,
      this.pageNumber,
      this.pageSize,
      this.paged,
      this.unpaged});

  Pageable.fromJson(Map<String, dynamic> json) {
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    offset = json['offset'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    paged = json['paged'];
    unpaged = json['unpaged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sort != null) {
      data['sort'] = this.sort!.toJson();
    }
    data['offset'] = this.offset;
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    data['paged'] = this.paged;
    data['unpaged'] = this.unpaged;
    return data;
  }
}

class Sort {
  bool? empty;
  bool? sorted;
  bool? unsorted;

  Sort({this.empty, this.sorted, this.unsorted});

  Sort.fromJson(Map<String, dynamic> json) {
    empty = json['empty'];
    sorted = json['sorted'];
    unsorted = json['unsorted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['empty'] = this.empty;
    data['sorted'] = this.sorted;
    data['unsorted'] = this.unsorted;
    return data;
  }
}
