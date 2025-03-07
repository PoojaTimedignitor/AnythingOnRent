class ApiConstant {
  String BaseUrl = "https://backend.anythingonrent.com";

  String BaseUrlCreateProduct = "https://rental-api-5vfa.onrender.com/api";
  String BaseUrlGetAllCat = "https://admin-fyu1.onrender.com/api";
  String BaseUrlGetAllCats = "https://rental-api-5vfa.onrender.com";
  String PhoneRegister = "/sendPhoneOtp";
  String storeLocation = "/update-locations";
  String emailRegister = "/sendEmailOtp";
  String emailOtp = "/verifyEmailOtp";
  String PhoneOTP = "/verifyPhoneOtp";
  String registerss = "update-details/67a45296163c23dde02d4a90";
  String login = "/login";
  String products = "/addproduct/jhdfs";
  String getAllCatagries = "/categories";
  String getAllSubCatagries(String categoryId) {
    return "/$categoryId/subcatetgories";
  }

  String userProfile = "/users/profile";

  String editUser(String userId) {
    return "/users/user/$userId";
  }


  String BaseUrlCreateProdcut = "https://rental-api-5vfa.onrender.com/api/addon";
  String createProduct = "/hgsd";

String logout = "/logout";
String getEditProfile = "/profile";
String getCurrentLocation = "/get-location";
String putEditProfile = "/profile";

String getDisplayProductList = "/products";


String AdminBaseUrl = "https://admin-fyu1.onrender.com/api/app";
String AdminGetCatFAQ = "/knowledge";
String AdminContactUsQuations = "/app-support/category";
String AdminContactUsMessage = "/app-support/register";
String ReferralCode = "/referral/verify";
String RefreshToken = "/refresh-token";


  String getAllTicketsSupport(String userId) {
    return "/app-support/$userId";
  }


  String getBigSupportTicket(String userId, String ticketNumber) {
    return "/app-support/$userId/$ticketNumber";
  }


  String userRegister(String userId) {
    return "/update-details/$userId";
  }

  String deleteProducts(String ProductId) {
    return "/product/$ProductId";
  }
  String getBusinessAds = "/advertisement";


String UserFeedback = "/app-improment";
String BaseUrlCity = "https://rental-api-5vfa.onrender.com";
String getCityUrl = "/city";

}
