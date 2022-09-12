import 'dart:convert';

import 'package:hidmona/Models/card.dart';
import 'package:hidmona/Models/card_info.dart';
import 'package:hidmona/Models/pyament_auth_response.dart';
import 'package:hidmona/Repositories/api_constants.dart';
import 'package:hidmona/Repositories/api_response.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:http/http.dart' as http;

class PaymentRepository{
  ///getCards
  static Future<APIResponse<List<PaymentCard>>> getCards() async{
    if(!await Utility.isInternetConnected()){
      return APIResponse<List<PaymentCard>>(error: true, message: "Internet is not connected!");
    }
    Uri url = Uri.parse(baseAPIUrl()+'card');
    return http.get(url,headers: headersWithAuth)
        .then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 200){
        List<PaymentCard> cards = [];
        jsonData['items'].forEach((card){
          cards.add(PaymentCard.fromJson(card));
        });
        return APIResponse<List<PaymentCard>>(data: cards);
      }
      return APIResponse<List<PaymentCard>>(error: true, message: jsonData["detail"]??"An Error Occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<List<PaymentCard>>(error: true, message: "An Error Occurred!");
    });
  }


  ///deleteCard
  static Future<APIResponse<bool>> deleteCard(int id) async{
    if(!await Utility.isInternetConnected()){
      return APIResponse<bool>(error: true, message: "Internet is not connected!");
    }
    Uri url = Uri.parse(baseAPIUrl()+'card/$id');
    return http.get(url,headers: headersWithAuth)
        .then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 200){
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, message: jsonData["detail"]??"An Error Occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<bool>(error: true, message: "An Error Occurred!");
    });
  }



  /// paymentByCardId
  static Future<APIResponse<bool>> paymentByCardId(int cardId, String transactionNumber) async{

    ///internet check
    if(!await Utility.isInternetConnected()){
      return APIResponse<bool>(error: true, message: "Internet is not connected!");
    }

    Uri url = Uri.parse(baseAPIUrl()+'payment/trust_pay/transaction_with_card/$cardId?transaction_number=$transactionNumber');
    return http.post(
        url,
        headers: headersWithAuth,
    ).then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 201){
        return APIResponse<bool>(data: true,message:jsonData["detail"].runtimeType.toString() == "String"? jsonData["detail"]: jsonData["detail"][0]["loc"][1] +": "+ jsonData["detail"][0]["msg"]);
      }
      return APIResponse<bool>(error: true, message:jsonData["detail"].runtimeType.toString() == "String"? jsonData["detail"]: jsonData["detail"][0]["loc"][1] +": "+ jsonData["detail"][0]["msg"]);
    }).catchError((onError){
      print(onError);
      return APIResponse<bool>(error: true, message: "An Error Occurred!");
    });
  }



  /// paymentAndSaveCard
  static Future<APIResponse<bool>> paymentAndSaveCard(CardInfo cardInfo, String transactionNumber) async{

    ///internet check
    if(!await Utility.isInternetConnected()){
      return APIResponse<bool>(error: true, message: "Internet is not connected!");
    }

    Uri url = Uri.parse(baseAPIUrl()+'payment/trust_pay/card_save?transaction_number=$transactionNumber');
    return http.post(
      url,
      headers: headersWithAuth,
      body: json.encode(cardInfo.toJson())
    ).then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 201){
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, message:jsonData["detail"].runtimeType.toString() == "String"? jsonData["detail"]: jsonData["detail"][0]["loc"][1] +": "+ jsonData["detail"][0]["msg"]);
    }).catchError((onError){
      print(onError);
      return APIResponse<bool>(error: true, message: "An Error Occurred!");
    });
  }



  /// paymentWithoutSaveCard
  static Future<APIResponse<bool>> paymentWithoutSaveCard(CardInfo cardInfo, String transactionNumber) async{

    ///internet check
    if(!await Utility.isInternetConnected()){
      return APIResponse<bool>(error: true, message: "Internet is not connected!");
    }

    Uri url = Uri.parse(baseAPIUrl()+'payment/trust_pay/transaction_once?transaction_number=$transactionNumber');
    return http.post(
        url,
        headers: headersWithAuth,
        body: json.encode(cardInfo.toJson())
    ).then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 201){
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, message:jsonData["detail"].runtimeType.toString() == "String"? jsonData["detail"]: jsonData["detail"][0]["loc"][1] +": "+ jsonData["detail"][0]["msg"]);
    }).catchError((onError){
      print(onError);
      return APIResponse<bool>(error: true, message: "An Error Occurred!");
    });
  }


  /// 3d Auth Payment
  static Future<APIResponse<PaymentAuthResponse>> payment3dAuth(String transactionNumber,int isCardSave) async{

    ///internet check
    if(!await Utility.isInternetConnected()){
      return APIResponse<PaymentAuthResponse>(error: true, message: "Internet is not connected!");
    }

    Uri url = Uri.parse(baseAPIUrl()+'payment/trust_pay/3d_authentication?transaction_number=$transactionNumber&credentialsonfile=$isCardSave');
    return http.get(
        url,
        headers: headersWithAuth,
    ).then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 201){
        print(jsonData);
        return APIResponse<PaymentAuthResponse>(data: PaymentAuthResponse.fromJson(jsonData));
      }
      return APIResponse<PaymentAuthResponse>(error: true, message:jsonData["detail"].runtimeType.toString() == "String"? jsonData["detail"]: jsonData["detail"][0]["loc"][1] +": "+ jsonData["detail"][0]["msg"]);
    }).catchError((onError){
      print(onError);
      return APIResponse<PaymentAuthResponse>(error: true, message: "An Error Occurred!");
    });
  }


  /// Transaction Confirmation
  static Future<APIResponse<bool>> transactionConfirmation(String jwt) async{

    ///internet check
    if(!await Utility.isInternetConnected()){
      return APIResponse<bool>(error: true, message: "Internet is not connected!");
    }

    Uri url = Uri.parse(baseAPIUrl()+'payment/trust_pay/transaction_confirmation?jwt=$jwt');
    return http.post(
        url,
        headers: headersWithAuth,
    ).then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 201){
        print(jsonData);
        return APIResponse<bool>(error: false,data: true, message:jsonData["detail"].runtimeType.toString() == "String"? jsonData["detail"]: jsonData["detail"][0]["loc"][1] +": "+ jsonData["detail"][0]["msg"]);
      }
      return APIResponse<bool>(error: true, message:jsonData["detail"].runtimeType.toString() == "String"? jsonData["detail"]: jsonData["detail"][0]["loc"][1] +": "+ jsonData["detail"][0]["msg"]);
    }).catchError((onError){
      print(onError);
      return APIResponse<bool>(error: true, message: "An Error Occurred!");
    });
  }
}