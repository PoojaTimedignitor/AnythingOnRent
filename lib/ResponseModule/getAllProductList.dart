class getAllProductList {
  bool? success;
  int? totalProducts;
  List<Products>? products;
  int? currentPage;

  getAllProductList(
      {this.success, this.totalProducts, this.products, this.currentPage});

  getAllProductList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    totalProducts = json['totalProducts'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['totalProducts'] = this.totalProducts;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['currentPage'] = this.currentPage;
    return data;
  }
}

class Products {
  Location? location;
  int? quantity;
  bool? availability;
  String? sId;
  String? name;
  String? description;
  String? productCurrentAddress;
  int? price;
  int? rating;
  String? category;
  Rent? rent;
  List<Images>? images;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? status;
  String? userId;
  String? subCategory;
  Null? subSubCategory;
  String? brand;
  int? year;

  Products(
      {this.location,
        this.quantity,
        this.availability,
        this.sId,
        this.name,
        this.description,
        this.productCurrentAddress,
        this.price,
        this.rating,
        this.category,
        this.rent,
        this.images,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.status,
        this.userId,
        this.subCategory,
        this.subSubCategory,
        this.brand,
        this.year});

  Products.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    quantity = json['Quantity'];
    availability = json['availability'];
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    productCurrentAddress = json['productCurrentAddress'];
    price = json['price'];
    rating = json['rating'];
    category = json['category'];
    quantity = json['quantity'];
    rent = json['rent'] != null ? new Rent.fromJson(json['rent']) : null;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    status = json['status'];
    userId = json['userId'];
    subCategory = json['subCategory'];
    subSubCategory = json['subSubCategory'];
    brand = json['brand'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['Quantity'] = this.quantity;
    data['availability'] = this.availability;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['productCurrentAddress'] = this.productCurrentAddress;
    data['price'] = this.price;
    data['rating'] = this.rating;
    data['category'] = this.category;
    data['quantity'] = this.quantity;
    if (this.rent != null) {
      data['rent'] = this.rent!.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['status'] = this.status;
    data['userId'] = this.userId;
    data['subCategory'] = this.subCategory;
    data['subSubCategory'] = this.subSubCategory;
    data['brand'] = this.brand;
    data['year'] = this.year;
    return data;
  }
}

class Location {
  List<int>? coordinates;
  String? type;

  Location({this.coordinates, this.type});

  Location.fromJson(Map<String, dynamic> json) {
    coordinates = json['coordinates'].cast<int>();
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coordinates'] = this.coordinates;
    data['type'] = this.type;
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