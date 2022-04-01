import 'dart:convert';
import 'package:hidmona/Models/currency_conversion_details.dart';
import 'package:hidmona/Models/mode_of_payment.dart';
import 'package:hidmona/Models/server_country.dart';
import 'package:hidmona/Models/server_currency.dart';
import 'package:hidmona/Repositories/api_response.dart';
import 'package:hidmona/Repositories/api_constants.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:http/http.dart' as http;

class CommonRepository{

  /// getCountries
  static Future<APIResponse<List<ServerCountry>>> getCountries() async{

    ///internet check
    if(!await Utility.isInternetConnected()){
      return APIResponse<List<ServerCountry>>(error: true, errorMessage: "Internet is not connected!");
    }
    Uri url = Uri.parse(baseAPIUrl()+'public/country');
    return http.get(url).then((data) async {
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 200){
        List<ServerCountry> countries = [];
        for(int i=0; i<jsonData.length; i++) {
          ServerCountry serverCountry = ServerCountry.fromJson(jsonData[i]);

          // APIResponse<ServerCurrency> apiResponse = await getCountryDefaultCurrency(serverCountry.id!);
          // if(apiResponse.data!=null){
          //   serverCountry.defaultCurrency = apiResponse.data;
          // }else{
          //   return APIResponse<List<ServerCountry>>(error: true, errorMessage: "No default currency for ${serverCountry.name}");
          // }

          countries.add(serverCountry);
        }

        return APIResponse<List<ServerCountry>>(data: countries);
      }
      return APIResponse<List<ServerCountry>>(error: true, errorMessage: jsonData["detail"]??"An error occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<List<ServerCountry>>(error: true, errorMessage: "An Error Occurred!");
    });
  }



  /// getCountryDefaultCurrency
  static Future<APIResponse<ServerCurrency>> getCountryDefaultCurrency(int countryId) async{

    ///internet check
    if(!await Utility.isInternetConnected()){
      return APIResponse<ServerCurrency>(error: true, errorMessage: "Internet is not connected!");
    }

    Uri url = Uri.parse(baseAPIUrl()+'public/country_to_default_currency?country_id=$countryId');
    return http.get(url).then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 200){
        return APIResponse<ServerCurrency>(data: ServerCurrency.fromJson(jsonData));
      }
      return APIResponse<ServerCurrency>(error: true, errorMessage: jsonData["detail"]??"An error occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<ServerCurrency>(error: true, errorMessage: "An Error Occurred!");
    });
  }


  /// getCurrencyConversion
  static Future<APIResponse<CurrencyConversionDetails>> getConversionDetails(double amount, int fromCurrencyId, int toCurrencyId) async{

    ///internet check
    if(!await Utility.isInternetConnected()){
      return APIResponse<CurrencyConversionDetails>(error: true, errorMessage: "Internet is not connected!");
    }

    Uri url = Uri.parse(baseAPIUrl()+'public/currency_conversion?from_currency_id=$fromCurrencyId&to_currency_id=$toCurrencyId');
    return http.post(
        url,
        headers: headers,
        body: json.encode({"amount" : amount})
    ).then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 200){
        return APIResponse<CurrencyConversionDetails>(data: CurrencyConversionDetails.fromJson(jsonData));
      }
      return APIResponse<CurrencyConversionDetails>(error: true, errorMessage: jsonData["message"]??"An error occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<CurrencyConversionDetails>(error: true, errorMessage: "An Error Occurred!");
    });
  }

  ///getPaymentMethod
  static Future<APIResponse<List<ModeOfPayment>>> getModeOfPayment(int countryId) async{
    if(!await Utility.isInternetConnected()){
      return APIResponse<List<ModeOfPayment>>(error: true, errorMessage: "Internet is not connected!");
    }
    Uri url = Uri.parse(baseAPIUrl()+'public/delivery_method/$countryId');
    return http.get(url)
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
      return APIResponse<List<ModeOfPayment>>(error: true, errorMessage: jsonData["detail"]??"An Error Occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<List<ModeOfPayment>>(error: true, errorMessage: "An Error Occurred!");
    });
  }

  ///getPaymentMethod
  static Future<APIResponse<List<ModeOfPayment>>> getModeOfReceive(int countryId) async{
    if(!await Utility.isInternetConnected()){
      return APIResponse<List<ModeOfPayment>>(error: true, errorMessage: "Internet is not connected!");
    }
    Uri url = Uri.parse(baseAPIUrl()+'public/receive_method/$countryId');
    return http.get(url)
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
      return APIResponse<List<ModeOfPayment>>(error: true, errorMessage: jsonData["detail"]??"An Error Occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<List<ModeOfPayment>>(error: true, errorMessage: "An Error Occurred!");
    });
  }



}