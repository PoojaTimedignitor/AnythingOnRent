class GetSubCategoriesResponseModel {
  bool? success;
  List<SubCategory>? data;

  GetSubCategoriesResponseModel({this.success, this.data});

  GetSubCategoriesResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = List<SubCategory>.from(json['data'].map((x) => SubCategory.fromJson(x)));
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}


class Data {
  SubCategory? fish;
  SubCategory? dog;
  SubCategory? rodents;
  SubCategory? cats;
  SubCategory? hamster;
  SubCategory? guineaPigs;
  SubCategory? birds;
  SubCategory? horse;
  SubCategory? rabbits;
  SubCategory? reptiles;

  Data({
    this.fish,
    this.dog,
    this.rodents,
    this.cats,
    this.hamster,
    this.guineaPigs,
    this.birds,
    this.horse,
    this.rabbits,
    this.reptiles,
  });

  Data.fromJson(Map<String, dynamic> json) {
    fish = _parseSubCategory(json, 'fish');
    dog = _parseSubCategory(json, 'dog');
    rodents = _parseSubCategory(json, 'rodents');
    cats = _parseSubCategory(json, 'cats');
    hamster = _parseSubCategory(json, 'hamster');
    guineaPigs = _parseSubCategory(json, 'guinea-pigs');
    birds = _parseSubCategory(json, 'birds');
    horse = _parseSubCategory(json, 'horse');
    rabbits = _parseSubCategory(json, 'rabbits');
    reptiles = _parseSubCategory(json, 'reptiles');
  }

  Map<String, dynamic> toJson() {
    return {
      'fish': fish?.toJson(),
      'dog': dog?.toJson(),
      'rodents': rodents?.toJson(),
      'cats': cats?.toJson(),
      'hamster': hamster?.toJson(),
      'guinea-pigs': guineaPigs?.toJson(),
      'birds': birds?.toJson(),
      'horse': horse?.toJson(),
      'rabbits': rabbits?.toJson(),
      'reptiles': reptiles?.toJson(),
    };
  }

  static SubCategory? _parseSubCategory(Map<String, dynamic> json, String key) {
    return json[key] != null ? SubCategory.fromJson(json[key]) : null;
  }
}

class SubCategory {
  String? id;
  String? name;
  String? slug;

  SubCategory({this.id, this.name, this.slug});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'slug': slug,
    };
  }
}
