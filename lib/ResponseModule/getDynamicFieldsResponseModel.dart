class GetDaynamicResponseModel {
  bool? success;
  Data? data;

  GetDaynamicResponseModel({this.success, this.data});

  GetDaynamicResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<String>? petItemTypes;
  List<String>? doYouProvideAnyPetConsultation;
  List<String>? petItemsDelivery;

  Data({this.petItemTypes, this.doYouProvideAnyPetConsultation, this.petItemsDelivery});

  Data.fromJson(Map<String, dynamic> json) {
    petItemTypes = json['Pet Item Types'] != null ? List<String>.from(json['Pet Item Types']) : [];
    doYouProvideAnyPetConsultation = json['Do you provide any pet consultation?'] != null
        ? List<String>.from(json['Do you provide any pet consultation?'])
        : [];
    petItemsDelivery = json["Pet Item's Delivery"] != null
        ? List<String>.from(json["Pet Item's Delivery"])
        : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (petItemTypes != null) {
      data['Pet Item Types'] = petItemTypes;
    }
    if (doYouProvideAnyPetConsultation != null) {
      data['Do you provide any pet consultation?'] = doYouProvideAnyPetConsultation;
    }
    if (petItemsDelivery != null) {
      data["Pet Item's Delivery"] = petItemsDelivery;
    }
    return data;
  }
}
