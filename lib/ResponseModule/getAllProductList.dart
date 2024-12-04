class getAllProductList {
  String? status;
  List<Data1>? data1;

  getAllProductList({this.status, this.data1});

  getAllProductList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data1'] != null) {
      data1 = <Data1>[];
      json['data1'].forEach((v) {
        data1!.add(new Data1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data1 != null) {
      data['data1'] = this.data1!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data1 {
  Rent? rent;
  int? quantity;
  String? sId;
  String? name;
  String? description;
  String? productCurrentAddress;
  int? price;
  double? rating; // Keep it as double
  String? category;
  List<Images>? images;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data1(
      {this.rent,
        this.quantity,
        this.sId,
        this.name,
        this.description,
        this.productCurrentAddress,
        this.price,
        this.rating,
        this.category,
        this.images,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data1.fromJson(Map<String, dynamic> json) {
    rent = json['rent'] != null ? Rent.fromJson(json['rent']) : null;
    quantity = json['quantity'];
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    productCurrentAddress = json['productCurrentAddress'];
    price = json['price'];

    // Convert 'rating' safely from int/double to double
    rating = json['rating'] != null ? (json['rating'] as num).toDouble() : null;

    category = json['category'];
    if (json['images'] != null) {
      images = <Images>[]; // Convert each image item to Images
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (rent != null) {
      data['rent'] = rent!.toJson();
    }
    data['quantity'] = quantity;
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['productCurrentAddress'] = productCurrentAddress;
    data['price'] = price;
    data['rating'] = rating;
    data['category'] = category;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}


class Rent {
  int? perHour;
  int? perDay;
  int? perWeek;
  int? perMonth;

  Rent({this.perHour, this.perDay, this.perWeek, this.perMonth});

  Rent.fromJson(Map<String, dynamic> json) {
    perHour = json['perHour'];
    perDay = json['perDay'];
    perWeek = json['perWeek'];
    perMonth = json['perMonth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['perHour'] = this.perHour;
    data['perDay'] = this.perDay;
    data['perWeek'] = this.perWeek;
    data['perMonth'] = this.perMonth;
    return data;
  }
}

class Images {
  String? publicId;
  String? url;
  String? sId;

  Images({this.publicId, this.url, this.sId});

  Images.fromJson(Map<String, dynamic> json) {
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