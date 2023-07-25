import 'package:country_currency_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/side_bar.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Cards/Accounts/Account%20Details/account_details.dart';
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/Card%20Activation/active_card.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';

import 'card_confirmation_after_active.dart';

class CardHolderListScreen extends StatefulWidget {
  const CardHolderListScreen({Key? key}) : super(key: key);

  @override
  State<CardHolderListScreen> createState() => _CardHolderListScreenState();
}

class _CardHolderListScreenState extends State<CardHolderListScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  CommonController commonController = Get.find<CommonController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      drawer: NavDrawer(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      const SizedBox(width: 40,),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Image.asset(AppImage.getPath("logo"),width: SizeConfig.screenWidth*.4,),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text("My Cards",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.only(left: 8.0, right: 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const SizedBox(height: 5,),
                        GestureDetector(
                          onTap: () async {
                            Utility.showLoadingDialog();
                            bool value = await commonController.getPersonalAccount(0, 25, commonController.userProfile.value.id!);
                            Get.back();
                            if(value){
                              Get.to(CardConfirmationAfterActiveScreen());
                              //Get.to(const ActiveCardScreen());
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 30,right: 20,top: 20,bottom: 20),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: AppColor.dropdownBoxColor.withOpacity(0.39),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: commonController.personalAccountCard.value.data!.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 15),
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundImage: AssetImage(AppImage.getPath('euro_flag')),
                                      // AssetImage(
                                      //   CountryPickerUtils.getFlagImageAssetPath(commonController.countryFrom.value.isoCode!),
                                      //   package: "country_currency_pickers",),
                                    ),
                                    const SizedBox(height: 5),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("${commonController.personalAccountCard.value.data![index].cardHolder}",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 18,fontWeight: FontWeight.bold),),
                                        const SizedBox(height: 5),
                                        Text(
                                          (commonController.cardStatus.value.state! == "active") ? "${commonController.personalAccountCard.value.data![index].externalId!.substring(0,4)}*****${commonController.personalAccountCard.value.data![index].externalId!.substring(commonController.personalAccountCard.value.data![index].externalId!.length - 4)}" :
                                          "${commonController.personalAccountCard.value.data![index].externalId!.substring(0,6)}*******"
                                          ,style: TextStyle(color: AppColor.defaultTextColor,fontSize: 15,fontWeight: FontWeight.w600),),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  //   (commonController.cardStatus.value.state! == "active") ? const SizedBox(height: 0):  DefaultButton(
                  //   buttonText: "Active Card",
                  //     onTap: () async {
                  //     Utility.showLoadingDialog();
                  //       bool value = await commonController.activeCard(commonController.testID, commonController.personalAccountCard.value.data![0].id!);
                  //       Get.back();
                  //       if(value){
                  //         Get.to(const NewCardDetailsScreen());
                  //         Utility.showSnackBar(commonController.cardActive.value.message!);
                  //       }
                  //     },
                  // ) ,
                  // const SizedBox(height: 15,),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text("Transactions",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 25,fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for(int i = 1; i< 10;i++) CardTransection(index: i),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
