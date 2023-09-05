import 'package:country_currency_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/side_bar.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Cards/Accounts/Account%20Details/account_details.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';

class ViewAccountDetailsScreen extends StatefulWidget {
  const ViewAccountDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ViewAccountDetailsScreen> createState() => _ViewAccountDetailsScreenState();
}

class _ViewAccountDetailsScreenState extends State<ViewAccountDetailsScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  CommonController commonController = Get.find<CommonController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      drawer: NavDrawer(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                      const SizedBox(width: 35,),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Image.asset(AppImage.getPath("logo"),width: SizeConfig.screenWidth*.4,),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0,right: 10),
                    child: Text( "Congratulations! You have successfully opened a personal account. Please use the button below to see account details.",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 15,),),
                  ),
                  const SizedBox(height: 30,),
                  DefaultButton(
                    buttonText: "View Account Details",
                    onTap: () async {
                      Utility.showLoadingDialog();
                      bool value = await commonController.getPersonalAccount(0,25,commonController.userProfile.value.id!);
                      Get.back();
                      if(value){
                        Get.to(()=> const AccountDetails());
                      }
                      //Get.to(const AccountScreen());
                    },
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
