import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:get/get.dart';
import 'package:hidmona/Models/app_user.dart';
import 'package:hidmona/Models/city.dart';
import 'package:hidmona/Models/country_wise_bank.dart';
import 'package:hidmona/Models/currency_conversion_details.dart';
import 'package:hidmona/Models/mode_of_payment.dart';
import 'package:hidmona/Models/recipient.dart';
import 'package:hidmona/Models/sending_purpose.dart';
import 'package:hidmona/Models/server_country.dart';
import 'package:hidmona/Models/server_currency.dart';
import 'package:hidmona/Models/transaction.dart';
import 'package:hidmona/Repositories/common_repository.dart';
import 'package:hidmona/Repositories/api_response.dart';
import 'package:hidmona/Repositories/recipient_repository.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Login/login_screen.dart';

class CommonController extends GetxController{

  Rx<Country> countryFrom = CountryPickerUtils.getCountryByIsoCode("SE").obs;
  Rx<Country> countryTo = CountryPickerUtils.getCountryByIsoCode("SE").obs;

  Rx<ServerCountry> serverCountryFrom = ServerCountry().obs;
  Rx<ServerCountry> serverCountryTo = ServerCountry().obs;

  Rx<AppUser> currentUser = AppUser().obs;

  RxList<ServerCountry> serverCountries = <ServerCountry>[].obs;
  RxList<ModeOfPayment> modeOfReceives = <ModeOfPayment>[].obs;
  RxList<ModeOfPayment> modeOfPayments = <ModeOfPayment>[].obs;
  RxList<Recipient> myRecipients = <Recipient>[].obs;
  RxList<City> receiveCities = <City>[].obs;
  RxList<City> sendingCities = <City>[].obs;
  RxList<SendingPurpose> sendingPurposes = <SendingPurpose>[].obs;
  RxList<CountryWiseBank> countryWiseBanks = <CountryWiseBank>[].obs;


  Rx<CurrencyConversionDetails> currencyConversionDetails = CurrencyConversionDetails().obs;
  TransactionRequestBody? transactionRequestBody;
  Transaction? currentTransaction;


  ModeOfPayment? selectedModeOfReceive;
  ModeOfPayment? selectedModeOfPayment;
  SendingPurpose? selectedSendingPurpose;
  Recipient? selectedRecipient;
  City? senderCity;
  CountryWiseBank? selectedCountryWiseBank;


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

        Get.to(()=> const LoginScreen());

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

  ///getModeOfPayments
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


  ///getMyRecipients
  Future<bool> getMyRecipients() async{

    return RecipientRepository.getRecipients().then((APIResponse<List<Recipient>> apiResponse){
      if(apiResponse.data != null){
        myRecipients.clear();
        myRecipients.addAll(apiResponse.data!);
        return true;
      }else{
        Utility.showSnackBar(apiResponse.errorMessage??"An error Occurred");
        return false;
      }
    });

  }


  ///getModeOfReceives
  Future<bool> getCities() async{

    APIResponse<List<City>> apiResponse1 = await CommonRepository.getCities(serverCountryTo.value.id!);
    if(apiResponse1.data != null){
      receiveCities.clear();
      receiveCities.addAll(apiResponse1.data!);
    }else{
      Utility.showSnackBar(apiResponse1.errorMessage??"An error Occurred");
      return false;
    }


    APIResponse<List<City>> apiResponse2 = await CommonRepository.getCities(serverCountryFrom.value.id!);
    if(apiResponse2.data != null){
      sendingCities.clear();
      sendingCities.addAll(apiResponse2.data!);
    }else{
      Utility.showSnackBar(apiResponse2.errorMessage??"An error Occurred");
      return false;
    }


    return true;

  }



  ///getSendingPurposes
  Future<bool> getSendinPurposes() async{

    return CommonRepository.getSendingPurposes().then((APIResponse<List<SendingPurpose>> apiResponse){
      if(apiResponse.data != null){
        sendingPurposes.clear();
        sendingPurposes.addAll(apiResponse.data!);
        return true;
      }else{
        Utility.showSnackBar(apiResponse.errorMessage??"An error Occurred");
        return false;
      }
    });

  }


  ///getCountryWiseBanks
  Future<bool> getCountryWiseBanks() async{

    ServerCountry serverCountry = getServerCountryFromCountryCode(countryFrom.value.isoCode!);
    return CommonRepository.getCountryWiseBanks(serverCountry.id.toString()).then((APIResponse<List<CountryWiseBank>> apiResponse){
      if(apiResponse.data != null){
        countryWiseBanks.clear();
        countryWiseBanks.addAll(apiResponse.data!);
        return true;
      }else{
        Utility.showSnackBar(apiResponse.errorMessage??"An error Occurred");
        return false;
      }
    });

  }



  /// getConversionDetails
  Future<APIResponse<CurrencyConversionDetails>> getConversionDetails(double amount, ServerCurrency serverCurrencyFrom, ServerCurrency serverCurrencyTo) async{
    APIResponse<CurrencyConversionDetails> apiResponse = await CommonRepository.getConversionDetails(amount, serverCurrencyFrom.id!, serverCurrencyTo.id!);

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