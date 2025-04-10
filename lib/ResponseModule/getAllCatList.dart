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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['categoryCount'] = this.categoryCount;
    return data;
  }
}

class Data {
  BannerImage? bannerImage;
  String? sId;
  String? name;
  String? slug;
  String? desc;

  Data({this.bannerImage, this.sId, this.name, this.slug, this.desc});

  Data.fromJson(Map<String, dynamic> json) {
    bannerImage = json['bannerImage'] != null
        ? new BannerImage.fromJson(json['bannerImage'])
        : null;
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bannerImage != null) {
      data['bannerImage'] = this.bannerImage!.toJson();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['desc'] = this.desc;
    return data;
  }
}

class BannerImage {
  String? url;

  BannerImage({this.url});

  BannerImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}