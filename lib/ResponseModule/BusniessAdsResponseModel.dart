class AdminBusinessAdsResponseModel {
  bool? success;
  List<String>? urls; // URLs की सूची (Strings)

  AdminBusinessAdsResponseModel({this.success, this.urls});

  // JSON से कंस्ट्रक्टर
  AdminBusinessAdsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['urls'] != null) {
      // यदि 'urls' एक सूची की सूची है, तो उसे समतल (flatten) करें
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

  // JSON में रूपांतरित करने की विधि
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
  String? url;  // URL का उदाहरण प्रॉपर्टी

  Urls({this.url});

  // From JSON constructor
  Urls.fromJson(Map<String, dynamic> json) {
    url = json['url']; // Assuming 'url' is a property of Urls
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['url'] = this.url;  // Assuming 'url' is a property of Urls
    return data;
  }
}
