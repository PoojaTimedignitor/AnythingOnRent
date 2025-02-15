class getEditProfileResponseModel {
  bool? success;
  ProfileData? profileData;

  getEditProfileResponseModel({this.success, this.profileData});

  getEditProfileResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    profileData = json['profileData'] != null
        ? new ProfileData.fromJson(json['profileData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.profileData != null) {
      data['profileData'] = this.profileData!.toJson();
    }
    return data;
  }
}

class ProfileData {
  String? profilePicture;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? permanentAddress;
  String? dateOfBirth;
  String? gender;
  String? userType;
  String? userStatus;

  ProfileData(
      {this.profilePicture,
        this.firstName,
        this.lastName,
        this.phoneNumber,
        this.email,
        this.permanentAddress,
        this.dateOfBirth,
        this.gender,
        this.userType,
        this.userStatus});

  ProfileData.fromJson(Map<String, dynamic> json) {
    profilePicture = json['profilePicture'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    permanentAddress = json['permanentAddress'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    userType = json['userType'];
    userStatus = json['userStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profilePicture'] = this.profilePicture;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['permanentAddress'] = this.permanentAddress;
    data['dateOfBirth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['userType'] = this.userType;
    data['userStatus'] = this.userStatus;
    return data;
  }
}