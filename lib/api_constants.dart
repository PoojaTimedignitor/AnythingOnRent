class ApiConstants {
  static const String baseUrl = "https://backend.anythingonrent.com";
  static const String phoneRegister = "/sendPhoneOtp";
  static const String phoneOTP = "/verifyPhoneOtp";
  static const String sendEmailOtp = "/sendEmailOtp";
  static const String verifyEmailOtp = "/verifyEmailOtp";
  static String userRegisterrrr(String userId) {
    return "/update-details/$userId";
  }

}