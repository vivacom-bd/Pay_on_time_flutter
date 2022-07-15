import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
import 'package:hidmona/Models/user_profile.dart';
import 'package:hidmona/Repositories/common_repository.dart';
import 'package:hidmona/Repositories/api_response.dart';
import 'package:hidmona/Repositories/recipient_repository.dart';
import 'package:hidmona/Repositories/user_repository.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Home/home_screen.dart';
import 'package:hidmona/Views/Screens/Login/login_screen.dart';

class CommonController extends GetxController{

  Rx<Country> countryFrom = Country().obs; // CountryPickerUtils.getCountryByIsoCode("SE").obs;
  Rx<Country> countryTo = Country().obs; // CountryPickerUtils.getCountryByIsoCode("SE").obs;

  Rx<ServerCountry> serverCountryFrom = ServerCountry().obs;
  Rx<ServerCountry> serverCountryTo = ServerCountry().obs;

  Rx<AppUser> currentUser = AppUser().obs;
  Rx<UserProfile> userProfile = UserProfile().obs;

  RxList<ServerCountry> serverCountries = <ServerCountry>[].obs;
  RxList<ModeOfPayment> modeOfReceives = <ModeOfPayment>[].obs;
  RxList<ModeOfPayment> modeOfPayments = <ModeOfPayment>[].obs;
  RxList<Recipient> myRecipients = <Recipient>[].obs;
  RxList<City> receiveCities = <City>[].obs;
  // RxList<City> sendingCities = <City>[].obs;
  RxList<SendingPurpose> sendingPurposes = <SendingPurpose>[].obs;
  RxList<CountryWiseBank> countryWiseBanks = <CountryWiseBank>[].obs;


  Rx<CurrencyConversionDetails> currencyConversionDetails = CurrencyConversionDetails().obs;
  TransactionRequestBody? transactionRequestBody;
  Transaction? currentTransaction;


  ModeOfPayment? selectedModeOfReceive;
  ModeOfPayment? selectedModeOfPayment;
  SendingPurpose? selectedSendingPurpose;
  Recipient? selectedRecipient;
  // City? senderCity;
  CountryWiseBank? selectedCountryWiseBank;


  final getStorage = GetStorage();


  @override
  void onInit() {
    super.onInit();
    getStarted();
  }


  ///getCountries
  void getStarted(){
    CommonRepository.getCountries().then((APIResponse<List<ServerCountry>> apiResponse) async {
      if(apiResponse.data != null){
        serverCountries.addAll(apiResponse.data!);


        //savedLogin
        String? email = getStorage.read<String>("email");
        String? password = getStorage.read<String>("password");

        if(email != null && password != null){
          bool isSuccessful = await customerLogin(email,password);

          if(isSuccessful){
            Get.offAll(()=> const HomeScreen());
            return;
          }
        }

        Get.offAll(()=> const LoginScreen());

      }else{
        Utility.showSnackBar(apiResponse.message??"An error occurred");
      }
    });
  }


