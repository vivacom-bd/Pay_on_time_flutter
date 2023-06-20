import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Cards/Accounts/account_holder_info_Screen.dart';
import 'package:hidmona/Views/Screens/Cards/card_holder_info_screen.dart';
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
  @override
  Widget build(BuildContext context) {
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
                        for(String country in commonController.euroCountry){
                          if(country == commonController.countryFrom.value.isoCode!){
                            Get.to(const AccountHolderScreen());
                            break;
                          } else {
                            Utility.showSnackBar("Sorry you are not Allow for this");
                          }
                          break;
                        }
                        },
                      ),
                      const SizedBox(height: 10),
                      DashboardExploreItem(title: "Create Company Account",subtitle: "See your Cards here",iconName: "card",
                        onTap: () async {
                           Utility.showLoadingDialog();
                          bool value = await commonController.getPersonalAccount(0,25,commonController.testID);
                          Get.back();
                          if(value){
                            print(commonController.getAccountDetails.value.total);
                            Get.to(()=> const AccountScreen());
                          }
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
