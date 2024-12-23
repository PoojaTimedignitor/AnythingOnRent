class GetAllCategoriesList {
  bool? success;
  List<Data>? data;

  GetAllCategoriesList({this.success, this.data});

  GetAllCategoriesList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = (json['data'] as List<dynamic>?)
        ?.map((item) => Data.fromJson(item))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['data'] = this.data?.map((v) => v.toJson()).toList();
    return data;
  }
}
class Data {
  String? sId;
  String? name;
  List<String>? subCategories;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? desc;

  Data(
      {this.sId,
        this.name,
        this.subCategories,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.desc});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    subCategories = json['subCategories'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['subCategories'] = this.subCategories;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['desc'] = this.desc;
    return data;
  }
}