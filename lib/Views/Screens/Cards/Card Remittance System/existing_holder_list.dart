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
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/Card%20Details/Active%20Old%20Card/active_card_from_existing_holder.dart';
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/Crard%20creation/card_holder_info_screen.dart';
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/Card%20Details/my_card_screen.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';


class ExistingCardHolderList extends StatefulWidget {
  const ExistingCardHolderList({Key? key}) : super(key: key);

  @override
  State<ExistingCardHolderList> createState() => _ExistingCardHolderListState();
}

class _ExistingCardHolderListState extends State<ExistingCardHolderList> {
  CommonController commonController = Get.find<CommonController>();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      drawer: NavDrawer(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20, top: 20,bottom: 10),
              child: Row(
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
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text("My Cards",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 20,fontWeight: FontWeight.bold),),
            ),
            
            Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: commonController.personalAccountCard.value.data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(left: 10,),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    commonController.cardIndexNo = index;
                                    print("Card id ${commonController.cardIndexNo}");
                                    Utility.showLoadingDialog();
                                    bool value = await commonController.getPersonalAccountCard(0, 23, commonController.userProfile.value.id!);
                                    if(value){
                                      bool value = await commonController.getPersonalAccount(0,25,commonController.userProfile.value.id!);
                                      if(value){
                                        bool value = await commonController.getCardStatus(commonController.userProfile.value.id!, commonController.personalAccountCard.value.data![index].id!);
                                        Get.back();
                                        if(value){
                                          setState(() {
                                            commonController.cardIndexNo = index;
                                          });
                                          Get.to(()=> (commonController.personalAccountCard.value.data![index].active == "Yes") ?  const MyCardScreen() : const ActiveCardFromExistingHolderScreen());
                                        }
                                      }
                                    } else {
                                      Utility.showSnackBar("value");
                                      Get.to(const MyCardScreen());
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 20,right: 10,top: 10,bottom: 20),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      color: AppColor.dropdownBoxColor.withOpacity(0.39),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                            radius: 35,
                                            backgroundImage: AssetImage(AppImage.getPath('euro_flag'))
                                          // AssetImage(
                                          //   CountryPickerUtils.getFlagImageAssetPath(commonController.countryFrom.value.isoCode!),
                                          //   package: "country_currency_pickers",),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text("${commonController.personalAccountCard.value.data![index].cardHolder}",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 18,fontWeight: FontWeight.bold),),
                                                const SizedBox(height: 5),
                                                Text(
                                                  (commonController.personalAccountCard.value.data![index].active == "Yes") ? "${commonController.personalAccountCard.value.data![index].panFirst6}*****${commonController.personalAccountCard.value.data![index].panLast4}" :
                                                  "${commonController.personalAccountCard.value.data![index].panFirst6 !.substring(0,6)}*******"
                                                  ,style: TextStyle(color: AppColor.defaultTextColor,fontSize: 15,fontWeight: FontWeight.w600),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //const SizedBox(width: 20,),
                            (index == commonController.personalAccountCard.value.data!.length - 1) ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    Utility.showLoadingDialog();
                                    bool value = await commonController.getTitle();
                                    if(value){
                                      bool value = await commonController.getPersonalAccount(0,25,commonController.userProfile.value.id!);
                                      if(value){
                                        if(commonController.getAccountDetails.value.total == 1){
                                          bool value = await commonController.kycUserData();
                                          Get.back();
                                          if(value){
                                            Get.to(const CardHolderInfoScreen());
                                          }
                                        }else {
                                          Utility.showSnackBar("Create Account First");
                                        }
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: 150,
                                    margin: const EdgeInsets.only(left: 10,right: 10),
                                    padding: const EdgeInsets.only(left: 50,right: 50,top: 10,bottom: 10),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      color: AppColor.dropdownBoxColor.withOpacity(0.39),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 80,
                                          width: 80,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: AppColor.defaultColor,
                                              shape: BoxShape.circle
                                          ),
                                          child: Icon(Icons.add_card_outlined, size: 55,color: AppColor.cardColor,)
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                            "Add Card",
                                            style: TextStyle(color: AppColor.defaultTextColor,fontSize: 18,fontWeight: FontWeight.bold)
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ) :
                            const SizedBox(height: 0),
                          ],
                        ),
                      );
                    }
                ),
            ),




            //(commonController.cardStatus.value.state! == "active") ? const SizedBox(height: 10) : const SizedBox(height: 0,),
            // (commonController.cardStatus.value.state! == "active") ? const SizedBox(height: 0):  DefaultButton(
            //     buttonText: "Active Card",
            //   onTap: () {
            //     Get.to(const ActiveCardScreen());
            //   },
            // ) ,

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
            SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
