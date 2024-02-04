import 'dart:convert';
import 'package:hidmona/Models/city.dart';
import 'package:hidmona/Models/country_wise_bank.dart';
import 'package:hidmona/Models/currency_conversion_details.dart';
import 'package:hidmona/Models/mode_of_payment.dart';
import 'package:hidmona/Models/recipient_bank.dart';
import 'package:hidmona/Models/sending_purpose.dart';
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
      return APIResponse<List<ServerCountry>>(error: true, message: "Internet is not connected!");
    }
    Uri url = Uri.parse(baseAPIUrl()+'get-countries');
    return http.get(url).then((data) async {
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 200){
        List<ServerCountry> countries = [];
        for(int i=0; i<jsonData.length; i++) {
          ServerCountry serverCountry = ServerCountry.fromJson(jsonData[i]);
          countries.add(serverCountry);
        }

        return APIResponse<List<ServerCountry>>(data: countries);
      }
      return APIResponse<List<ServerCountry>>(error: true, message: jsonData["detail"]??"An error occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<List<ServerCountry>>(error: true, message: "An Error Occurred!");
    });
  }



  // /// getCountryDefaultCurrency
  // static Future<APIResponse<ServerCurrency>> getCountryDefaultCurrency(int countryId) async{
  //
  //   ///internet check
  //   if(!await Utility.isInternetConnected()){
  //     return APIResponse<ServerCurrency>(error: true, message: "Internet is not connected!");
  //   }
  //
  //   Uri url = Uri.parse(baseAPIUrl()+'public/country_to_default_currency?country_id=$countryId');
  //   return http.get(url).then((data){
  //     print(data.body);
  //     final responseData = utf8.decode(data.bodyBytes);
  //     final jsonData = json.decode(responseData);
  //     if(data.statusCode == 200){
  //       return APIResponse<ServerCurrency>(data: ServerCurrency.fromJson(jsonData));
  //     }
  //     return APIResponse<ServerCurrency>(error: true, message: jsonData["detail"]??"An error occurred");
  //   }).catchError((onError){
  //     print(onError);
  //     return APIResponse<ServerCurrency>(error: true, message: "An Error Occurred!");
  //   });
  // }



  ///getCurrenciesOnCountry
  static Future<APIResponse<List<ServerCurrency>>> getCurrenciesOnCountry(int countryId) async{
    if(!await Utility.isInternetConnected()){
      return APIResponse<List<ServerCurrency>>(error: true, message: "Internet is not connected!");
    }
    Uri url = Uri.parse(baseAPIUrl()+'get-currencies?country_id=$countryId');
    return http.get(url,headers: headersWithAuth)
        .then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 200){
        List<ServerCurrency> currencies = [];
        jsonData.forEach((currency){
          currencies.add(ServerCurrency.fromJson(currency));
        });
        return APIResponse<List<ServerCurrency>>(data: currencies);
      }
      return APIResponse<List<ServerCurrency>>(error: true, message: jsonData["detail"]??"An Error Occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<List<ServerCurrency>>(error: true, message: "An Error Occurred!");
    });
  }



  /// getCurrencyConversion
  static Future<APIResponse<CurrencyConversionDetails>> getConversionDetails(String currencySource ,double amount, int fromCurrencyId, int toCurrencyId, int fromCountryId, int toCountryId) async{

    ///internet check
    if(!await Utility.isInternetConnected()){
      return APIResponse<CurrencyConversionDetails>(error: true, message: "Internet is not connected!");
    }
    print("jehan - $currencySource");
    json.encode({
      "amount" : amount,
      "from_currency_id" : fromCurrencyId,
      "to_currency_id" : toCurrencyId,
      "from_country_id" : fromCountryId,
      "to_country_id" : toCountryId,
      "currency_source" : currencySource
    });
    Uri url = Uri.parse(baseAPIUrl()+'currency_conversion?from_currency_id=$fromCurrencyId&to_currency_id=$toCurrencyId&from_country_id=$fromCountryId&to_country_id=$toCountryId&amount=$amount');
    return http.get(
        url,
        headers: headers,
    ).then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 200){
        return APIResponse<CurrencyConversionDetails>(data: CurrencyConversionDetails.fromJson(jsonData));
      }
      print(jsonData["message"].runtimeType);
      return APIResponse<CurrencyConversionDetails>(error: true, message:jsonData["message"].runtimeType.toString() == "String"? jsonData["message"]: jsonData["message"][0]["loc"][1] +": "+ jsonData["message"][0]["msg"]);
    }).catchError((onError){
      print(onError);
      return APIResponse<CurrencyConversionDetails>(error: true, message: "An Error Occurred!");
    });
  }

  ///getPaymentMethod
  static Future<APIResponse<List<ModeOfPayment>>> getModeOfPayment(int countryId) async{
    if(!await Utility.isInternetConnected()){
      return APIResponse<List<ModeOfPayment>>(error: true, message: "Internet is not connected!");
    }
    Uri url = Uri.parse(baseAPIUrl()+'get-payment-methods/$countryId');
    return http.get(url,headers: headers)
        .then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 200){
        List<ModeOfPayment> modes = [];
        jsonData['data'].forEach((mode){
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

  ///getModeOfReceive
  static Future<APIResponse<List<ModeOfPayment>>> getModeOfReceive(int countryId) async{
    if(!await Utility.isInternetConnected()){
      return APIResponse<List<ModeOfPayment>>(error: true, message: "Internet is not connected!");
    }
    Uri url = Uri.parse(baseAPIUrl()+'get-receive-methods/$countryId');
    return http.get(url,headers: headers)
        .then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 200){
        List<ModeOfPayment> modes = [];
        jsonData['data'].forEach((mode){
          modes.add(ModeOfPayment.fromJson(mode));
        });
        return APIResponse<List<ModeOfPayment>>(data: modes);
      }
      return APIResponse<List<ModeOfPayment>>(error: true, message: jsonData["message"]??"An Error Occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<List<ModeOfPayment>>(error: true, message: "An Error Occurred!");
    });
  }

  ///getSendingPurposes
  static Future<APIResponse<List<SendingPurpose>>> getSendingPurposes() async{
    if(!await Utility.isInternetConnected()){
      return APIResponse<List<SendingPurpose>>(error: true, message: "Internet is not connected!");
    }
    Uri url = Uri.parse(baseAPIUrl()+'getSendingPurposes');
    return http.get(url,headers: headersWithAuth)
        .then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 200){
        List<SendingPurpose> purposes = [];
        jsonData['data'].forEach((purpose){
          purposes.add(SendingPurpose.fromJson(purpose));
        });
        return APIResponse<List<SendingPurpose>>(data: purposes);
      }
      return APIResponse<List<SendingPurpose>>(error: true, message: jsonData["message"]??"An Error Occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<List<SendingPurpose>>(error: true, message: "An Error Occurred!");
    });
  }

  ///getPaymentMethod
  static Future<APIResponse<List<City>>> getCities(int countryId) async{
    if(!await Utility.isInternetConnected()){
      return APIResponse<List<City>>(error: true, message: "Internet is not connected!");
    }
    Uri url = Uri.parse(baseAPIUrl()+'city_list_based_on_country/$countryId');
    return http.get(url,headers: headersWithAuth)
        .then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData1 = json.decode(responseData);
      final jsonData = jsonData1['data'];
      if(data.statusCode == 200){
        List<City> cities = [];
        jsonData.forEach((purpose){
          cities.add(City.fromJson(purpose));
        });
        return APIResponse<List<City>>(data: cities);
      }
      return APIResponse<List<City>>(error: true, message: jsonData["message"]??"An Error Occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<List<City>>(error: true, message: "An Error Occurred!");
    });
  }


  ///getCountryWiseBanks
  static Future<APIResponse<List<CountryWiseBank>>> getCountryWiseBanks(String countryId) async{
    if(!await Utility.isInternetConnected()){
      return APIResponse<List<CountryWiseBank>>(error: true, message: "Internet is not connected!");
    }
    Uri url = Uri.parse(baseAPIUrl()+'getCountryWiseBanks?country_id=$countryId');
    return http.get(url,headers: headersWithAuth)
        .then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 200){
        List<CountryWiseBank> banks = [];
        jsonData['data'].forEach((bank){
          banks.add(CountryWiseBank.fromJson(bank));
        });
        return APIResponse<List<CountryWiseBank>>(data: banks);
      }
      return APIResponse<List<CountryWiseBank>>(error: true, message: jsonData["message"]??"An Error Occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<List<CountryWiseBank>>(error: true, message: "An Error Occurred!");
    });
  }

  ///getRecipientBanks
  static Future<APIResponse<List<RecipientBank>>> getRecipientBanks(int countryId) async{
    if(!await Utility.isInternetConnected()){
      return APIResponse<List<RecipientBank>>(error: true, message: "Internet is not connected!");
    }
    Uri url = Uri.parse(baseAPIUrl()+'get-recipient-banks/$countryId');
    return http.get(url,headers: headersWithAuth)
        .then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 200){
        List<RecipientBank> banks = [];
        jsonData.forEach((purpose){
          banks.add(RecipientBank.fromJson(purpose));
        });
        return APIResponse<List<RecipientBank>>(data: banks);
      }
      return APIResponse<List<RecipientBank>>(error: true, message: jsonData["message"]??"An Error Occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<List<RecipientBank>>(error: true, message: "An Error Occurred!");
    });
  }

  ///getRecipientBankBranches
  static Future<APIResponse<List<RecipientBankBranch>>> getRecipientBankBranches(int bankId) async{
    if(!await Utility.isInternetConnected()){
      return APIResponse<List<RecipientBankBranch>>(error: true, message: "Internet is not connected!");
    }
    Uri url = Uri.parse(baseAPIUrl()+'get-recipient-bank-branches/$bankId');
    return http.get(url,headers: headersWithAuth)
        .then((data){
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if(data.statusCode == 200){
        List<RecipientBankBranch> branches = [];
        jsonData.forEach((purpose){
          branches.add(RecipientBankBranch.fromJson(purpose));
        });
        return APIResponse<List<RecipientBankBranch>>(data: branches);
      }
      return APIResponse<List<RecipientBankBranch>>(error: true, message: jsonData["message"]??"An Error Occurred");
    }).catchError((onError){
      print(onError);
      return APIResponse<List<RecipientBankBranch>>(error: true, message: "An Error Occurred!");
    });
  }

}