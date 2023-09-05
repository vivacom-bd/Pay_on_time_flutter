import 'package:flutter/material.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:get/get.dart';
import 'package:hidmona/Utilities/side_bar.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/Card%20Loading/New%20Card%20Details/card_details%20showing.dart';
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/Crard%20creation/card_Application_confirmation_screen.dart';
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/Card%20Details/my_card_screen.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';


class LoadCardSuccessful extends StatefulWidget {
  const LoadCardSuccessful({Key? key}) : super(key: key);

  @override
  State<LoadCardSuccessful> createState() => _LoadCardSuccessfulState();
}

class _LoadCardSuccessfulState extends State<LoadCardSuccessful> {
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Loading Card Confirmation",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 20,fontWeight: FontWeight.bold),),
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
                          padding: const EdgeInsets.only(left: 20,right: 20,top: 30,bottom: 20),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: AppColor.dropdownBoxColor.withOpacity(0.39),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Your card has been loaded with funds successfully!",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 15,fontWeight: FontWeight.bold),),
                              const SizedBox(height: 25),
                              DefaultButton(
                                buttonText: "View card details",
                                onTap: () async {
                                  Utility.showLoadingDialog();
                                  bool value = await commonController.getPersonalAccountCard(0,25,commonController.userProfile.value.id!);
                                  if(value){
                                    bool value = await commonController.getPersonalAccountCard(0, 23, commonController.userProfile.value.id!);
                                    Get.back();
                                    if(value){
                                      Get.to(()=> const CardDetailsScreen());
                                      //Get.to(()=> const CardConfirmationScreen());
                                    }
                                  }

                                },
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
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