  Future<bool> customerLogin(String email, String password){

    return UserRepository.customerLogin(email,password).then((value)async{
      if(value.data != null){
        //get User Profile
        var userProfileResponse =  await UserRepository.getUserProfile();
        if(userProfileResponse.data != null){
          userProfile.value = userProfileResponse.data!;
          if(userProfile.value.country != null){
            List<ServerCountry> countries = serverCountries.where((country) => userProfile.value.country!.id == country.id).toList();
            if (countries.isNotEmpty) {
              //serverCountryFrom.value = userProfile.value.country!;
              countryFrom.value = CountryPickerUtils.getCountryByIsoCode(countries.first.countryCode!);
            }
          }
        }

        return true;

      }else{
        return false;
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
        Utility.showSnackBar("ModeOfReceives: ${apiResponse.message??"An error Occurred"}");
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
        Utility.showSnackBar("ModeOfPayments: ${apiResponse.message??"An error Occurred"}");
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
        Utility.showSnackBar(apiResponse.message??"An error Occurred");
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
      Utility.showSnackBar(apiResponse1.message??"An error Occurred");
      return false;
    }


    // APIResponse<List<City>> apiResponse2 = await CommonRepository.getCities(serverCountryFrom.value.id!);
    // if(apiResponse2.data != null){
    //   sendingCities.clear();
    //   sendingCities.addAll(apiResponse2.data!);
    // }else{
    //   Utility.showSnackBar(apiResponse2.message??"An error Occurred");
    //   return false;
    // }


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
        Utility.showSnackBar(apiResponse.message??"An error Occurred");
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
        Utility.showSnackBar(apiResponse.message??"An error Occurred");
        return false;
      }
    });

  }



  /// getConversionDetails
  Future<APIResponse<CurrencyConversionDetails>> getConversionDetails(double amount, ServerCurrency serverCurrencyFrom, ServerCurrency serverCurrencyTo) async{
    APIResponse<CurrencyConversionDetails> apiResponse = await CommonRepository.getConversionDetails(amount, serverCurrencyFrom.id!, serverCurrencyTo.id!, serverCountryFrom.value.id!, serverCountryTo.value.id!);

    return apiResponse;
  }


  ///UpdateCurrencies
  Future<bool> updateCurrencies() async{

    //Country From
    serverCountryFrom.value.selectedCurrency = null;
    APIResponse<ServerCurrency> apiResponseFrom1 = await CommonRepository.getCountryDefaultCurrency(serverCountryFrom.value.id!);
    if(apiResponseFrom1.data!=null){
      serverCountryFrom.value.selectedCurrency = apiResponseFrom1.data;
    }/*else{
      Utility.showSnackBar(apiResponseFrom1.message??"No default currency for ${serverCountryFrom.value.name}");
      return false;
    }*/

    APIResponse<List<ServerCurrency>> apiResponseFrom2 = await CommonRepository.getCurrenciesOnCountry(serverCountryFrom.value.id!);
    if(apiResponseFrom2.data!=null){
      serverCountryFrom.value.currencies = apiResponseFrom2.data;
      if((serverCountryFrom.value.currencies??[]).isEmpty){
        Utility.showSnackBar("No default currency for ${serverCountryFrom.value.name}");
        return false;
      }
      serverCountryFrom.value.selectedCurrency ??= serverCountryFrom.value.currencies?.first;
    }else{
      Utility.showSnackBar(apiResponseFrom2.message??"No Currency Found ${serverCountryFrom.value.name}");
      return false;
    }




    //Country To
    serverCountryTo.value.selectedCurrency = null;
    APIResponse<ServerCurrency> apiResponseTo1 = await CommonRepository.getCountryDefaultCurrency(serverCountryTo.value.id!);
    if(apiResponseTo1.data!=null){
      serverCountryTo.value.selectedCurrency = apiResponseTo1.data;
    }/*else{
      Utility.showSnackBar(apiResponseTo1.message??"No Currency Found ${serverCountryTo.value.name}");
      return false;
    }*/

    APIResponse<List<ServerCurrency>> apiResponseTo2 = await CommonRepository.getCurrenciesOnCountry(serverCountryTo.value.id!);
    if(apiResponseTo2.data!=null){
      serverCountryTo.value.currencies = apiResponseTo2.data;
      if((serverCountryTo.value.currencies??[]).isEmpty){
        Utility.showSnackBar("No default currency for ${serverCountryTo.value.name}");
        return false;
      }
      serverCountryTo.value.selectedCurrency ??= serverCountryTo.value.currencies?.first;
    }else{
      Utility.showSnackBar(apiResponseTo2.message??"No default currency for ${serverCountryTo.value.name}");
      return false;
    }

    return true;
  }


  ServerCountry getServerCountryFromCountryCode(String countryCode){
    return serverCountries.where((element) => element.countryCode == countryCode).first;
  }

}