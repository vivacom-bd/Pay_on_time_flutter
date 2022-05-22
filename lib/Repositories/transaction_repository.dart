import 'dart:convert';

import 'package:hidmona/Models/transaction.dart';
import 'package:hidmona/Repositories/api_constants.dart';
import 'package:hidmona/Repositories/api_response.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:http/http.dart' as http;

class TransactionRepository{
  /// create Transaction
  static Future<APIResponse<Transaction>> createTransaction(TransactionRequestBody requestBody) async{

    ///internet check
    if(!await Utility.isInternetConnected()){
      return APIResponse<Transaction>(error: true, message: "Internet is not connected!");
    }

    Uri url = Uri.parse(baseAPIUrl()+'transactions');
    return http.post(
        url,
        headers: headersWithAuth,
        body: json.encode(requestBody.toJson())
    ).then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 201){
        return APIResponse<Transaction>(data: Transaction.fromJson(jsonData['data']));
      }
      return APIResponse<Transaction>(error: true, message:jsonData["detail"].runtimeType.toString() == "String"? jsonData["detail"]: jsonData["detail"][0]["loc"][1] +": "+ jsonData["detail"][0]["msg"]);
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


  ///getRecipients
  static Future<APIResponse<List<Transaction>>> getTransactions({int limit=50, offset=0}) async{
    if(!await Utility.isInternetConnected()){
      return APIResponse<List<Transaction>>(error: true, message: "Internet is not connected!");
    }
    Uri url = Uri.parse(baseAPIUrl()+'transactions?limit=$limit&offset=$offset');
    return http.get(url,headers: headersWithAuth)
        .then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 200){
        List<Transaction> transactions = [];
        jsonData['items'].forEach((transaction){
          transactions.add(Transaction.fromJson(transaction));
        });
        return APIResponse<List<Transaction>>(data: transactions);
      }
      return APIResponse<List<Transaction>>(error: true, message: jsonData["detail"]??"An Error Occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<List<Transaction>>(error: true, message: "An Error Occurred!");
    });
  }



  /// getTransactionDetails
  static Future<APIResponse<Transaction>> getTransactionDetails(int transactionNumber) async{

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
      return APIResponse<Transaction>(error: true, message: jsonData["detail"]??"An error occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<Transaction>(error: true, message: "An Error Occurred!");
    });
  }
}