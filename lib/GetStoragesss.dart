import 'package:get_storage/get_storage.dart';

class AuthStoragesss {
  static final GetStorage _storage = GetStorage();

  static Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _storage.write('accessToken', accessToken);
    await _storage.write('refreshToken', refreshToken);
    print("✅ Tokens Stored in GetStorage!");
  }

  static String? getAccessToken() {
    return _storage.read<String>('accessToken');
  }

  static String? getRefreshToken() {
    return _storage.read<String>('refreshToken');
  }

  static void clearTokens() {
    _storage.remove('accessToken');
    _storage.remove('refreshToken');
    print("🚀 Tokens Cleared from GetStorage!");
  }

  static Future<void> saveUserId(String userId) async {
    await _storage.write('userId', userId);
  }

  static String? getUserId() {
    return _storage.read<String>('userId');
  }

  static Future<void> savePhoneNumber(String phone) async {
    await _storage.write('phone', phone);
  }

  static String? getPhoneNumber() {
    return _storage.read<String>('phone');
  }

  static Future<void> saveEmail(String email) async {
    await _storage.write('email', email);
  }

  static String? getEmail() {
    return _storage.read<String>('email');
  }
}
