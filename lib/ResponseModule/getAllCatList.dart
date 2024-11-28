class GetAllCategoriesList {
  bool? success;
  String? message;
  List<Data>? data;

  GetAllCategoriesList({this.success, this.message, this.data});

  GetAllCategoriesList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? categoryName;
  String? description;
  String? type;
  List<dynamic>? itemIDs; // Use dynamic since itemIDs can hold various data types
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data({
    this.sId,
    this.categoryName,
    this.description,
    this.type,
    this.itemIDs,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryName = json['categoryName'];
    description = json['description'];
    type = json['type'];
    // Handle itemIDs as a list of dynamic
    itemIDs = json['itemIDs'] != null ? List<dynamic>.from(json['itemIDs']) : [];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['categoryName'] = categoryName;
    data['description'] = description;
    data['type'] = type;
    if (itemIDs != null) {
      data['itemIDs'] = itemIDs;
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
