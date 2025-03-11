class GetDynamicResponseModel {
  bool? success;
  Data? data;

  GetDynamicResponseModel({this.success, this.data});

  GetDynamicResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
    };
  }
}

class Data {
  Map<String, List<String>> dynamicFields = {};

  Data({required this.dynamicFields});

  Data.fromJson(Map<String, dynamic> json) {
    json.forEach((key, value) {
      if (value is List) {
        dynamicFields[key] = List<String>.from(value.map((e) => e.toString()));
      } else {
        dynamicFields[key] = [];
      }
    });
  }

  Map<String, dynamic> toJson() {
    return dynamicFields;
  }

  @override
  String toString() {
    return 'Data(dynamicFields: $dynamicFields)';
  }
}
