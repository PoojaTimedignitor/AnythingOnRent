class ApiConstant {
  String BaseUrl = "https://rental-api-5vfa.onrender.com";
  String BaseUrlCreateProduct = "https://rental-api-5vfa.onrender.com/api";
  String BaseUrlGetAllCat = "https://admin-fyu1.onrender.com/api";
  String registerss = "/reg";
  String login = "/login";
  String products = "/addproduct/jhdfs";
  String getAllCatagries = "/categories";
  String getAllSubCatagries(String categoryId) {
    return "/categories/$categoryId/subcategories";
  }


  String BaseUrlCreateProdcut = "https://rental-api-5vfa.onrender.com/api/addon";
  String createProduct = "/hgsd";

String logout = "/logout";

String getDisplayProductList = "/products";


String AdminBaseUrl = "https://admin-fyu1.onrender.com/api/app";

String UserFeedback = "/app-improment";
String BaseUrlCity = "https://admin-fyu1.onrender.com/api/";
String getCityUrl = "city";













}
