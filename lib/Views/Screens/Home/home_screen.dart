import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Repositories/api_constants.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/default_dialogs.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Cards/Accounts/account_screen.dart';
import 'package:hidmona/Views/Screens/Cards/Accounts/create_account_option_screen.dart';
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/existing_holder_list.dart';
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/Crard%20creation/card_list_screen.dart';
import 'package:hidmona/Views/Screens/Profile/profile_screen.dart';
import 'package:hidmona/Views/Screens/Recipient/my_recipients_screen.dart';
import 'package:hidmona/Views/Screens/SendMoney/send_money_screen.dart';
import 'package:hidmona/Views/Screens/Transaction/transaction_history_screen.dart';
import 'package:hidmona/Views/Widgets/country_item.dart';
import 'package:hidmona/Views/Widgets/dashboard_item.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/HomeScreen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  CommonController controller = Get.find<CommonController>();
  
  @override
  initState(){
    super.initState();
    
    // if(controller.currentUser.value.kycUserToken !=null && controller.currentUser.value.kycUserToken!.isNotEmpty && controller.currentUser.value.kycApplicationId !=null && controller.currentUser.value.kycApplicationId!.isNotEmpty){
    //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //     //Utility.showSnackBar("Your KYC application is not approved yet",durationInSeconds: 3);
    //
    //     DefaultDialogs.showDialog(
    //       title: "Apply for KYC",
    //       text: "Your KYC application is not approved yet. Please apply for KYC.",
    //       onCancel: (){
    //         Get.back();
    //       },
    //       onSubmitText: "Continue",
    //       onSubmit: ()async{
    //
    //         Get.back();
    //
    //         String url = '${kycBaseUrl()}applications/${controller.currentUser.value.kycApplicationId}?access_token=${controller.currentUser.value.kycUserToken}';
    //         Uri uri = Uri.parse(url);
    //         if (await canLaunchUrl(uri)) {
    //           await launchUrl(uri,mode: LaunchMode.externalApplication);
    //         }
    //       }
    //     );
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    CommonController commonController = Get.find<CommonController>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 15,),
                Center(child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(AppImage.getPath("logo"),width: SizeConfig.screenWidth*.4,),
                ),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    DashboardExploreItem(title: "Profile",subtitle: "See your profile here",iconName: "user",
                      onTap: (){
                       Get.to(const ProfileScreen());
                      },
                    ),
                    DashboardExploreItem(title: "Account",subtitle: "See your Account here",iconName: "users",
                      onTap: () async {
                        Utility.showLoadingDialog();
                        bool value = await commonController.getPersonalAccount(0,25,commonController.userProfile.value.id!);//commonController.userProfile.value.id!
                        Get.back();
                        if(value){
                          if(commonController.getAccountDetails.value.data!.isNotEmpty){
                            Get.to(()=> const AccountScreen());
                          } else{
                            Get.to(()=> const CreateAccountOptionScreen());
                          }
                        }
                        // if(controller.currentUser.value.kycUserToken !=null && controller.currentUser.value.kycUserToken!.isNotEmpty && controller.currentUser.value.kycApplicationId !=null && controller.currentUser.value.kycApplicationId!.isNotEmpty){
                        //   DefaultDialogs.showDialog(
                        //       title: "Apply for KYC",
                        //       text: "Your KYC application is not approved yet. Please apply for KYC.",
                        //       onCancel: (){
                        //         Get.back();
                        //       },
                        //       onSubmitText: "Continue",
                        //       onSubmit: ()async{
                        //
                        //         Get.back();
                        //
                        //         String url = '${kycBaseUrl()}applications/${controller.currentUser.value.kycApplicationId}?access_token=${controller.currentUser.value.kycUserToken}';
                        //         Uri uri = Uri.parse(url);
                        //         if (await canLaunchUrl(uri)) {
                        //           await launchUrl(uri,mode: LaunchMode.externalApplication);
                        //         }
                        //       }
                        //   );
                        // } else {
                        //   Utility.showLoadingDialog();
                        //   bool value = await commonController.getPersonalAccount(0,25,commonController.userProfile.value.id!);//commonController.userProfile.value.id!
                        //   Get.back();
                        //   if(value){
                        //     if(commonController.getAccountDetails.value.data!.isNotEmpty){
                        //       Get.to(()=> const AccountScreen());
                        //     } else{
                        //       Get.to(()=> const CreateAccountOptionScreen());
                        //     }
                        //   }
                        // }
                      },
                    ),
                    DashboardExploreItem(title: "Card",subtitle: "See your Card here",iconName: "card", onTap: () {  },
                      // onTap: () async {
                      //   if(controller.currentUser.value.kycUserToken !=null && controller.currentUser.value.kycUserToken!.isNotEmpty && controller.currentUser.value.kycApplicationId !=null && controller.currentUser.value.kycApplicationId!.isNotEmpty){
                      //     DefaultDialogs.showDialog(
                      //         title: "Apply for KYC",
                      //         text: "Your KYC application is not approved yet. Please apply for KYC.",
                      //         onCancel: (){
                      //           Get.back();
                      //         },
                      //         onSubmitText: "Continue",
                      //         onSubmit: ()async{
                      //           Get.back();
                      //           String url = '${kycBaseUrl()}applications/${controller.currentUser.value.kycApplicationId}?access_token=${controller.currentUser.value.kycUserToken}';
                      //           Uri uri = Uri.parse(url);
                      //           if (await canLaunchUrl(uri)) {
                      //             await launchUrl(uri,mode: LaunchMode.externalApplication);
                      //           }
                      //         }
                      //     );
                      //   } else {
                      //     Utility.showLoadingDialog();
                      //     bool value = await commonController.getPersonalAccountCard(0,25,commonController.userProfile.value.id!);
                      //     if(value){
                      //       if(commonController.personalAccountCard.value.data!.isNotEmpty){
                      //         bool value = await commonController.getCardStatus(commonController.userProfile.value.id!, commonController.personalAccountCard.value.data![0].id!);
                      //         Get.back();
                      //         if(value){
                      //           Get.to(()=> const ExistingCardHolderList());
                      //         } else {
                      //           Utility.showSnackBar("can not call");
                      //         }
                      //
                      //       } else {
                      //         Get.to(const CardListScreen());
                      //       }
                      //     }
                      //   }
                      // },
                    ),
                    const SizedBox(height: 10,),
                    DashboardExploreItem(title: "Transaction History",subtitle: "See your previous transactions",iconName: "history",
                      onTap: (){
                        Get.to(const TransactionHistoryScreen());
                        // if(controller.currentUser.value.kycUserToken !=null && controller.currentUser.value.kycUserToken!.isNotEmpty && controller.currentUser.value.kycApplicationId !=null && controller.currentUser.value.kycApplicationId!.isNotEmpty){
                        //   DefaultDialogs.showDialog(
                        //       title: "Apply for KYC",
                        //       text: "Your KYC application is not approved yet. Please apply for KYC.",
                        //       onCancel: (){
                        //         Get.back();
                        //       },
                        //       onSubmitText: "Continue",
                        //       onSubmit: ()async{
                        //
                        //         Get.back();
                        //
                        //         String url = '${kycBaseUrl()}applications/${controller.currentUser.value.kycApplicationId}?access_token=${controller.currentUser.value.kycUserToken}';
                        //         Uri uri = Uri.parse(url);
                        //         if (await canLaunchUrl(uri)) {
                        //           await launchUrl(uri,mode: LaunchMode.externalApplication);
                        //         }
                        //       }
                        //   );
                        // } else {
                        //   Get.to(const TransactionHistoryScreen());
                        // }
                      },
                    ),
                    const SizedBox(height: 10,),
                    DashboardExploreItem(title: "My Recipients",subtitle: "See your profile here",iconName: "users",
                      onTap: (){
                        Get.to(const MyRecipientScreen());
                        // if(controller.currentUser.value.kycUserToken !=null && controller.currentUser.value.kycUserToken!.isNotEmpty && controller.currentUser.value.kycApplicationId !=null && controller.currentUser.value.kycApplicationId!.isNotEmpty){
                        //   DefaultDialogs.showDialog(
                        //       title: "Apply for KYC",
                        //       text: "Your KYC application is not approved yet. Please apply for KYC.",
                        //       onCancel: (){
                        //         Get.back();
                        //       },
                        //       onSubmitText: "Continue",
                        //       onSubmit: ()async{
                        //
                        //         Get.back();
                        //
                        //         String url = '${kycBaseUrl()}applications/${controller.currentUser.value.kycApplicationId}?access_token=${controller.currentUser.value.kycUserToken}';
                        //         Uri uri = Uri.parse(url);
                        //         if (await canLaunchUrl(uri)) {
                        //           await launchUrl(uri,mode: LaunchMode.externalApplication);
                        //         }
                        //       }
                        //   );
                        // } else {
                        //   Get.to(const MyRecipientScreen());
                        // }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                Center(
                  child: Text(
                    'Send Money',
                    style: TextStyle(
                      color: AppColor.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  decoration: BoxDecoration(
                    color: AppColor.dropdownBoxColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Obx((){
                    if(controller.serverCountries.isEmpty){
                      return SpinKitCircle(color: Get.theme.primaryColor,);
                    }else{
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'I\'m sending From',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColor.textColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 7,),
                          InkWell(
                            onTap: (){
                              //_openFromCountryPickerDialog();
                            },
                            child: Container(
                              height: 45,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.2),
                                borderRadius  : BorderRadius.circular(10),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: Container(padding: const EdgeInsets.only(left: 10),child: CountryItem(country: controller.countryFrom.value)),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 20) ,
                                      decoration: BoxDecoration(
                                        //color: AppColor.defaultColorLight,
                                        gradient: AppGradient.getColorGradient('grey')
                                      ),
                                      child: const Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,size: 30,)
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 15,),
                          Text(
                            'I\'m sending To',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColor.textColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 7,),
                          InkWell(
                            onTap: (){
                              _openCountryPickerDialog();
                            },
                            child: Container(
                              height: 45,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.2),
                                borderRadius  : BorderRadius.circular(10),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: Container(padding: const EdgeInsets.only(left: 10),child: CountryItem(country: controller.countryTo.value)),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 20) ,
                                      decoration: BoxDecoration(
                                        //color: AppColor.defaultColorLight,
                                        gradient: AppGradient.getColorGradient('default')
                                      ),
                                      child: const Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,size: 30,)
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          // (controller.currentUser.value.kycUserToken !=null && controller.currentUser.value.kycUserToken!.isNotEmpty && controller.currentUser.value.kycApplicationId !=null && controller.currentUser.value.kycApplicationId!.isNotEmpty) ?
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.stretch,
                          //   mainAxisSize: MainAxisSize.min,
                          //   children: [
                          //     //Divider(thickness: 1,color: AppColor.defaultColor.withOpacity(.5),height: 25,),
                          //     DefaultButton(buttonText: "Apply for KYC",onTap: ()async{
                          //       String url = '${kycBaseUrl()}applications/${controller.currentUser.value.kycApplicationId}?access_token=${controller.currentUser.value.kycUserToken}';
                          //       Uri uri = Uri.parse(url);
                          //       if (await canLaunchUrl(uri)) {
                          //         await launchUrl(uri,mode: LaunchMode.externalApplication);
                          //       }
                          //     },),
                          //     //Divider(thickness: 1,color: AppColor.defaultColor.withOpacity(.5),height: 25,),
                          //   ],
                          // ):
                          DefaultButton(
                            buttonText: "Continue", onTap: ()async{
                            if(controller.countryFrom.value.isoCode != null && controller.countryTo.value.isoCode != null){
                              Utility.showLoadingDialog();

                              bool isSuccessModeOfReceives = await controller.getModeOfReceives(controller.countryTo.value.isoCode!);
                              // if(!isSuccessModeOfReceives){
                              //   Get.back();
                              //   return;
                              // }

                              bool isSuccessModeOfPayments = await controller.getModeOfPayments(controller.countryFrom.value.isoCode!);
                              // if(!isSuccessModeOfPayments){
                              //   Get.back();
                              //   return;
                              // }

                              controller.serverCountryFrom.value = controller.getServerCountryFromCountryCode(controller.countryFrom.value.isoCode!);
                              controller.serverCountryTo.value = controller.getServerCountryFromCountryCode(controller.countryTo.value.isoCode!);

                              bool value = await controller.updateCurrencies();

                              Get.back();

                              if(value){
                                Get.to(()=> SendMoneyScreen());
                              }
                            }else{
                              Utility.showSnackBar("Select Country!");
                            }
                          },
                          ),
                        ],
                      );
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

///for countryfrom
  void _openFromCountryPickerDialog() => showDialog(
    context: context,
    builder: (context) => Theme(
      data: Theme.of(context).copyWith(primaryColor: AppColor.defaultColor),
      child: CountryPickerDialog(
        titlePadding: const EdgeInsets.all(8.0),
        searchCursorColor: AppColor.defaultColor,
        searchInputDecoration: const InputDecoration(hintText: 'Search By Country...'),
        isSearchable: true,
        title: const Text('Select country',textAlign: TextAlign.center,),
        onValuePicked: (Country country){
          controller.countryFrom.value = country;
        },
        itemBuilder: (Country country)=>CountryItem(country: country),
        itemFilter: (c) => controller.serverCountries.map((element) => element.countryCode).contains(c.isoCode),
        //itemFilter: (c) => ['AGO', 'AUS', 'AUT', 'BHR', 'BEL'].contains(c.iso3Code),
        //itemFilter: (c)=>commonSingleTon.getCountries().map((e) => e.countryCode).contains(c.iso3Code),
        // priorityList: [
        //   CountryPickerUtils.getCountryByIsoCode('TR'),
        //   CountryPickerUtils.getCountryByIsoCode('US'),
        // ],
      ),
    ),
  );

///for countryTo
  void _openCountryPickerDialog() => showDialog(
    context: context,
    builder: (context) => Theme(
      data: Theme.of(context).copyWith(primaryColor: AppColor.defaultColor),
      child: CountryPickerDialog(
        titlePadding: const EdgeInsets.all(8.0),
        searchCursorColor: AppColor.defaultColor,
        searchInputDecoration: const InputDecoration(hintText: 'Search By Country...'),
        isSearchable: true,
        title: const Text('Select country',textAlign: TextAlign.center,),
        onValuePicked: (Country country){
            controller.countryTo.value = country;
        },
        itemBuilder: (Country country)=>CountryItem(country: country),
        itemFilter: (c) => controller.serverCountries.map((element) => element.countryCode).contains(c.isoCode),
        //itemFilter: (c) => ['AGO', 'AUS', 'AUT', 'BHR', 'BEL'].contains(c.iso3Code),
        //itemFilter: (c)=>commonSingleTon.getCountries().map((e) => e.countryCode).contains(c.iso3Code),
        // priorityList: [
        //   CountryPickerUtils.getCountryByIsoCode('TR'),
        //   CountryPickerUtils.getCountryByIsoCode('US'),
        // ],
      ),
    ),
  );
}
































// import 'package:country_currency_pickers/country.dart';
// import 'package:country_currency_pickers/country_picker_dialog.dart';
// import 'package:country_currency_pickers/currency_picker_dropdown.dart';
// import 'package:country_currency_pickers/utils/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:hidmona/Controllers/common_controller.dart';
// import 'package:hidmona/Utilities/colors.dart';
// import 'package:hidmona/Utilities/images.dart';
// import 'package:hidmona/Views/Screens/send_money_screen.dart';
// import 'package:hidmona/Views/Widgets/country_item.dart';
// import 'package:hidmona/Views/Widgets/country_item_for_recipient_details.dart';
// import 'package:hidmona/Views/Widgets/default_button.dart';
//
// class SelectRecipientScreen extends StatefulWidget {
//   static const String routeName = "/SelectRecipientScreen";
//   Country _selectformCountry;
//   SelectRecipientScreen(this._selectformCountry, {Key? key}) : super(key: key);
//
//   @override
//   _SelectRecipientScreenState createState() => _SelectRecipientScreenState();
// }
//
// class _SelectRecipientScreenState extends State<SelectRecipientScreen> {
//   Country _selectedCountry = CountryPickerUtils.getCountryByCurrencyCode('SE');
//   CommonController controller = Get.find<CommonController>();
//    Country ? _setformCountry;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Align(
//                 alignment: Alignment.topCenter,
//                 child: Image.asset(AppImage.getPath("getStart_top"), height: 314,),
//               ),
//               const SizedBox(height: 20.0),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: Column(
//                   children: [
//                     Text(
//                       'Hidmona',
//                       style: TextStyle(
//                         color: AppColor.defaultColorLight,
//                         fontFamily: 'AkayaTelivigala',
//                         fontWeight: FontWeight.bold,
//                         fontSize: 50,
//                       ),
//                     ),
//                     Text(
//                       'Money Transfer',
//                       style: TextStyle(
//                         color: AppColor.defaultColorLight,
//                         fontFamily: 'AkayaTelivigala',
//                         fontWeight: FontWeight.bold,
//                         fontSize: 25,
//                       ),
//                     ),
//                     const SizedBox(height: 60.0),
//                     Expanded(
//                       child: Container(
//                         alignment: Alignment.bottomCenter,
//                         child: Obx((){
//                           if(controller.serverCountries.isEmpty){
//                             return SpinKitCircle(color: Get.theme.primaryColor,);
//                           }else{
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: <Widget>[
//                                 Text(
//                                   'I\'m sending to',
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(
//                                     color: AppColor.textColor,
//                                     fontSize: 15.0,
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily: 'Roboto',
//                                   ),
//                                 ),
//                                 const SizedBox(height: 7,),
//                                 InkWell(
//                                   onTap: (){
//                                     _openCountryPickerDialog();
//                                   },
//                                   child: Container(
//                                     height: 50,
//                                     clipBehavior: Clip.antiAlias,
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey.withOpacity(.2),
//                                       borderRadius  : BorderRadius.circular(10),
//                                     ),
//                                     child: Row(
//                                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                                       children: [
//                                         Expanded(
//                                           child: Container(padding: const EdgeInsets.only(left: 10),child: CountryItemForRecipientDetails(country: _selectedCountry)),
//                                         ),
//                                         Container(
//                                             padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 20) ,
//                                             decoration: BoxDecoration(
//                                                 gradient: AppGradient.getColorGradient('default')
//                                             ),
//                                             child: const Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,size: 30,)
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 30.0),
//                                 DefaultButton(buttonText: "Get Start", onTap: (){
//                                   Get.to(()=> PaymentProcessScreen(widget._selectformCountry, _selectedCountry));
//                                 },),
//                               ],
//                             );
//                           }
//                         }),
//                       ),
//                     ),
//                     const SizedBox(height: 40.0),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   void _openCountryPickerDialog() => showDialog(
//     context: context,
//     builder: (context) => Theme(
//       data: Theme.of(context).copyWith(primaryColor: AppColor.defaultColor),
//       child: CountryPickerDialog(
//         titlePadding: const EdgeInsets.all(8.0),
//         searchCursorColor: AppColor.defaultColor,
//         searchInputDecoration: const InputDecoration(hintText: 'Search By Country...'),
//         isSearchable: true,
//         title: const Text('Select country',textAlign: TextAlign.center,),
//         onValuePicked: (Country country){
//           setState(() {
//             _selectedCountry = country;
//           });
//         },
//         itemBuilder: (Country country)=>CountryItemForRecipientDetails(country: country),
//         //itemFilter: (c) => (c) => ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
//         //itemFilter: (c) => ['AGO', 'AUS', 'AUT', 'BHR', 'BEL'].contains(c.iso3Code),
//         //itemFilter: (c)=>commonSingleTon.getCountries().map((e) => e.countryCode).contains(c.iso3Code),
//         // priorityList: [
//         //   CountryPickerUtils.getCountryByIsoCode('TR'),
//         //   CountryPickerUtils.getCountryByIsoCode('US'),
//         // ],
//       ),
//     ),
//   );
// }
// //PaymentProcessScreen(widget._selectformCountry, _selectedCountry));