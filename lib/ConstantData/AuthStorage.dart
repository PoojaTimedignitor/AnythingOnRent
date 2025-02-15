import 'package:get_storage/get_storage.dart';

class AuthStorage {
  static final GetStorage _storage = GetStorage(); // ✅ Ab ye static hai
    // ==============================
  // 🔹 Save User Data from API Response
  // ==============================
  static void saveUserData({
    String? userId,
    String? accessToken,
    String? refreshToken,
    String? firstName,
    String? lastName,
    String? gender,
    String? permanentAddress,
    String? phoneNumbers,
    String? emalisss,
    String? userType,
    bool? isEmailVerified,
    String? profilePicture,
    bool? isPhoneVerified,
  }) {
    if (userId != null) {
      _storage.write('userId', userId); // ✅ Fix: Consistent key for User ID
      print("✅ User ID saved: $userId");
    }

    if (accessToken != null) _storage.write('accessToken', accessToken);
    if (refreshToken != null) _storage.write('refreshToken', refreshToken);
    if (firstName != null) _storage.write('firstName', firstName);
    if (lastName != null) _storage.write('lastName', lastName);
    if (gender != null) _storage.write('gender', gender);
    if (permanentAddress != null) _storage.write('permanentAddress', permanentAddress);
    if (phoneNumbers != null) _storage.write('phoneNumber', phoneNumbers);
    if (emalisss != null) _storage.write('email', emalisss);
    if (userType != null) _storage.write('userType', userType);
    if (profilePicture != null) _storage.write('profilePicture', profilePicture);
    if (isEmailVerified != null) _storage.write('isEmailVerified', isEmailVerified);
    if (isPhoneVerified != null) _storage.write('phoneVerified', isPhoneVerified);
  }

  // ==============================
  // 🔹 Set Individual Data
  // ==============================
  static void setPhoneNumber(String phoneNumber) {
    _storage.write('phoneNumber', phoneNumber); // ✅ Fix: Correct key
    print("✅ Phone Number saved: $phoneNumber");
  }

  static void setEmail(String emalisss) {
    _storage.write('email', emalisss); // ✅ Fix: Correct key
    print("✅ Email saved: $emalisss");
  }



  static void updateProfilePicture(String newProfilePicture) {
    _storage.write('profilePicture', newProfilePicture);
    print("✅ Profile Picture Updated: $newProfilePicture");
  }


  // ==============================
  // 🔹 Get Stored User Data
  // ==============================
  static String? getUserId() => _storage.read<String>('userId'); // ✅ Fix: Consistent key
  static String? getAccessToken() => _storage.read<String>('accessToken');
  static String? getRefreshToken() => _storage.read<String>('refreshToken');
  static String? getEmail() => _storage.read<String>('email');
  static String? getFirstName() => _storage.read<String>('firstName');
  static String? getLastName() => _storage.read<String>('lastName');
  static String? getGender() => _storage.read<String>('gender');
  static String? getPermanentAddress() => _storage.read<String>('permanentAddress');
  static String? getPhoneNumber() => _storage.read<String>('phoneNumber');
  static String? getUserType() => _storage.read<String>('userType');
  static String? getProfilePicture() => _storage.read<String>('profilePicture'); // ✅ Get Profile Picture
  static bool? isEmailVerified() => _storage.read<bool>('isEmailVerified'); // ✅ Fix: Now stored
  static bool? isPhoneVerified() => _storage.read<bool>('phoneVerified'); // ✅ Fix: Now stored

  // ==============================
  // 🔹 Clear User Data (Logout)
  // ==============================
  static void clearUserData() {
    _storage.erase(); // Removes all stored data
    print("🚀 User data cleared!");
  }

  // ==============================
  // 🔹 Save Only Tokens
  // ==============================
  static Future<void> saveTokens(String accessToken, String refreshToken) async {
    if (accessToken.isNotEmpty) await _storage.write('accessToken', accessToken);
    if (refreshToken.isNotEmpty) await _storage.write('refreshToken', refreshToken);
    print("✅ Tokens saved successfully!");
  }

  // ==============================
  // 🔹 Clear Tokens
  // ==============================
  static void clearTokens() {
    _storage.remove('accessToken'); // ✅ Ab ye kaam karega
    _storage.remove('refreshToken');
    print("🚀 Tokens cleared!");
  }
}
