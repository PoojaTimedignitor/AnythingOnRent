class getAllSupportTicket {
  bool? success;
  String? message;
  List<Data>? data;
  int? totalCount;
  int? totalPages;

  getAllSupportTicket(
      {this.success,
        this.message,
        this.data,
        this.totalCount,
        this.totalPages});

  getAllSupportTicket.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = this.totalCount;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class Data {
  String? sId;
  Category? category;
  String? status;
  String? createdAt;
  String? ticketNumber;

  Data(
      {this.sId,
        this.category,
        this.status,
        this.createdAt,
        this.ticketNumber});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    status = json['status'];
    createdAt = json['createdAt'];
    ticketNumber = json['ticketNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['ticketNumber'] = this.ticketNumber;
    return data;
  }
}

class Category {
  String? sId;
  String? name;

  Category({this.sId, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}