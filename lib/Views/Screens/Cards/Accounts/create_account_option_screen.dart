import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/side_bar.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Cards/Accounts/New%20Design%20for%20accont%20creat/confirmation_screen.dart';
import 'package:hidmona/Views/Screens/Cards/Accounts/account_holder_info_Screen.dart';
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/Crard%20creation/card_holder_info_screen.dart';
import 'package:hidmona/Views/Widgets/custom_dialogbox.dart';
import 'package:hidmona/Views/Widgets/dashboard_item.dart';

import 'account_screen.dart';

class CreateAccountOptionScreen extends StatefulWidget {
  static const String routeName = "SelectCurrencyScreen";
  const CreateAccountOptionScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountOptionScreen> createState() => _CreateAccountOptionScreenState();
}

class _CreateAccountOptionScreenState extends State<CreateAccountOptionScreen> {
  CommonController commonController = Get.find<CommonController>();
  bool checkAccountType = false;
  String ? country;
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
                      DashboardExploreItem(title: "Create Personal Account",subtitle: "Create your Account here",iconName: "personal_account",
                        onTap: (){
                        for(int i =0; i<commonController.euroCountry.length; i++){
                          if(commonController.euroCountry[i] == commonController.countryFrom.value.isoCode!){
                            print(commonController.countryFrom.value.isoCode!);
                            country = commonController.euroCountry[i];
                            Get.to(const ConfirmationScreen());
                            break;
                          }else {
                            print(commonController.countryFrom.value.isoCode!);
                            //Utility.showSnackBar("Sorry we are not currently offering accounts and cards in your country. Please check back another time.");
                          }
                        }
                        if(country != commonController.countryFrom.value.isoCode!) {
                          DefaultDialogs(context: context).showDialog(title: "Create Personal Account", text: "Sorry we are not currently offering accounts and cards in your country. Please check back another time.",
                          onSubmit: () {
                            Get.back();
                          },
                          onSubmitText: "Ok",
                        );
                        }
                        },
                      ),
                      const SizedBox(height: 10),
                      DashboardExploreItem(title: "Create Company Account",subtitle: "See your Cards here",iconName: "card",
                        onTap: () {
                          // Utility.showLoadingDialog();
                          // bool value = await commonController.getPersonalAccount(0,25,commonController.userProfile.value.id!);
                          // Get.back();
                          // if(value){
                          //   print(commonController.getAccountDetails.value.total);
                          //   Get.to(()=> const AccountScreen());
                          // }
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 15,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
