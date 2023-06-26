import 'dart:convert';
import 'package:hidmona/Models/mode_of_payment.dart';
import 'package:hidmona/Repositories/api_response.dart';
import 'package:hidmona/Repositories/api_constants.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:http/http.dart' as http;

class CardRemittanceSystem {

  ///getPaymentMethod
  static Future<APIResponse<List<ModeOfPayment>>> getModeOfPayment(int countryId) async{
    if(!await Utility.isInternetConnected()){
      return APIResponse<List<ModeOfPayment>>(error: true, message: "Internet is not connected!");
    }
    Uri url = Uri.parse(baseAPIUrl()+'public/payment_method/$countryId');
    return http.get(url,headers: headersWithAuth)
        .then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 200){
        List<ModeOfPayment> modes = [];
        jsonData.forEach((mode){
          modes.add(ModeOfPayment.fromJson(mode));
        });
        return APIResponse<List<ModeOfPayment>>(data: modes);
      }
      return APIResponse<List<ModeOfPayment>>(error: true, message: jsonData["detail"]??"An Error Occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<List<ModeOfPayment>>(error: true, message: "An Error Occurred!");
    });
  }

}