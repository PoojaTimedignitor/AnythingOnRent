class AdminBusinessAdsResponseModel {
  bool? success;
  List<String>? urls;

  AdminBusinessAdsResponseModel({this.success, this.urls});


  AdminBusinessAdsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['urls'] != null) {

      urls = [];
      if (json['urls'] is List) {
        for (var urlList in json['urls']) {
          if (urlList is List) {
            urls!.addAll(urlList.map((url) => url.toString()).toList());
          } else {
            urls!.add(urlList.toString());
          }
        }
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = this.success;
    if (this.urls != null) {
      data['urls'] = this.urls!;
    }
    return data;
  }
}

class Urls {
  String? url;

  Urls({this.url});

  Urls.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}
