import 'dart:convert';

import 'package:hidmona/Models/app_user.dart';
import 'package:hidmona/Models/recipient.dart';
import 'package:hidmona/Repositories/api_constants.dart';
import 'package:hidmona/Repositories/api_response.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:http/http.dart' as http;

class RecipientRepository{
  /// create Recipient
  static Future<APIResponse<Recipient>> createRecipient(RecipientRequestBody requestBody) async{

    ///internet check
    if(!await Utility.isInternetConnected()){
      return APIResponse<Recipient>(error: true, errorMessage: "Internet is not connected!");
    }

    Uri url = Uri.parse(baseAPIUrl()+'recipients');
    return http.post(
        url,
        headers: headersWithAuth,
        body: json.encode(requestBody.toJson())
    ).then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 201){
        return APIResponse<Recipient>(data: Recipient.fromJson(jsonData['data']));
      }
      return APIResponse<Recipient>(error: true, errorMessage: jsonData["detail"]??"An error occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<Recipient>(error: true, errorMessage: "An Error Occurred!");
    });
  }


  /// update Recipient
  static Future<APIResponse<Recipient>> updateRecipient(int recipientId,RecipientRequestBody requestBody) async{

    ///internet check
    if(!await Utility.isInternetConnected()){
      return APIResponse<Recipient>(error: true, errorMessage: "Internet is not connected!");
    }

    Uri url = Uri.parse(baseAPIUrl()+'recipients/$recipientId');
    return http.put(
        url,
        headers: headersWithAuth,
        body: json.encode(requestBody.toJson())
    ).then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 202){
        return APIResponse<Recipient>(data: Recipient.fromJson(jsonData['data']));
      }
      return APIResponse<Recipient>(error: true, errorMessage: jsonData["detail"]??"An error occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<Recipient>(error: true, errorMessage: "An Error Occurred!");
    });
  }


  /// delete Recipient
  static Future<APIResponse<bool>> deleteRecipient(int recipientId) async{

    ///internet check
    if(!await Utility.isInternetConnected()){
      return APIResponse<bool>(error: true, errorMessage: "Internet is not connected!");
    }

    Uri url = Uri.parse(baseAPIUrl()+'recipients/$recipientId');
    return http.delete(
        url,
        headers: headersWithAuth,
    ).then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 200){
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: jsonData["detail"]??"An error occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<bool>(error: true, errorMessage: "An Error Occurred!");
    });
  }


  ///getRecipients
  static Future<APIResponse<List<Recipient>>> getRecipients(int countryId) async{
    if(!await Utility.isInternetConnected()){
      return APIResponse<List<Recipient>>(error: true, errorMessage: "Internet is not connected!");
    }
    Uri url = Uri.parse(baseAPIUrl()+'recipients');
    return http.get(url,headers: headersWithAuth)
        .then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 200){
        List<Recipient> recipients = [];
        jsonData['items'].forEach((purpose){
          recipients.add(Recipient.fromJson(purpose));
        });
        return APIResponse<List<Recipient>>(data: recipients);
      }
      return APIResponse<List<Recipient>>(error: true, errorMessage: jsonData["detail"]??"An Error Occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<List<Recipient>>(error: true, errorMessage: "An Error Occurred!");
    });
  }
}