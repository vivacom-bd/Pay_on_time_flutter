import 'dart:io';

import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hidmona/Models/Card%20Remittance%20System/card_details_screen.dart';
import 'package:hidmona/Models/Card%20Remittance%20System/create_card_holder.dart';
import 'package:hidmona/Models/Card%20Remittance%20System/create_personal_account.dart';
import 'package:hidmona/Models/Card%20Remittance%20System/get_personal_account.dart';
import 'package:hidmona/Models/Card%20Remittance%20System/get_title.dart';
import 'package:hidmona/Models/Card%20Remittance%20System/personal_account_card.dart';
import 'package:hidmona/Models/app_settings.dart';
import 'package:hidmona/Models/app_user.dart';
import 'package:hidmona/Models/city.dart';
import 'package:hidmona/Models/country_wise_bank.dart';
import 'package:hidmona/Models/currency_conversion_details.dart';
import 'package:hidmona/Models/mode_of_payment.dart';
import 'package:hidmona/Models/recipient.dart';
import 'package:hidmona/Models/recipient_bank.dart';
import 'package:hidmona/Models/sending_purpose.dart';
import 'package:hidmona/Models/server_country.dart';
import 'package:hidmona/Models/server_currency.dart';
import 'package:hidmona/Models/transaction.dart';
import 'package:hidmona/Models/user_profile.dart';
import 'package:hidmona/Repositories/card_remittance_repository.dart';
import 'package:hidmona/Repositories/common_repository.dart';
import 'package:hidmona/Repositories/api_response.dart';
import 'package:hidmona/Repositories/firebase_repository.dart';
import 'package:hidmona/Repositories/recipient_repository.dart';
import 'package:hidmona/Repositories/user_repository.dart';
import 'package:hidmona/Utilities/update_dialog.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Home/home_screen.dart';
import 'package:hidmona/Views/Screens/Login/login_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';

class CommonController extends GetxController{

  Rx<Country> countryFrom = Country().obs; // CountryPickerUtils.getCountryByIsoCode("SE").obs;
  Rx<Country> countryTo = Country().obs; // CountryPickerUtils.getCountryByIsoCode("SE").obs;
  Rx<Country> shippingCountry = Country().obs;

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
  List<RecipientBank> recipientBanks = [];
  City? recipientCity;
  CountryWiseBank? selectedCountryWiseBank;

  /// Card Remittance.
  Rx<PersonalAccount> currentPersonalAccount = PersonalAccount().obs; //Create Personal Account
  Rx<GetPersonalAccount> getAccountDetails = GetPersonalAccount().obs; // Retrieve Personal Account
  Rx<GetTitle> getTitleDetails = GetTitle().obs;
  Rx<CreateCardHolder> createCardHolder = CreateCardHolder().obs; //Create Card Holder
  Rx<CardDetails> getCardDetails = CardDetails().obs;
  Rx<PersonalAccountCard> personalAccountCard = PersonalAccountCard().obs;

  int testID = 153;


  List<String> euroCountry = ['SE','ER','AT','BE', 'BG', 'HR', 'CY', 'CZ', 'DK', 'EE', 'FI', 'FR', 'DE', 'GR', 'HU', 'IE', 'IT', 'LV', 'LT', 'LU', 'MT', 'NL', 'PL', 'PT', 'RO', 'SK','SI', 'ES', 'SE', 'GB'];
  Country? selectedCountry;
  Country? selectedCitizenCountry;

  int? selectedTitleId;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController othersFirstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController othersMiddleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController othersLastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController othersDobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController othersEmailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController othersPhoneNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController othersCityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController othersStateController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController othersPostalCodeController = TextEditingController();
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController othersAddressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController othersAddressLine2Controller = TextEditingController();


  final getStorage = GetStorage();


  @override
  void onInit() {
    super.onInit();
    getStarted();
  }


