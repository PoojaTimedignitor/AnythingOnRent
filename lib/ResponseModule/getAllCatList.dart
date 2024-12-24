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
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? name;
  String? desc;
  List<SubCategories>? subCategories;

  Data({this.sId, this.name, this.desc, this.subCategories});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    desc = json['desc'];
    if (json['subCategories'] != null) {
      subCategories = <SubCategories>[];
      json['subCategories'].forEach((v) {
        subCategories!.add(new SubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['desc'] = this.desc;
    if (this.subCategories != null) {
      data['subCategories'] =
          this.subCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategories {
  String? sId;
  String? name;
  List<SubSubCategories>? subSubCategories;

  SubCategories({this.sId, this.name, this.subSubCategories});

  SubCategories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    if (json['subSubCategories'] != null) {
      subSubCategories = <SubSubCategories>[];
      json['subSubCategories'].forEach((v) {
        subSubCategories!.add(new SubSubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.subSubCategories != null) {
      data['subSubCategories'] =
          this.subSubCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubSubCategories {
  String? sId;
  String? name;

  SubSubCategories({this.sId, this.name});

  SubSubCategories.fromJson(Map<String, dynamic> json) {
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