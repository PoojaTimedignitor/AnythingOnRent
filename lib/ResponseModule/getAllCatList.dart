class GetAllCategoriesList {
  bool? success;
  List<Data>? data;
  int? categoryCount;

  GetAllCategoriesList({this.success, this.data, this.categoryCount});

  GetAllCategoriesList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    categoryCount = json['categoryCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['categoryCount'] = this.categoryCount;
    return data;
  }
}

class Data {
  String? sId;
  String? name;
  String? slug;
  String? desc;
  String? bannerImage;
  Null otherOption;

  Data(
      {this.sId,
        this.name,
        this.slug,
        this.desc,
        this.bannerImage,
        this.otherOption});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    desc = json['desc'];
    bannerImage = json['bannerImage'];
    otherOption = json['otherOption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['desc'] = this.desc;
    data['bannerImage'] = this.bannerImage;
    data['otherOption'] = this.otherOption;
    return data;
  }
}