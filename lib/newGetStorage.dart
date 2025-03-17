// import 'package:get_storage/get_storage.dart';
// import 'ConstantNewData.dart';
//
// class NewAuthStorage {
//   static final _storage = GetStorage();
//
//
//   static const String phoneNumberKey = "phoneNumber";
//   static const String emailKey = "email";
//   static const String userIdKey = "userId";
//   static const String accessTokenKey = "accessToken";
//   static const String refreshTokenKey = "refreshToken";
//   /// 📌 Store Phone Number
//   static void setPhoneNumber(String phoneNumber) {
//     _storage.write(StorageKeys.phoneNumber, phoneNumber);
//   }
//
//   /// 📌 Retrieve Phone Number
//   static String? getPhoneNumber() {
//     return _storage.read<String>(StorageKeys.phoneNumber);
//   }
//
//
//   static Future<void> setEmail(String email) async {
//     await _storage.write(emailKey, email);
//   }
//
//   static String? getEmail() {
//     return _storage.read(emailKey);
//   }
//
//
//   static Future<void> setUserId(String userId) async {
//     await _storage.write(userIdKey, userId);
//   }
//
//   static String? getUserId() {
//     return _storage.read(userIdKey);
//   }
//
//
//
//   static Future<void> setAccessToken(String token) async {
//     await _storage.write(accessTokenKey, token);
//   }
//
//   static String? getAccessToken() {
//     return _storage.read(accessTokenKey);
//   }
//
//   static Future<void> setRefreshToken(String token) async {
//     await _storage.write(refreshTokenKey, token);
//   }
//
//   static String? getRefreshToken() {
//     return _storage.read(refreshTokenKey);
//   }
//
//
//
//   /// 📌 Store OTP
//   static void setOTP(String otp) {
//     _storage.write(StorageKeys.otp, otp);
//   }
//
//   /// 📌 Retrieve OTP
//   static String? getOTP() {
//     return _storage.read<String>(StorageKeys.otp);
//   }
//
//
//
//   /// 📌 Clear Storage (Logout/Reset) - Purana Data Delete Karega
//  /* static Future<void> clearStorage() async {
//     await _storage.erase();
//     print("📌 Storage cleared successfully!");
//   }*/
//
//
//   static Future<void> clearStorage() async {
//     await _storage.erase();
//   }
// }



import 'package:get_storage/get_storage.dart';
import 'ConstantNewData.dart';

class NewAuthStorage {
  static final _storage = GetStorage();

  static const String phoneNumberKey = "phoneNumber";
  static const String emailKey = "email";
  static const String userIdKey = "userId";
  static const String accessTokenKey = "accessToken";
  static const String refreshTokenKey = "refreshToken";
  static const String firstNameKey = "firstName";
  static const String lastNameKey = "lastName";
  static const String genderKey = "gender";
  static const String addressKey = "permanentAddress";
  static const String password = "password";


  static Future<void> saveUserDetails({
    required String userId,
    required String phoneNumber,
    required String emailss,
    required String firstName,
    required String lastName,
    required String gender,
    required String permanentAddress,
    required String password,
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(userIdKey, userId);
    await _storage.write(phoneNumberKey, phoneNumber);
    await _storage.write(emailKey, emailss);
    await _storage.write(firstNameKey, firstName);
    await _storage.write(lastNameKey, lastName);
    await _storage.write(genderKey, gender);
    await _storage.write(addressKey, permanentAddress);
    await _storage.write(addressKey, password);
    await _storage.write(accessTokenKey, accessToken);
    await _storage.write(refreshTokenKey, refreshToken);

    print("✅ All User Details Saved Successfully!");
  }


  static Map<String, String?> getUserDetails() {
    return {
      "userId": _storage.read(userIdKey),
      "phoneNumber": _storage.read(phoneNumberKey),
      "firstName": _storage.read(firstNameKey),
      "lastName": _storage.read(lastNameKey),
      "gender": _storage.read(genderKey),
      "permanentAddress": _storage.read(addressKey),
      "password": _storage.read(password),
      "accessToken": _storage.read(accessTokenKey),
      "refreshToken": _storage.read(refreshTokenKey),
    };
  }


  static String? getUserId() => _storage.read<String>('userId');
  static String? getFName() => _storage.read<String>('firstName');
  static String? getLName() => _storage.read<String>('lastName');
  static String? getPhone() => _storage.read<String>('phoneNumber');
  static String? getEmails() => _storage.read<String>('email');
  static String? getAddress() => _storage.read<String>('permanentAddress');
  static String? getGender() => _storage.read<String>('gender');
  static String? getProfileImage() => _storage.read<String>('profileImage');

  static Future<void> setUserIds(String userId) async {
    await _storage.write(userIdKey, userId);
    print("✅ User ID Stored: $userId");
  }

  /// ✅ Retrieve User ID & Debug
  static String? getUserIds() {
    String? userId = _storage.read<String>(userIdKey);
    print("🔵 Retrieved User ID from Storage: $userId");
    return userId;
  }

  static void setPhoneNumber(String phoneNumber) {
    _storage.write(StorageKeys.phoneNumber, phoneNumber);
  }

  /// 📌 Retrieve Phone Number
  static String? getPhoneNumber() {
    return _storage.read<String>(StorageKeys.phoneNumber);
  }

  /// 📌 Store Email
  static Future<void> setEmail(String email) async {
    await _storage.write(emailKey, email);
  }

  static String? getEmail() {
    return _storage.read(emailKey);
  }

  /// 📌 Store User ID
  static Future<void> setUserId(String userId) async {
    await _storage.write(userIdKey, userId);
  }

  static String? getUserIdd() {
    return _storage.read(userIdKey);
  }

  /// 📌 Store Access Token
  static Future<void> setAccessToken(String token) async {
    await _storage.write(accessTokenKey, token);
  }

  static String? getAccessToken() {
    return _storage.read(accessTokenKey);
  }

  /// 📌 Store Refresh Token
  static Future<void> setRefreshToken(String token) async {
    await _storage.write(refreshTokenKey, token);
  }

  static String? getRefreshToken() {
    return _storage.read(refreshTokenKey);
  }

  /// 📌 Store OTP
  static void setOTP(String otp) {
    _storage.write(StorageKeys.otp, otp);
  }

  static String? getOTP() {
    return _storage.read<String>(StorageKeys.otp);
  }


  static Future<void> clearStorage() async {
    await _storage.erase();
  }
}
