class getAllCityResponse {
  bool? error;
  String? msg;
  List<String>? data;

  getAllCityResponse({this.error, this.msg, this.data});

  getAllCityResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    msg = json['msg'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['msg'] = this.msg;
    data['data'] = this.data;
    return data;
  }
}