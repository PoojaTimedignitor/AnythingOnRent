class ApiConstant {
  String BaseUrl = "https://rental-api-5vfa.onrender.com";
  String BaseUrlCreateProduct = "https://rental-api-5vfa.onrender.com/api";
  String BaseUrlGetAllCat = "https://admin-fyu1.onrender.com/api";
  String BaseUrlGetAllCats = "https://rental-api-5vfa.onrender.com";
  String registerss = "/users/reg";
  String login = "/users/login";
  String products = "/addproduct/jhdfs";
  String getAllCatagries = "/category123";
  String getAllSubCatagries(String categoryId) {
    return "/subcategories/$categoryId";
  }

  String userProfile = "/users/profile";

  String editUser(String userId) {
    return "/users/user/$userId";
  }


  String BaseUrlCreateProdcut = "https://rental-api-5vfa.onrender.com/api/addon";
  String createProduct = "/hgsd";

String logout = "/logout";

String getDisplayProductList = "/products";


String AdminBaseUrl = "https://admin-fyu1.onrender.com/api/app";
String AdminGetCatFAQ = "/knowledge";
String AdminContactUsQuations = "/app-support/category";
String AdminContactUsMessage = "/app-support/register";


String UserFeedback = "/app-improment";
String BaseUrlCity = "https://rental-api-5vfa.onrender.com";
String getCityUrl = "/city";

}