  ///getCountries
  void getStarted(){

    //version control
    FirebaseRepository.getVersionControl().listen((apiResponse) async {
      if(apiResponse.data != null){

        PackageInfo packageInfo = await PackageInfo.fromPlatform();

        AppVersion remoteVersion = Platform.isAndroid? apiResponse.data!.android! : apiResponse.data!.iOS!;

        //String appName = packageInfo.appName;
        //String packageName = packageInfo.packageName;
        String version = packageInfo.version;
        //String buildNumber = packageInfo.buildNumber;
        print(apiResponse.data!.android!.version);
        List<int> appVersions = version.split('.').map((value) => int.parse(value)).toList();
        List<int> controlVersions = remoteVersion.version!.split(".").map((value) => int.parse(value)).toList();

        //if (version.compareTo(apiResponse.data.android.version) >= 0) {
        if (controlVersions[0]>appVersions[0] || (controlVersions[0]==appVersions[0] && controlVersions[1]>appVersions[1]) || (controlVersions[0]==appVersions[0] && controlVersions[1]==appVersions[1] && controlVersions[2]>appVersions[2])) {
          UpdateDialog().showDialog(url: Platform.isAndroid?'https://play.google.com/store/apps/details?id=com.mahmud.hidmona':'https://apps.apple.com/ro/app/hidmona-money-transfer/id1629064572');
        }else{
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

    return RecipientRepository.getRecipients(query:"&country=${serverCountryTo.value.id}").then((APIResponse<List<Recipient>> apiResponse){
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

    APIResponse<List<ServerCurrency>> apiResponseFrom2 = await CommonRepository.getCurrenciesOnCountry(serverCountryFrom.value.id!);
    if(apiResponseFrom2.data!=null){
      serverCountryFrom.value.currencies = apiResponseFrom2.data;
      if((serverCountryFrom.value.currencies??[]).isEmpty){
        Utility.showSnackBar("No default currency for ${serverCountryFrom.value.name}");
        return false;
      }
      try{
        serverCountryFrom.value.selectedCurrency = (serverCountryFrom.value.currencies??<ServerCurrency>[]).firstWhere((currency) => currency.defaultCurrency??false);
      }catch(e){
        serverCountryFrom.value.selectedCurrency = serverCountryFrom.value.currencies!.first;
      }
    }else{
      Utility.showSnackBar(apiResponseFrom2.message??"No Currency Found ${serverCountryFrom.value.name}");
      return false;
    }

    //Country To
    serverCountryTo.value.selectedCurrency = null;

    APIResponse<List<ServerCurrency>> apiResponseTo2 = await CommonRepository.getCurrenciesOnCountry(serverCountryTo.value.id!);
    if(apiResponseTo2.data!=null){
      serverCountryTo.value.currencies = apiResponseTo2.data;
      if((serverCountryTo.value.currencies??[]).isEmpty){
        Utility.showSnackBar("No currency found for ${serverCountryTo.value.name}");
        return false;
      }
      try{
        serverCountryTo.value.selectedCurrency = (serverCountryTo.value.currencies??<ServerCurrency>[]).firstWhere((currency) =>currency.defaultCurrency??false);
      }catch(e){
        serverCountryTo.value.selectedCurrency = serverCountryTo.value.currencies!.first;
      }
    }else{
      Utility.showSnackBar(apiResponseTo2.message??"No currency found for ${serverCountryTo.value.name}");
      return false;
    }

    return true;
  }



  ///PersonalAccountCreate
  Future<bool> createAccount(int userId, String familyName, String givenName, String countryCode, String dob, String phoneNumber, String email) async{
    APIResponse<PersonalAccount> apiResponseFromAcc = await CardRemittanceRepository.createPersonalAccount(
      userId, familyName,givenName,countryCode,dob,phoneNumber,email);
    if(apiResponseFromAcc.data!=null){
      currentPersonalAccount.value = apiResponseFromAcc.data!;
    }else{
      Utility.showSnackBar(apiResponseFromAcc.message??"No data Found");
      return false;
    }
    return true;
  }

  ///GetPersonalAccount
  Future<bool> getPersonalAccount(int start, int limit, int id) async{
    APIResponse<GetPersonalAccount> apiResponseFromGetAcc = await CardRemittanceRepository.getPersonalAccount(start,limit,id);
    if(apiResponseFromGetAcc.data!=null){
      getAccountDetails.value = apiResponseFromGetAcc.data!;
    }else{
      Utility.showSnackBar(apiResponseFromGetAcc.message??"No data Found");
      return false;
    }
    return true;
  }

  ///getTitle
  Future<bool> getTitle() async{
    APIResponse<GetTitle> apiResponseGetTitle = await CardRemittanceRepository.getTitle(0, 23);
    if(apiResponseGetTitle.data!=null){
      getTitleDetails.value = apiResponseGetTitle.data!;
    }else{
      Utility.showSnackBar(apiResponseGetTitle.message??"No data Found");
      return false;
    }
    return true;
  }

  ///PersonalAccountCreate
  Future<bool> cardHolder(
      int userId, int accountPK, int titlePK, String suffixName, String fName, String mName, String lName, String embossedName,
      String dob, String email, String userName, String clientRef, String countryCode, String phoneNumber, String aCountryAlpha3,
      String aCity, String aState, String aPostal, String aLine1, String aLine2, String sCountryAlpha3, String sCity, String sState,
      String sPostal, String sLine1,String sLine2, bool isPrimary,) async{
    APIResponse<CreateCardHolder> apiResponseCardHolder = await CardRemittanceRepository.createCardHolder(
       userId, accountPK, titlePK, suffixName, fName, mName, lName, embossedName, dob, email, userName, clientRef,
       countryCode, phoneNumber, aCountryAlpha3, aCity, aState, aPostal, aLine1, aLine2, sCountryAlpha3, sCity, sState, sPostal, sLine1, sLine2, isPrimary,
    );
    if(apiResponseCardHolder.data!=null){
      createCardHolder.value = apiResponseCardHolder.data!;
    }else{
      Utility.showSnackBar(apiResponseCardHolder.message??"No data Found");
      return false;
    }
    return true;
  }

  ///getTitle
  Future<bool> getCardDetail(int senderId, int cardHolderId) async{
    APIResponse<CardDetails> apiResponseGetCardDetails = await CardRemittanceRepository.cardDetails(senderId, cardHolderId);
    if(apiResponseGetCardDetails.data!=null){
      getCardDetails.value = apiResponseGetCardDetails.data!;
    }else{
      Utility.showSnackBar(apiResponseGetCardDetails.message??"No data Found");
      return false;
    }
    return true;
  }

  ///getPersonalAccountCard
  Future<bool> getPersonalAccountCard(int start, int limit, int userId) async{
    APIResponse<PersonalAccountCard> apiResponseGetCard = await CardRemittanceRepository.getPersonalCard(start, limit, userId);
    if(apiResponseGetCard.data!=null){
      personalAccountCard.value = apiResponseGetCard.data!;
    }else{
      Utility.showSnackBar(apiResponseGetCard.message??"No data Found");
      return false;
    }
    return true;
  }


  ///Currency for fromCountryCurrency Only
  Future<bool> fromCountryCurrencies() async{
    //Country From
    serverCountryFrom.value.selectedCurrency = null;

    APIResponse<List<ServerCurrency>> apiResponseFrom2 = await CommonRepository.getCurrenciesOnCountry(serverCountryFrom.value.id!);
    if(apiResponseFrom2.data!=null){
      serverCountryFrom.value.currencies = apiResponseFrom2.data;
      if((serverCountryFrom.value.currencies??[]).isEmpty){
        Utility.showSnackBar("No default currency for ${serverCountryFrom.value.name}");
        return false;
      }
      try{
        serverCountryFrom.value.selectedCurrency = (serverCountryFrom.value.currencies??<ServerCurrency>[]).firstWhere((currency) => currency.defaultCurrency??false);
      }catch(e){
        serverCountryFrom.value.selectedCurrency = serverCountryFrom.value.currencies!.first;
      }
    }else{
      Utility.showSnackBar(apiResponseFrom2.message??"No Currency Found ${serverCountryFrom.value.name}");
      return false;
    }
    return true;
  }

  ServerCountry getServerCountryFromCountryCode(String countryCode){
    return serverCountries.where((element) => element.countryCode == countryCode).first;
  }

}