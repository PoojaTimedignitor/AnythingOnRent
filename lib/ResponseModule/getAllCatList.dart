class GetAllCategoriesList {
  bool? success;
  String? message;
  List<CategoryData>? categoryData;

  GetAllCategoriesList({this.success, this.message, this.categoryData});

  GetAllCategoriesList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['CategoryData'] != null) {
      categoryData = <CategoryData>[];
      json['CategoryData'].forEach((v) {
        categoryData!.add(new CategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.categoryData != null) {
      data['CategoryData'] = this.categoryData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryData {
  String? sId;
  String? name;
  String? slug;
  String? desc;
  Null? otherOption;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CategoryData(
      {this.sId,
        this.name,
        this.slug,
        this.desc,
        this.otherOption,
        this.createdAt,
        this.updatedAt,
        this.iV});

  CategoryData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    desc = json['desc'];
    otherOption = json['otherOption'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['desc'] = this.desc;
    data['otherOption'] = this.otherOption;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}