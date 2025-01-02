class getCatFaqResponse {
  bool? success;
  String? message;
  List<Knowledgement>? knowledgement;

  getCatFaqResponse({this.success, this.message, this.knowledgement});

  getCatFaqResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['knowledgement'] != null) {
      knowledgement = <Knowledgement>[];
      json['knowledgement'].forEach((v) {
        knowledgement!.add(new Knowledgement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.knowledgement != null) {
      data['knowledgement'] =
          this.knowledgement!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Knowledgement {
  String? sId;
  String? name;
  List<Icons>? icons;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Knowledgement(
      {this.sId,
        this.name,
        this.icons,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Knowledgement.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    if (json['icons'] != null) {
      icons = <Icons>[];
      json['icons'].forEach((v) {
        icons!.add(new Icons.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.icons != null) {
      data['icons'] = this.icons!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Icons {
  String? publicId;
  String? url;
  String? sId;

  Icons({this.publicId, this.url, this.sId});

  Icons.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    url = json['url'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['public_id'] = this.publicId;
    data['url'] = this.url;
    data['_id'] = this.sId;
    return data;
  }
}