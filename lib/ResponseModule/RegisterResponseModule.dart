class RegisterResponseModule {
  bool? success;
  String? message;
  String? token;
  String? dummyEmailOtp;
  String? dummyPhoneOtp;
  Data? data;

  RegisterResponseModule(
      {this.success,
        this.message,
        this.token,
        this.dummyEmailOtp,
        this.dummyPhoneOtp,
        this.data});

  RegisterResponseModule.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
    dummyEmailOtp = json['dummyEmailOtp'];
    dummyPhoneOtp = json['dummyPhoneOtp'];
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['token'] = this.token;
    data['dummyEmailOtp'] = this.dummyEmailOtp;
    data['dummyPhoneOtp'] = this.dummyPhoneOtp;
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? email;
  String? password;
  String? otp;
  bool? otpVerified;
  bool? isEmailVerified;
  String? phoneNumber;
  bool? phoneVerified;
  String? userId;
  List<Images>? images;
  String? currentAddress;
  String? permanentAddress;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.name,
        this.email,
        this.password,
        this.otp,
        this.otpVerified,
        this.isEmailVerified,
        this.phoneNumber,
        this.phoneVerified,
        this.userId,
        this.images,
        this.currentAddress,
        this.permanentAddress,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    otp = json['otp'];
    otpVerified = json['otpVerified'];
    isEmailVerified = json['isEmailVerified'];
    phoneNumber = json['phoneNumber'];
    phoneVerified = json['phoneVerified'];
    userId = json['userId'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    currentAddress = json['currentAddress'];
    permanentAddress = json['permanentAddress'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['otp'] = this.otp;
    data['otpVerified'] = this.otpVerified;
    data['isEmailVerified'] = this.isEmailVerified;
    data['phoneNumber'] = this.phoneNumber;
    data['phoneVerified'] = this.phoneVerified;
    data['userId'] = this.userId;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['currentAddress'] = this.currentAddress;
    data['permanentAddress'] = this.permanentAddress;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
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