import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Models/transaction.dart';
import 'package:hidmona/Models/transaction_list_model.dart';
import 'package:hidmona/Repositories/api_constants.dart';
import 'package:hidmona/Repositories/api_response.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:http/http.dart' as http;

class TransactionRepository{
  CommonController commonController = Get.find<CommonController>();

  /// create Transaction
  static Future<APIResponse<Transaction>> createTransaction(TransactionRequestBody requestBody,
      ) async{

    ///internet check
    if(!await Utility.isInternetConnected()){
      return APIResponse<Transaction>(error: true, message: "Internet is not connected!");
    }

    print(json.encode(requestBody.toJson()));

    Uri url = Uri.parse(baseAPIUrl()+'transactions');
    return http.post(
        url,
        headers: headersWithAuthAndContentType,
        body: json.encode(requestBody.toJson())
    ).then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 201){
        return APIResponse<Transaction>(data: Transaction.fromJson(jsonData));
      }
      return APIResponse<Transaction>(error: true, message:jsonData["message"].runtimeType.toString() == "String"? jsonData["detail"]: jsonData["detail"][0]["loc"][1] +": "+ jsonData["detail"][0]["msg"]);
    }).catchError((onError){
      print(onError);
      return APIResponse<Transaction>(error: true, message: "An Error Occurred!");
    });
  }

  /// create Transaction
  static Future<APIResponse<Transaction>> createTransactionForBank(TransactionRequestBodyforBank requestBody,
      ) async{

    ///internet check
    if(!await Utility.isInternetConnected()){
      return APIResponse<Transaction>(error: true, message: "Internet is not connected!");
    }

    print(json.encode(requestBody.toJson()));

    Uri url = Uri.parse(baseAPIUrl()+'transactions');
    return http.post(
        url,
        headers: headersWithAuthAndContentType,
        body: json.encode(requestBody.toJson())
    ).then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 201){
        return APIResponse<Transaction>(data: Transaction.fromJson(jsonData));
      }
      return APIResponse<Transaction>(error: true, message:jsonData["message"].runtimeType.toString() == "String"? jsonData["detail"]: jsonData["detail"][0]["loc"][1] +": "+ jsonData["detail"][0]["msg"]);
    }).catchError((onError){
      print(onError);
      return APIResponse<Transaction>(error: true, message: "An Error Occurred!");
    });
  }


  // /// update Transaction
  // static Future<APIResponse<Transaction>> updateTransaction(int transactionId,RecipientRequestBody requestBody) async{
  //
  //   ///internet check
  //   if(!await Utility.isInternetConnected()){
  //     return APIResponse<Transaction>(error: true, errorMessage: "Internet is not connected!");
  //   }
  //
  //   Uri url = Uri.parse(baseAPIUrl()+'transaction/$transactionId');
  //   return http.put(
  //       url,
  //       headers: headersWithAuth,
  //       body: json.encode(requestBody.toJson())
  //   ).then((data){
  //     print(data.body);
  //     final responseData = utf8.decode(data.bodyBytes);
  //     final jsonData = json.decode(responseData);
  //     if(data.statusCode == 202){
  //       return APIResponse<Transaction>(data: Transaction.fromJson(jsonData['data']));
  //     }
  //     return APIResponse<Transaction>(error: true, errorMessage: jsonData["detail"]??"An error occurred");
  //   }).catchError((onError){
  //     print(onError);
  //     return APIResponse<Transaction>(error: true, errorMessage: "An Error Occurred!");
  //   });
  // }


  /// delete Transaction
  static Future<APIResponse<bool>> deleteTransaction(int transactionId) async{

    ///internet check
    if(!await Utility.isInternetConnected()){
      return APIResponse<bool>(error: true, message: "Internet is not connected!");
    }

    Uri url = Uri.parse(baseAPIUrl()+'transactions/$transactionId');
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
      return APIResponse<bool>(error: true, message: jsonData["detail"]??"An error occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<bool>(error: true, message: "An Error Occurred!");
    });
  }


  ///Transaction List
  static Future<APIResponse<List<TransactionData>>> getTransactions({int limit=100, offset=0}) async{
    if(!await Utility.isInternetConnected()){
      return APIResponse<List<TransactionData>>(error: true, message: "Internet is not connected!");
    }
    Uri url = Uri.parse(baseAPIUrl()+'transactions?limit=$limit&offset=$offset');
    return http.get(url,headers: headersWithAuth)
        .then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 200){
        List<TransactionData> transactions = [];
        jsonData['data'].forEach((transaction){
          transactions.add(TransactionData.fromJson(transaction));
        });
        return APIResponse<List<TransactionData>>(data: transactions);
      }
      return APIResponse<List<TransactionData>>(error: true, message: jsonData["message"]??"An Error Occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<List<TransactionData>>(error: true, message: "An Error Occurred!");
    });
  }



  /// getTransactionDetails
  static Future<APIResponse<Transaction>> getTransactionDetails(String transactionNumber) async{

    ///internet check
    if(!await Utility.isInternetConnected()){
      return APIResponse<Transaction>(error: true, message: "Internet is not connected!");
    }

    Uri url = Uri.parse(baseAPIUrl()+'transactions/$transactionNumber');
    return http.get(url,headers: headersWithAuth).then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 200){
        return APIResponse<Transaction>(data: Transaction.fromJson(jsonData));
      }
      return APIResponse<Transaction>(error: true, message: jsonData["message"]??"An error occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<Transaction>(error: true, message: "An Error Occurred!");
    });
  }
}