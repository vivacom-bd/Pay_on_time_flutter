import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:get/get.dart';
import 'package:hidmona/Models/app_user.dart';
import 'package:hidmona/Models/currency_conversion_details.dart';
import 'package:hidmona/Models/mode_of_payment.dart';
import 'package:hidmona/Models/server_country.dart';
import 'package:hidmona/Models/server_currency.dart';
import 'package:hidmona/Repositories/common_repository.dart';
import 'package:hidmona/Repositories/api_response.dart';
import 'package:hidmona/Utilities/utility.dart';

class CommonController extends GetxController{

  Rx<Country> countryFrom = CountryPickerUtils.getCountryByIsoCode("SE").obs;
  Rx<Country> countryTo = CountryPickerUtils.getCountryByIsoCode("SE").obs;

  Rx<ServerCountry> serverCountryFrom = ServerCountry().obs;
  Rx<ServerCountry> serverCountryTo = ServerCountry().obs;

  Rx<AppUser> currentUser = AppUser().obs;

  RxList<ServerCountry> serverCountries = <ServerCountry>[].obs;
  RxList<ModeOfPayment> modeOfReceives = <ModeOfPayment>[].obs;
  RxList<ModeOfPayment> modeOfPayments = <ModeOfPayment>[].obs;

  Rx<CurrencyConversionDetails> currencyConversionDetails = CurrencyConversionDetails().obs;


  ModeOfPayment? selectedModeOfReceive;
  ModeOfPayment? selectedModeOfPayment;


  @override
  void onInit() {
    super.onInit();
    getCountries();
  }


  ///getCountries
  void getCountries(){
    CommonRepository.getCountries().then((APIResponse<List<ServerCountry>> apiResponse){
      if(apiResponse.data != null){
        serverCountries.addAll(apiResponse.data!);
      }else{
        Utility.showSnackBar(apiResponse.errorMessage??"An error occurred");
      }
    });
  }
  
  
  ///getModeOfReceives
  Future<bool> getModeOfReceives(String countryCode) async{
    
    ServerCountry serverCountry = getServerCountryFromCountryCode(countryCode);
    
    return CommonRepository.getModeOfReceive(serverCountry.id!).then((APIResponse<List<ModeOfPayment>> apiResponse){
      if(apiResponse.data != null){
        modeOfReceives.clear();
        modeOfReceives.addAll(apiResponse.data!);
        return true;
      }else{
        Utility.showSnackBar(apiResponse.errorMessage??"An error Occurred");
        return false;
      }
    });
  }

  ///getModeOfReceives
  Future<bool> getModeOfPayments(String countryCode) async{

    ServerCountry serverCountry = getServerCountryFromCountryCode(countryCode);

    return CommonRepository.getModeOfPayment(serverCountry.id!).then((APIResponse<List<ModeOfPayment>> apiResponse){
      if(apiResponse.data != null){
        modeOfPayments.clear();
        modeOfPayments.addAll(apiResponse.data!);
        return true;
      }else{
        Utility.showSnackBar(apiResponse.errorMessage??"An error Occurred");
        return false;
      }
    });
  }


  /// getConversionDetails
  Future<APIResponse<CurrencyConversionDetails>> getConversionDetails(double amount, String countryFromCode, String countryToCode) async{
    ServerCountry serverCountryFrom = getServerCountryFromCountryCode(countryFromCode);
    ServerCountry serverCountryTo = getServerCountryFromCountryCode(countryToCode);

    APIResponse<CurrencyConversionDetails> apiResponse = await CommonRepository.getConversionDetails(amount, serverCountryFrom.id!, serverCountryTo.id!);

    return apiResponse;
  }


  ///UpdateCurrencies
  Future<bool> updateCurrencies() async{

    APIResponse<ServerCurrency> apiResponse1 = await CommonRepository.getCountryDefaultCurrency(serverCountryFrom.value.id!);

    if(apiResponse1.data!=null){
      serverCountryFrom.value.selectedCurrency = apiResponse1.data;
    }else{
      Utility.showSnackBar(apiResponse1.errorMessage??"No default currency for ${serverCountryFrom.value.name}");
      return false;
    }

    APIResponse<ServerCurrency> apiResponse2 = await CommonRepository.getCountryDefaultCurrency(serverCountryTo.value.id!);

    if(apiResponse2.data!=null){
      serverCountryTo.value.selectedCurrency = apiResponse2.data;
    }else{
      Utility.showSnackBar(apiResponse2.errorMessage??"No default currency for ${serverCountryTo.value.name}");
      return false;
    }

    return true;
  }


  ServerCountry getServerCountryFromCountryCode(String countryCode){
    return serverCountries.where((element) => element.countryCode == countryCode).first;
  }

}