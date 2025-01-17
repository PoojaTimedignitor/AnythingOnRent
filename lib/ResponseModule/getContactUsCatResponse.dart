class getContactUsCatResponse {
  bool? success;
  String? message;
  List<ExistingSupportCategories>? existingSupportCategories;

  getContactUsCatResponse(
      {this.success, this.message, this.existingSupportCategories});

  getContactUsCatResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['existingSupportCategories'] != null) {
      existingSupportCategories = <ExistingSupportCategories>[];
      json['existingSupportCategories'].forEach((v) {
        existingSupportCategories!
            .add(new ExistingSupportCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.existingSupportCategories != null) {
      data['existingSupportCategories'] =
          this.existingSupportCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExistingSupportCategories {
  String? sId;
  String? name;
  String? description;

  ExistingSupportCategories({this.sId, this.name, this.description});

  ExistingSupportCategories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}