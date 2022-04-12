import 'dart:convert';

import 'package:hidmona/Models/card.dart';
import 'package:hidmona/Repositories/api_constants.dart';
import 'package:hidmona/Repositories/api_response.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:http/http.dart' as http;

class PaymentRepository{
  ///getCards
  static Future<APIResponse<List<Card>>> getCards() async{
    if(!await Utility.isInternetConnected()){
      return APIResponse<List<Card>>(error: true, errorMessage: "Internet is not connected!");
    }
    Uri url = Uri.parse(baseAPIUrl()+'card');
    return http.get(url,headers: headersWithAuth)
        .then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 200){
        List<Card> cards = [];
        jsonData['items'].forEach((card){
          cards.add(Card.fromJson(card));
        });
        return APIResponse<List<Card>>(data: cards);
      }
      return APIResponse<List<Card>>(error: true, errorMessage: jsonData["detail"]??"An Error Occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<List<Card>>(error: true, errorMessage: "An Error Occurred!");
    });
  }
}