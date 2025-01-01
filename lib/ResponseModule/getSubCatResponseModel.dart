class GetSubCategories {
  bool? success;
  String? message;
  List<SubCategoryData>? subCategoryData;

  GetSubCategories({this.success, this.message, this.subCategoryData});

  GetSubCategories.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['subCategoryData'] != null) {
      subCategoryData = <SubCategoryData>[];
      json['subCategoryData'].forEach((v) {
        subCategoryData!.add(SubCategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (subCategoryData != null) {
      data['subCategoryData'] = subCategoryData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategoryData {
  String? sId;
  String? name;
  String? slug;
  String? parentCategory;
  List<dynamic>? relatedSubCategories; // Updated to List<dynamic>
  String? createdAt;
  String? updatedAt;
  int? iV;

  SubCategoryData(
      {this.sId,
        this.name,
        this.slug,
        this.parentCategory,
        this.relatedSubCategories,
        this.createdAt,
        this.updatedAt,
        this.iV});

  SubCategoryData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    parentCategory = json['parentCategory'];
    if (json['relatedSubCategories'] != null) {
      relatedSubCategories = <dynamic>[]; // Corrected initialization
      json['relatedSubCategories'].forEach((v) {
        relatedSubCategories!.add(v); // Simply add to the list
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['slug'] = slug;
    data['parentCategory'] = parentCategory;
    if (relatedSubCategories != null) {
      data['relatedSubCategories'] = relatedSubCategories!;
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
