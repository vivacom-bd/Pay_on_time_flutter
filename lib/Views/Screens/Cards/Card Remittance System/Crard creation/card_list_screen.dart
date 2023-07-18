import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Repositories/api_constants.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/side_bar.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/Crard%20creation/card_holder_info_screen.dart';
import 'package:hidmona/Views/Screens/SendMoney/send_money_screen.dart';
import 'package:hidmona/Views/Widgets/country_item.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';
import 'package:url_launcher/url_launcher.dart';

class CardListScreen extends StatefulWidget {
  static const String routeName = "CardListScreen";
  const CardListScreen({Key? key}) : super(key: key);

  @override
  State<CardListScreen> createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  CommonController controller = Get.find<CommonController>();
  CommonController commonController = Get.find<CommonController>();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      drawer: NavDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 15,),
                Row(
                  children: [
                    IconButton(
                      onPressed: (){
                        _globalKey.currentState?.openDrawer();
                      },
                      icon: Icon(
                        Icons.menu,
                        color: AppColor.defaultColorLight,
                      ),
                    ),
                    const SizedBox(width: 35,),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset(AppImage.getPath("logo"),width: SizeConfig.screenWidth*.4,),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  decoration: BoxDecoration(
                    color: AppColor.dropdownBoxColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          'Sorry, you don\'t have Hidmona Debit Card at the moment. Apply to have one',
                          style: TextStyle(
                            color: AppColor.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      DefaultButton(
                        buttonText: "Apply Now",
                        onTap: () async {
                          Utility.showLoadingDialog();
                          bool value = await commonController.getTitle();
                          Get.back();
                          if(value){
                            Get.to(const CardHolderInfoScreen());
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15,),
                (controller.currentUser.value.kycUserToken !=null && controller.currentUser.value.kycUserToken!.isNotEmpty && controller.currentUser.value.kycApplicationId !=null && controller.currentUser.value.kycApplicationId!.isNotEmpty) ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Divider(thickness: 1,color: AppColor.defaultColor.withOpacity(.5),height: 25,),
                    DefaultButton(buttonText: "Apply for KYC",onTap: ()async{
                      String url = '${kycBaseUrl()}applications/${controller.currentUser.value.kycApplicationId}?access_token=${controller.currentUser.value.kycUserToken}';
                      Uri uri = Uri.parse(url);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri,mode: LaunchMode.externalApplication);
                      }
                    },),
                    Divider(thickness: 1,color: AppColor.defaultColor.withOpacity(.5),height: 25,),
                  ],
                ):const SizedBox(height: 10,),
                const SizedBox(height: 15,),
                Center(
                  child: Text(
                    'Or Send Money',
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
