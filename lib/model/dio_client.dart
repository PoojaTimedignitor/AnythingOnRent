
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../ApiConstant/api_constant.dart';
import '../ConstantData/Constant_data.dart';

class ApiClients {
 final Dio _dio = Dio();






 Future<Map<String, dynamic>> registerDio(
     String name,
     String email,
     String password,
     String cpassword,
     String phoneNumber,
     String currentAddress,
     String permanentAddress,


     ) async {
   String url = ApiConstant().BaseUrl + ApiConstant().registerss;

   String? sessionToken =
   GetStorage().read<String>(ConstantData.UserAccessToken);
   print("Session Token: $sessionToken");
   try {
     Response response = await _dio.post<Map<String, dynamic>>(
       url,
       data: {
 'name': name,
 'email': email,
 'password': password,
 'cpassword': cpassword,
 'phoneNumber': phoneNumber,
 'currentAddress': currentAddress,
 'permanentAddress': permanentAddress

 },
       options: Options(
         headers: {
           'Authorization': 'Bearer $sessionToken',
         },
       ),
     );
     print("statusCode --> ${response.statusCode}");
     print("dateeeee --> ${response.data}");
     return response.data;
   } on DioError catch (e) {
     return e.response!.data;
   }
 }


/*Future<Map<String, dynamic>> registerDio(

) async {
  String url = ApiConstant().BaseUrl + ApiConstant().registerss;

  String? sessionToken =
  GetStorage().read<String>(ConstantData.UserAccessToken);


  try {
   Response response = await _dio.P(url,
    options: Options(
     headers: {
      'Authorization': 'Bearer $sessionToken',
     },
    ),
   );


*//* if (response.statusCode == 200) {
 print(json.encode(response.data));
 }
 else {
 print(response.statusMessage);
 }*//*


   print("statusCode --> ${response.statusCode}");
   print("data --> ${response.data}");

   return response.data;
  } on DioError catch (e) {
   return e.response!.data;
  }
}*/




 }




