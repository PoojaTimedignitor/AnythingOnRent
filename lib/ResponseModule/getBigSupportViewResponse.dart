/*
class getBigViewSupportTicket {
  String? id;
  String? userId;
  String? description;
  String? status;
  String? ticketNumber;
  Map<String, dynamic>? category;

  getBigViewSupportTicket({
    this.id,
    this.userId,
    this.description,
    this.status,
    this.ticketNumber,
    this.category,
  });

  factory getBigViewSupportTicket.fromJson(Map<String, dynamic> json) {
    return getBigViewSupportTicket(
      id: json['_id'],
      userId: json['userId'],
      description: json['description'],
      status: json['status'],
      ticketNumber: json['ticketNumber'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "userId": userId,
      "description": description,
      "status": status,
      "ticketNumber": ticketNumber,
      "category": category,
    };
  }
}
 */



class getBigSupportTicketResponseModel {
  bool? success;
  String? message;
  List<BigSupportData>? data;

  getBigSupportTicketResponseModel({this.success, this.message, this.data});

  getBigSupportTicketResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = (json['data'] as List)
          .map((e) => BigSupportData.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BigSupportData {
  String? sId;
  String? userId;
  Category? category;
  String? description;
  String? status;
  bool? callRequested;
  String? createdAt;
  String? updatedAt;
  String? ticketNumber;

  BigSupportData(
      {this.sId,
        this.userId,
        this.category,
        this.description,
        this.status,
        this.callRequested,
        this.createdAt,
        this.updatedAt,
        this.ticketNumber});

  BigSupportData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    category =
    json['category'] != null ? Category.fromJson(json['category']) : null;
    description = json['description'];
    status = json['status'];
    callRequested = json['callRequested'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    ticketNumber = json['ticketNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['userId'] = userId;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['description'] = description;
    data['status'] = status;
    data['callRequested'] = callRequested;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['ticketNumber'] = ticketNumber;
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
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['name'] = name;
    return data;
  }
}
