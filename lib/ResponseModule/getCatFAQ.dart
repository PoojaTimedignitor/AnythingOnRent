class getCatFaqResponse {
  bool? success;
  String? message;
  List<Data>? data;
  Pagination? pagination;

  getCatFaqResponse({this.success, this.message, this.data, this.pagination});

  getCatFaqResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Data {
  Category? category;
  List<Questions>? questions;

  Data({this.category, this.questions});

  Data.fromJson(Map<String, dynamic> json) {
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? name;

  Category({this.name});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class Questions {
  String? title;
  String? description;
  String? externalUrl;

  Questions({this.title, this.description, this.externalUrl});

  Questions.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    externalUrl = json['externalUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['externalUrl'] = this.externalUrl;
    return data;
  }
}

class Pagination {
  int? totalItems;
  int? currentPage;
  int? totalPages;

  Pagination({this.totalItems, this.currentPage, this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalItems'] = this.totalItems;
    data['currentPage'] = this.currentPage;
    data['totalPages'] = this.totalPages;
    return data;
  }
}