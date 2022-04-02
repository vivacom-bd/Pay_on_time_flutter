import 'dart:convert';

import 'package:hidmona/Models/app_user.dart';
import 'package:hidmona/Repositories/api_constants.dart';
import 'package:hidmona/Repositories/api_response.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:http/http.dart' as http;

class UserRepository{
  /// getCurrencyConversion
  static Future<APIResponse<AppUser>> login(String email, String password) async{

    ///internet check
    if(!await Utility.isInternetConnected()){
      return APIResponse<AppUser>(error: true, errorMessage: "Internet is not connected!");
    }

    Uri url = Uri.parse(baseAPIUrl()+'login');
    return http.post(
        url,
        headers: headers,
        body: json.encode({"email" : email, "password": password})
    ).then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 200){
        return APIResponse<AppUser>(data: AppUser.fromJson(jsonData));
      }
      return APIResponse<AppUser>(error: true, errorMessage: jsonData["detail"]??"An error occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<AppUser>(error: true, errorMessage: "An Error Occurred!");
    });
  }
}