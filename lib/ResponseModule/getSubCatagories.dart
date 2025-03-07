class GetSubCategories {
  bool success; // ✅ Always bool, avoid null
  List<SubCatData> data; // ✅ Always List, no null

  GetSubCategories({
    required this.success,
    required this.data,
  });

  factory GetSubCategories.fromJson(Map<String, dynamic> json) {
    return GetSubCategories(
      success: json['success'] == true, // ✅ Ensure it's bool
      data: json['data'] is List
          ? List<SubCatData>.from(
          json['data'].map((x) => SubCatData.fromJson(x)))
          : [], // ✅ Ensure List type
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((x) => x.toJson()).toList(),
    };
  }
}

class SubCatData {
  String sId;
  String name;
  String slug;
  List<DynamicFields> dynamicFields; // ✅ Ensure List type

  SubCatData({
    required this.sId,
    required this.name,
    required this.slug,
    required this.dynamicFields,
  });

  factory SubCatData.fromJson(Map<String, dynamic> json) {
    return SubCatData(
      sId: json['_id'] ?? '', // ✅ Default empty string
      name: json['name'] ?? 'No Name', // ✅ Avoid null issues
      slug: json['slug'] ?? '',
      dynamicFields: json['dynamicFields'] is List
          ? List<DynamicFields>.from(
          json['dynamicFields'].map((x) => DynamicFields.fromJson(x)))
          : [], // ✅ Ensure List
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'name': name,
      'slug': slug,
      'dynamicFields': dynamicFields.map((e) => e.toJson()).toList(),
    };
  }
}

class DynamicFields {
  String sId;
  String fieldName;
  List<dynamic> fieldValues; // ✅ Always List

  DynamicFields({
    required this.sId,
    required this.fieldName,
    required this.fieldValues,
  });

  factory DynamicFields.fromJson(Map<String, dynamic> json) {
    return DynamicFields(
      sId: json['_id'] ?? '',
      fieldName: json['fieldName'] ?? 'Unknown Field', // ✅ Avoid null
      fieldValues: json['fieldValues'] is List
          ? List<dynamic>.from(json['fieldValues'])
          : [], // ✅ Ensure List
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'fieldName': fieldName,
      'fieldValues': fieldValues,
    };
  }
}
