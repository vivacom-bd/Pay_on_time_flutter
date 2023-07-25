import 'package:flutter/material.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:get/get.dart';
import 'package:hidmona/Utilities/side_bar.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/Card%20Details/Set%20Pin/set_pin_OTP_screen_my_card.dart';
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/Card%20Details/View%20Pin/view_pin_otp_my_card.dart';
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/Card%20Loading/load_card_form.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';

class MyCardScreen extends StatefulWidget {
  static const String routeName = "MyCardScreen";
  const MyCardScreen({Key? key}) : super(key: key);

  @override
  State<MyCardScreen> createState() => _MyCardScreenState();
}

class _MyCardScreenState extends State<MyCardScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  CommonController commonController = Get.find<CommonController>();
  bool hidePinSetButtonChecker = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      drawer: NavDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Card Details",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 20,fontWeight: FontWeight.bold),),
                          const SizedBox(height: 3,),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      margin: const EdgeInsets.only(left: 0),
                      padding: const EdgeInsets.only(left: 8.0, right: 10),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: AppColor.dropdownBoxColor.withOpacity(0.39),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 15),
                                Image.asset(AppImage.getPath("card1"),width: SizeConfig.screenWidth*.2, color: AppColor.defaultColorLight,),
                                const SizedBox(height: 10,),
                                Text("${commonController.personalAccountCard.value.data![commonController.cardIndexNo].panFirst6}*****${commonController.personalAccountCard.value.data![commonController.cardIndexNo].panLast4} | EUR",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 18,fontWeight: FontWeight.bold),),
                                const SizedBox(height: 2),
                                Text("${commonController.personalAccountCard.value.data![commonController.cardIndexNo].cardHolder}",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 20,fontWeight: FontWeight.bold),),
                                const SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Expiration Date: ",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 18,fontWeight: FontWeight.bold),),
                                    Text(commonController.personalAccountCard.value.data![commonController.cardIndexNo].expiry!,style: TextStyle(color: AppColor.defaultTextColor,fontSize: 14,)),

                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Status: ",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 18,fontWeight: FontWeight.bold),),
                                    Text(commonController.cardStatus.value.state!,style: TextStyle(color: AppColor.defaultTextColor,fontSize: 14,fontWeight:FontWeight.bold)),

                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Available Balance : ",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 18,fontWeight: FontWeight.bold),),
                                    Text("${commonController.personalAccountCard.value.data![commonController.cardIndexNo].balance} EUR",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 14, fontWeight: FontWeight.bold)),

                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        Utility.showLoadingDialog();
                                        bool value = await commonController.sendOTP();
                                        Get.back();
                                        if(value){
                                          Get.to(()=> const SetPinOTPScreenMyScreen());
                                        } else {Get.back();}
                                      },
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Set Pin',
                                          style: TextStyle(
                                              color: AppColor.hyperlinkColor,
                                              decoration: TextDecoration.underline,
                                              decorationStyle: TextDecorationStyle.solid,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    GestureDetector(
                                      onTap: ()   async {
                                        Utility.showLoadingDialog();
                                        bool value = await commonController.sendOTP();
                                        Get.back();
                                        if(value){
                                          Get.to(()=> const ViewPinOtpMyCardScreen());
                                        } else {Get.back();}
                                      },
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'View Pin',
                                          style: TextStyle(
                                              color: AppColor.hyperlinkColor,
                                              decoration: TextDecoration.underline,
                                              decorationStyle: TextDecorationStyle.solid,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                GestureDetector(
                                  onTap: (){
                                    //Get.to(()=> const BankAccountDetails());
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'View Card Transaction',
                                      style: TextStyle(
                                          color: AppColor.hyperlinkColor,
                                          decoration: TextDecoration.underline,
                                          decorationStyle: TextDecorationStyle.solid,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                 Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    DefaultButton(buttonText: 'Load Card',onTap: () async {
                                      print("Card id ${commonController.cardIndexNo}");
                                      Utility.showLoadingDialog();
                                      bool value = await commonController.getPersonalAccount(0,25,commonController.userProfile.value.id!);
                                      if(value){
                                        bool value = await commonController.getPersonalAccountCard(0, 23, commonController.userProfile.value.id!);
                                        Get.back();
                                        if(value){
                                          Get.to(()=> const LoadCardForm());
                                        }

                                      }
                                    }),
                                    SizedBox(width: 5),
                                    DefaultButton(
                                      buttonText: "Report as Lost",
                                      onTap: (){
                                        //Get.to(()=> const LoadCardForm());
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
