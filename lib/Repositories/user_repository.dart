import 'dart:convert';

import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Models/app_user.dart';
import 'package:hidmona/Models/forgate_password_model.dart';
import 'package:hidmona/Models/user_profile.dart';
import 'package:hidmona/Models/user_signup.dart';
import 'package:hidmona/Repositories/api_constants.dart';
import 'package:hidmona/Repositories/api_response.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:http/http.dart' as http;

class UserRepository{
  /// adminLogin
  static Future<APIResponse<AppUser>> adminLogin(String email, String password) async{

    ///internet check
    if(!await Utility.isInternetConnected()){
      return APIResponse<AppUser>(error: true, message: "Internet is not connected!");
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
      return APIResponse<AppUser>(error: true, message:jsonData["detail"].runtimeType.toString() == "String"? jsonData["detail"]: jsonData["detail"][0]["loc"][1] +": "+ jsonData["detail"][0]["msg"]);
    }).catchError((onError){
      print(onError);
      return APIResponse<AppUser>(error: true, message: "An Error Occurred!");
    });
  }


  /// customerLogin
  static Future<APIResponse<AppUser>> customerLogin(String email, String password) async{

    ///internet check
    if(!await Utility.isInternetConnected()){
      return APIResponse<AppUser>(error: true, message: "Internet is not connected!");
    }
    Uri url = Uri.parse(baseAPIUrl()+'customer-login');
    return http.post(
        url,
        body: json.encode({
          'email' : email,
          'password': password,
        }),headers: headers,
    ).then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 200){

        Get.find<CommonController>().getStorage.write("email", email);
        Get.find<CommonController>().getStorage.write("password", password);
        //Get.find<CommonController>().getStorage.write("loginChecker", true);

        AppUser appUser = AppUser.fromJson(jsonData);
        Get.find<CommonController>().currentUser.value = appUser;
        return APIResponse<AppUser>(data: appUser);
      }
      return APIResponse<AppUser>(error: true, message:jsonData["message"].runtimeType.toString() == "String"? jsonData["message"]: jsonData["message"][0]["loc"][1] +": "+ jsonData["message"][0]["msg"]);
    }).catchError((onError){
      print(onError);
      return APIResponse<AppUser>(error: true, message: "An Error Occurred!");
    });
  }


  /// customerSignup
  static Future<APIResponse<bool>> signUp(UserSignupRequest userSignupRequest) async{

    ///internet check
    if(!await Utility.isInternetConnected()){
      return APIResponse<bool>(error: true, message: "Internet is not connected!");
    }

    Uri url = Uri.parse(baseAPIUrl()+'signup');
    return http.post(
        url,
        headers: headers,
        body: json.encode(userSignupRequest.toJson())
    ).then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 201){
        return APIResponse<bool>(data: true,error: false,message:jsonData["message"] );
      }
      return APIResponse<bool>(error: true, message:jsonData["message"].toString() == "String"? jsonData["detail"]: jsonData["detail"][0]["loc"][1] +": "+ jsonData["detail"][0]["msg"]);
    }).catchError((onError){
      print(onError);
      return APIResponse<bool>(error: true, message: "An Error Occurred!");
    });
  }


  /// getUserProfile
  static Future<APIResponse<UserProfile>> getUserProfile() async{

    ///internet check
    if(!await Utility.isInternetConnected()){
      return APIResponse<UserProfile>(error: true, message: "Internet is not connected!");
    }

    print(headersWithAuth);

    Uri url = Uri.parse(baseAPIUrl()+'profile');
    return http.get(url,headers: headersWithAuth).then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 200){
        return APIResponse<UserProfile>(data: UserProfile.fromJson(jsonData));
      }
      return APIResponse<UserProfile>(error: true, message: jsonData["detail"]??"An error occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<UserProfile>(error: true, message: "An Error Occurred!");
    });
  }


  /// forgetPassword
  // static Future<APIResponse<ForgotPassword>> forgetPassword(String email) async{
  //
  //   ///internet check
  //   if(!await Utility.isInternetConnected()){
  //     return APIResponse<ForgotPassword>(error: true, message: "Internet is not connected!");
  //   }
  //
  //   print(headersWithAuth);
  //
  //   Uri url = Uri.parse(baseAPIUrl()+'forget-password');
  //   return http.post(
  //       url,
  //       headers: headers,
  //       body: json.encode({"email" : email})
  //   ).then((data){
  //     print(data.body);
  //     final responseData = utf8.decode(data.bodyBytes);
  //     final jsonData = json.decode(responseData);
  //     if(data.statusCode == 200){
  //       return APIResponse<ForgotPassword>(data: ForgotPassword.fromJson(jsonData));
  //     }
  //     return APIResponse<ForgotPassword>(error: true, message: jsonData["detail"]??"An error occurred");
  //   }).catchError((onError){
  //     print(onError);
  //     return APIResponse<ForgotPassword>(error: true, message: "An Error Occurred!");
  //   });
  // }

  static Future<APIResponse<String>> forgetPassword(String email) async{

    ///internet check
    if(!await Utility.isInternetConnected()){
      return APIResponse<String>(error: true, message: "Internet is not connected!");
    }

    Uri url = Uri.parse(baseAPIUrl()+'forget-password');
    return http.post(
        url,
        headers: headers,
        body: json.encode({"email" : email})
    ).then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      // if(data.statusCode == 200){
      //   return APIResponse<String>(data: AppUser.fromJson(jsonData));
      // }
      return APIResponse<String>(error: false, data:jsonData["message"].runtimeType.toString() == "String"? jsonData["message"]: jsonData["message"][0]["loc"][1] +": "+ jsonData["message"][0]["msg"]);
    }).catchError((onError){
      print(onError);
      return APIResponse<String>(error: true, message: "An Error Occurred!");
    });
  }



  /// resetPassword
  static Future<APIResponse<String>> changePassword(String oldPassword,String newPassword) async{

    ///internet check
    if(!await Utility.isInternetConnected()){
      return APIResponse<String>(error: true, message: "Internet is not connected!");
    }

    Uri url = Uri.parse(baseAPIUrl()+'users/password_change');
    return http.patch(
        url,
        headers: headersWithAuth,
        body: json.encode({"new_password" : newPassword, "confirm_password":newPassword,"previous_password":oldPassword})
    ).then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 200){
        return APIResponse<String>(error: false, data:jsonData["detail"].runtimeType.toString() == "String"? jsonData["detail"]: jsonData["detail"][0]["loc"][1] +": "+ jsonData["detail"][0]["msg"]);
      }
      return APIResponse<String>(error: true, message:jsonData["detail"].runtimeType.toString() == "String"? jsonData["detail"]: jsonData["detail"][0]["loc"][1] +": "+ jsonData["detail"][0]["msg"]);
    }).catchError((onError){
      print(onError);
      return APIResponse<String>(error: true, message: "An Error Occurred!");
    });
  }
}