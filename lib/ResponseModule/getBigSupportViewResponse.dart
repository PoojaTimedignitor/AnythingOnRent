class getBigViewSupportTicket {
  bool? success;
  String? message;
  Data? data;

  getBigViewSupportTicket({this.success, this.message, this.data});

  getBigViewSupportTicket.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? userId;
  Category? category;
  String? description;
  String? status;
  bool? callRequested;
  Null? callRequestedAt;
  Null? callResponseAt;
  String? createdAt;
  String? updatedAt;
  String? ticketNumber;
  int? iV;

  Data(
      {this.sId,
        this.userId,
        this.category,
        this.description,
        this.status,
        this.callRequested,
        this.callRequestedAt,
        this.callResponseAt,
        this.createdAt,
        this.updatedAt,
        this.ticketNumber,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    description = json['description'];
    status = json['status'];
    callRequested = json['callRequested'];
    callRequestedAt = json['callRequestedAt'];
    callResponseAt = json['callResponseAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    ticketNumber = json['ticketNumber'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['description'] = this.description;
    data['status'] = this.status;
    data['callRequested'] = this.callRequested;
    data['callRequestedAt'] = this.callRequestedAt;
    data['callResponseAt'] = this.callResponseAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['ticketNumber'] = this.ticketNumber;
    data['__v'] = this.iV;
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